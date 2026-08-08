import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../state/exam_mode.dart';

/// Provider-agnostic chat client speaking the OpenAI `/chat/completions`
/// wire format. Works unchanged against OpenRouter, Groq, Cerebras, Together,
/// Fireworks, or a self-hosted Ollama / vLLM endpoint — only the base URL,
/// model id, and key change.
///
/// The user supplies their own (free) key in Settings; nothing is shipped.
class LlmService {
  LlmService({
    required this.apiKey,
    required this.baseUrl,
    required this.model,
    required this.exam,
  });

  final String apiKey;
  final String baseUrl;
  final String model;
  final Exam exam;

  /// Rolling conversation history (OpenAI message maps). Kept bounded so a
  /// long chat never blows past a model's context window.
  final List<Map<String, String>> _history = [];

  bool get ready => apiKey.isNotEmpty;

  String get _systemPrompt =>
      'You are Sira, a friendly and concise '
      '${exam == Exam.ielts ? "IELTS Academic" : "TOEFL iBT"} coach helping a '
      'student prepare for the test. Always answer in clear, concrete steps. '
      'Cite the relevant test section when useful (Reading, Listening, '
      'Speaking, Writing). Keep paragraphs short. When asked for examples or '
      'vocabulary, give exactly the number requested. Do not invent '
      'statistics. Never claim to access the student\'s private data unless '
      'it is provided to you in the message.';

  Uri get _endpoint {
    final base = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    return Uri.parse('$base/chat/completions');
  }

  Map<String, String> get _headers => {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
        // OpenRouter uses these for attribution/rankings; harmless elsewhere.
        'HTTP-Referer': 'https://toeflsix.app',
        'X-Title': 'TOEFLsix',
      };

  Future<String> _post(List<Map<String, String>> messages,
      {double temperature = 0.6}) async {
    if (!ready) throw StateError('API key not set');
    final res = await http
        .post(
          _endpoint,
          headers: _headers,
          body: jsonEncode({
            'model': model,
            'messages': messages,
            'temperature': temperature,
          }),
        )
        .timeout(const Duration(seconds: 45));

    if (res.statusCode != 200) {
      // Surface a short, friendly slice of the provider error.
      String detail = res.body;
      try {
        final j = jsonDecode(res.body);
        detail = (j['error']?['message'] ?? detail).toString();
      } catch (_) {}
      throw Exception('${res.statusCode}: $detail');
    }

    final data = jsonDecode(utf8.decode(res.bodyBytes));
    final choices = data['choices'] as List<dynamic>?;
    if (choices == null || choices.isEmpty) return '';
    return ((choices.first['message']?['content']) as String?)?.trim() ?? '';
  }

  /// Multi-turn chat used by the Sira tab. Maintains history internally.
  Future<String> send(String userMessage) async {
    _history.add({'role': 'user', 'content': userMessage});
    final messages = [
      {'role': 'system', 'content': _systemPrompt},
      ..._history,
    ];
    final reply = await _post(messages);
    _history.add({'role': 'assistant', 'content': reply});
    // Keep only the last ~16 turns.
    if (_history.length > 16) {
      _history.removeRange(0, _history.length - 16);
    }
    return reply;
  }

  /// One-shot completion with no shared history — used for writing analysis
  /// and progress suggestions.
  Future<String> complete({
    required String system,
    required String user,
    double temperature = 0.4,
  }) {
    return _post([
      {'role': 'system', 'content': system},
      {'role': 'user', 'content': user},
    ], temperature: temperature);
  }

  void reset() => _history.clear();
}
