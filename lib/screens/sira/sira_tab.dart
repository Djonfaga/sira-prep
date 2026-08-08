import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../state/entitlements.dart';
import '../../state/exam_mode.dart';
import '../../state/settings_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/icon_tile.dart';
import '../paywall_screen.dart';
import '../settings/settings_screen.dart';
import 'llm_service.dart';

class SiraTab extends StatefulWidget {
  const SiraTab({super.key});

  @override
  State<SiraTab> createState() => _SiraTabState();
}

class _Message {
  _Message({required this.role, required this.text, this.thinking = false});
  final String role; // 'user' | 'sira'
  String text;
  bool thinking;
}

class _SiraTabState extends State<SiraTab> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  final List<_Message> _messages = [];
  final _stt = stt.SpeechToText();
  bool _sttReady = false;
  bool _listening = false;
  LlmService? _svc;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _sttReady = await _stt.initialize(onStatus: (s) {
      if (s == 'done' || s == 'notListening') {
        setState(() => _listening = false);
      }
    });
    setState(() {});
  }

  LlmService _service(BuildContext context) {
    final settings = context.read<SettingsState>();
    final key = settings.llmApiKey;
    final baseUrl = settings.llmBaseUrl;
    final model = settings.llmModel;
    final exam = context.read<ExamModeState>().exam;
    if (_svc == null ||
        _svc!.apiKey != key ||
        _svc!.baseUrl != baseUrl ||
        _svc!.model != model ||
        _svc!.exam != exam) {
      _svc = LlmService(
          apiKey: key, baseUrl: baseUrl, model: model, exam: exam);
    }
    return _svc!;
  }

  Future<void> _send([String? prefilled]) async {
    final text = (prefilled ?? _input.text).trim();
    if (text.isEmpty) return;

    // The free tier includes a lifetime allowance of coach messages. Checked
    // before the request is built so a capped user never burns an API call.
    final ent = context.read<Entitlements>();
    if (!ent.canSendAiMessage) {
      await PaywallScreen.show(context, trigger: PaywallTrigger.aiLimit);
      return;
    }

    final svc = _service(context);
    if (!svc.ready) {
      _showApiKeyHint();
      return;
    }
    ent.registerAiMessage();
    _input.clear();
    final placeholder = _Message(role: 'sira', text: '', thinking: true);
    setState(() {
      _messages.add(_Message(role: 'user', text: text));
      _messages.add(placeholder);
    });
    _jumpToBottom();
    try {
      final reply = await svc.send(text);
      setState(() {
        placeholder.text = reply.isEmpty ? '(empty reply)' : reply;
        placeholder.thinking = false;
      });
    } catch (e) {
      setState(() {
        placeholder.text = 'Sira hit an error: $e';
        placeholder.thinking = false;
      });
    }
    _jumpToBottom();
  }

  void _jumpToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(_scroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 220), curve: Curves.easeOut);
      }
    });
  }

  Future<void> _toggleMic() async {
    if (!_sttReady) return;
    if (_listening) {
      _stt.stop();
      setState(() => _listening = false);
    } else {
      setState(() => _listening = true);
      _stt.listen(onResult: (r) {
        setState(() => _input.text = r.recognizedWords);
      });
    }
  }

  void _showApiKeyHint() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Add a free AI API key in Settings to chat with Sira.'),
        action: SnackBarAction(
          label: 'Settings',
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          ),
        ),
      ),
    );
  }

  void _showLiveHint() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Live voice mode is coming in the next release — text and mic input work today.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final exam = context.watch<ExamModeState>().exam;
    final hasKey = context.watch<SettingsState>().hasLlmKey;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
          child: GlassCard(
            tint: GlassTints.forIndex(2),
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                const IconTile(
                  icon: Icons.auto_awesome,
                  color: AppPalette.accentSira,
                  size: 44,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sira',
                          style: t.headlineMedium?.copyWith(fontSize: 22)),
                      Text('${exam.label} COACH · C1', style: t.labelSmall),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: _messages.isEmpty
              ? _EmptyState(
                  exam: exam.label,
                  hasKey: hasKey,
                  onPrompt: _send,
                  onOpenSettings: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  ),
                )
              : ListView.builder(
                  controller: _scroll,
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  itemCount: _messages.length,
                  itemBuilder: (_, i) => _Bubble(message: _messages[i]),
                ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
          child: GlassCard(
            tint: GlassTints.forIndex(1),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _input,
                    style: TextStyle(color: context.c.text, fontSize: 15),
                    cursorColor: AppPalette.brandBlue,
                    minLines: 1,
                    maxLines: 5,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _send(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Message Sira…',
                      hintStyle: TextStyle(color: context.c.textFaint),
                    ),
                  ),
                ),
                _IconPill(icon: Icons.podcasts_rounded, label: 'Live', onTap: _showLiveHint),
                const SizedBox(width: 6),
                _IconPill(
                  icon: _listening ? Icons.stop_rounded : Icons.mic_none_outlined,
                  label: _listening ? 'Stop' : 'Mic',
                  onTap: _sttReady ? _toggleMic : null,
                ),
                const SizedBox(width: 6),
                _SendButton(onTap: _input.text.trim().isEmpty ? null : () => _send()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.exam,
    required this.hasKey,
    required this.onPrompt,
    required this.onOpenSettings,
  });
  final String exam;
  final bool hasKey;
  final ValueChanged<String> onPrompt;
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final suggestions = [
      'Diagnose my biggest weakness based on my stats.',
      'Give me 3 tips to improve my speaking score.',
      'Explain integrated writing structure with an example.',
      'Quiz me on 5 advanced vocabulary words.',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GlassCard(
        tint: GlassTints.forIndex(2),
        padding: const EdgeInsets.fromLTRB(22, 24, 22, 22),
        child: Column(
          children: [
            const Icon(Icons.auto_awesome,
                color: AppPalette.brandBlue, size: 30),
            const SizedBox(height: 14),
            Text('What do you want to work on?',
                style: t.headlineMedium, textAlign: TextAlign.center),
            const SizedBox(height: 6),
            Text(
              'Ask anything about $exam — strategy, vocabulary, mock-test feedback.',
              style: t.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (!hasKey)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppPalette.accentWarn.withValues(alpha: 0.10),
                    border: Border.all(
                        color: AppPalette.accentWarn.withValues(alpha: 0.4)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.key_outlined,
                          color: AppPalette.accentWarn, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Add a free AI API key in Settings to start chatting.',
                          style: t.bodySmall?.copyWith(
                              color: context.c.text),
                        ),
                      ),
                      TextButton(
                        onPressed: onOpenSettings,
                        child: const Text('Open'),
                      ),
                    ],
                  ),
                ),
              ),
            for (final s in suggestions) ...[
              _SuggestionPill(label: s, onTap: () => onPrompt(s)),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }
}

class _SuggestionPill extends StatelessWidget {
  const _SuggestionPill({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final shape = BorderRadius.circular(999);
    return Material(
      color: Colors.transparent,
      borderRadius: shape,
      child: InkWell(
        onTap: onTap,
        borderRadius: shape,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: shape,
            color: Colors.white.withValues(alpha: 0.04),
            border: Border.all(color: context.c.border),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: context.c.text,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          ),
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message});
  final _Message message;
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final isUser = message.role == 'user';
    final align = isUser ? MainAxisAlignment.end : MainAxisAlignment.start;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: align,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            const IconTile(
                icon: Icons.auto_awesome,
                color: AppPalette.accentSira,
                size: 32,
                iconScale: 0.5),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 320),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
                color: isUser
                    ? AppPalette.brandBlue.withValues(alpha: 0.20)
                    : Colors.white.withValues(alpha: 0.04),
                border: Border.all(
                  color: isUser
                      ? AppPalette.brandBlue.withValues(alpha: 0.55)
                      : context.c.border,
                ),
              ),
              child: message.thinking
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppPalette.brandBlue),
                        ),
                        const SizedBox(width: 8),
                        Text('Sira is thinking…',
                            style: TextStyle(
                                color: context.c.textMuted,
                                fontStyle: FontStyle.italic)),
                      ],
                    )
                  : Text(message.text,
                      style: t.bodyMedium?.copyWith(
                          color: context.c.text, height: 1.45)),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconPill extends StatelessWidget {
  const _IconPill({required this.icon, required this.label, this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final shape = BorderRadius.circular(999);
    final disabled = onTap == null;
    return Material(
      color: Colors.transparent,
      borderRadius: shape,
      child: InkWell(
        onTap: onTap,
        borderRadius: shape,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: shape,
            color: Colors.white.withValues(alpha: 0.04),
            border: Border.all(color: context.c.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,
                  size: 16,
                  color: disabled ? context.c.textFaint : context.c.text),
              const SizedBox(width: 4),
              Text(label,
                  style: TextStyle(
                      color: disabled
                          ? context.c.textFaint
                          : context.c.text,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: disabled
                  ? [Colors.white12, Colors.white10]
                  : const [Color(0xFFB7D3FF), AppPalette.brandBlue],
            ),
            boxShadow: disabled
                ? []
                : [
                    BoxShadow(
                      color: AppPalette.brandBlue.withValues(alpha: 0.5),
                      blurRadius: 14,
                      spreadRadius: -2,
                    ),
                  ],
          ),
          child: const Icon(Icons.arrow_upward_rounded,
              color: Color(0xFF0A1430), size: 18),
        ),
      ),
    );
  }
}
