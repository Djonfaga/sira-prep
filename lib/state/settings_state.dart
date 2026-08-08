import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A one-tap provider preset. All of these expose an OpenAI-compatible
/// /chat/completions endpoint, so only the base URL and default model differ.
class LlmPreset {
  const LlmPreset({
    required this.id,
    required this.label,
    required this.baseUrl,
    required this.defaultModel,
    required this.keyUrl,
    required this.note,
  });

  final String id;
  final String label;
  final String baseUrl;
  final String defaultModel;
  final String keyUrl; // where to get a free key
  final String note;

  static const openrouter = LlmPreset(
    id: 'openrouter',
    label: 'OpenRouter',
    baseUrl: 'https://openrouter.ai/api/v1',
    defaultModel: 'meta-llama/llama-3.3-70b-instruct:free',
    keyUrl: 'openrouter.ai/keys',
    note: 'Free models, one key for 300+ models. Best all-rounder.',
  );

  static const groq = LlmPreset(
    id: 'groq',
    label: 'Groq',
    baseUrl: 'https://api.groq.com/openai/v1',
    defaultModel: 'llama-3.3-70b-versatile',
    keyUrl: 'console.groq.com/keys',
    note: 'Fastest responses. Generous free tier, no card needed.',
  );

  static const cerebras = LlmPreset(
    id: 'cerebras',
    label: 'Cerebras',
    baseUrl: 'https://api.cerebras.ai/v1',
    defaultModel: 'llama-3.3-70b',
    keyUrl: 'cloud.cerebras.ai',
    note: 'Highest free daily volume (1M tokens/day).',
  );

  static const presets = [openrouter, groq, cerebras];

  static LlmPreset? byBaseUrl(String url) {
    for (final p in presets) {
      if (p.baseUrl == url) return p;
    }
    return null;
  }
}

class SettingsState extends ChangeNotifier {
  SettingsState(this._prefs);

  final SharedPreferences _prefs;
  static const _themeKey = 'settings.theme';
  static const _localeKey = 'settings.locale';
  // Legacy key used by the original Gemini build — migrated on first load.
  static const _legacyKeyKey = 'settings.gemini_api_key';
  static const _apiKeyKey = 'settings.llm_api_key';
  static const _baseUrlKey = 'settings.llm_base_url';
  static const _modelKey = 'settings.llm_model';

  ThemeMode _themeMode = ThemeMode.dark;
  Locale? _locale;
  String _apiKey = '';
  String _baseUrl = LlmPreset.openrouter.baseUrl;
  String _model = LlmPreset.openrouter.defaultModel;

  ThemeMode get themeMode => _themeMode;
  Locale? get locale => _locale;

  String get llmApiKey => _apiKey;
  String get llmBaseUrl => _baseUrl;
  String get llmModel => _model;
  bool get hasLlmKey => _apiKey.isNotEmpty;

  /// The preset that matches the current base URL, or null for a custom URL.
  LlmPreset? get activePreset => LlmPreset.byBaseUrl(_baseUrl);

  static const supportedLocales = [
    Locale('en'),
    Locale('fr'),
    Locale('tr'),
  ];

  void load() {
    final t = _prefs.getString(_themeKey);
    if (t == 'light') {
      _themeMode = ThemeMode.light;
    } else if (t == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
    final l = _prefs.getString(_localeKey);
    if (l != null && l.isNotEmpty) _locale = Locale(l);

    // Prefer the new key; fall back to (and migrate) the legacy Gemini key.
    _apiKey = _prefs.getString(_apiKeyKey) ??
        _prefs.getString(_legacyKeyKey) ??
        '';
    _baseUrl = _prefs.getString(_baseUrlKey) ?? LlmPreset.openrouter.baseUrl;
    _model = _prefs.getString(_modelKey) ?? LlmPreset.openrouter.defaultModel;
  }

  void setTheme(ThemeMode mode) {
    if (mode == _themeMode) return;
    _themeMode = mode;
    final v = mode == ThemeMode.system
        ? 'system'
        : (mode == ThemeMode.light ? 'light' : 'dark');
    _prefs.setString(_themeKey, v);
    notifyListeners();
  }

  void setLocale(Locale? locale) {
    _locale = locale;
    if (locale == null) {
      _prefs.remove(_localeKey);
    } else {
      _prefs.setString(_localeKey, locale.languageCode);
    }
    notifyListeners();
  }

  void setLlmApiKey(String key) {
    _apiKey = key.trim();
    _prefs.setString(_apiKeyKey, _apiKey);
    notifyListeners();
  }

  void setLlmModel(String model) {
    _model = model.trim();
    _prefs.setString(_modelKey, _model);
    notifyListeners();
  }

  void setLlmBaseUrl(String url) {
    _baseUrl = url.trim();
    _prefs.setString(_baseUrlKey, _baseUrl);
    notifyListeners();
  }

  /// Apply a provider preset: sets the base URL and a sensible default model.
  void applyPreset(LlmPreset preset) {
    _baseUrl = preset.baseUrl;
    _model = preset.defaultModel;
    _prefs.setString(_baseUrlKey, _baseUrl);
    _prefs.setString(_modelKey, _model);
    notifyListeners();
  }
}
