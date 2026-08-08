import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/exam_mode.dart';
import '../../state/settings_state.dart';
import '../../state/user_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glow_button.dart';
import '../../widgets/icon_tile.dart';
import '../../widgets/segment_pills.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _apiKey;
  late final TextEditingController _model;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserState>();
    final settings = context.read<SettingsState>();
    _name = TextEditingController(text: user.name);
    _email = TextEditingController(text: user.email);
    _apiKey = TextEditingController(text: settings.llmApiKey);
    _model = TextEditingController(text: settings.llmModel);
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _apiKey.dispose();
    _model.dispose();
    super.dispose();
  }

  Future<void> _confirmReset() async {
    final exam = context.read<ExamModeState>().exam;
    final ok = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (_) => Theme(
        data: Theme.of(context),
        child: AlertDialog(
          backgroundColor: context.c.bgSoft,
          title: Text('Reset ${exam.label} progress?',
              style: TextStyle(color: context.c.text)),
          content: Text(
            'This clears saved practice, mock history, and resume state for the currently selected exam only.',
            style: TextStyle(color: context.c.textMuted),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: AppPalette.accentDanger),
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
    if (ok == true && mounted) {
      context.read<UserState>().resetExam(exam);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${exam.label} progress cleared.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final settings = context.watch<SettingsState>();
    final exam = context.watch<ExamModeState>();

    return Scaffold(
      backgroundColor: context.c.bg,
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).maybePop(),
                      icon: Icon(Icons.close_rounded,
                          color: context.c.text),
                    ),
                    Text('Settings', style: t.titleLarge),
                  ],
                ),
              ),

              // Account
              GlassCard(
                tint: GlassTints.forIndex(3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const IconTile(
                            icon: Icons.shield_outlined,
                            color: AppPalette.brandBlue),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Account', style: t.headlineMedium),
                              const SizedBox(height: 6),
                              Text(
                                'Sign-in keeps your coaching and cloud-ready identity consistent across sessions.',
                                style: t.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    GlowButton(
                      label: 'Continue with Google',
                      icon: Icons.cloud_outlined,
                      expand: true,
                      // Real Google sign-in is out of scope for the debug
                      // build; the button is wired for the future.
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Google sign-in arrives with the next signed release.')),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Profile
              GlassCard(
                tint: GlassTints.forIndex(2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const IconTile(
                            icon: Icons.person_outline,
                            color: AppPalette.brandBlue),
                        const SizedBox(width: 12),
                        Text('Profile', style: t.headlineMedium),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('DISPLAY NAME', style: t.labelSmall),
                    const SizedBox(height: 8),
                    _glassField(
                      controller: _name,
                      hint: 'Your name',
                      onChanged: (v) => context.read<UserState>().setName(v),
                    ),
                    const SizedBox(height: 14),
                    Text('EMAIL', style: t.labelSmall),
                    const SizedBox(height: 8),
                    _glassField(
                      controller: _email,
                      hint: 'optional@example.com',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (v) => context.read<UserState>().setEmail(v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Exam + Appearance + Language
              GlassCard(
                tint: GlassTints.forIndex(1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('EXAM', style: t.labelSmall),
                    const SizedBox(height: 6),
                    Text('Switch any time — your progress is saved per exam.',
                        style: t.bodyMedium),
                    const SizedBox(height: 12),
                    SegmentPills<Exam>(
                      items: const [
                        (value: Exam.toefl, label: 'TOEFL'),
                        (value: Exam.ielts, label: 'IELTS'),
                      ],
                      selected: exam.exam,
                      onChanged: (v) => exam.set(v),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        const Icon(Icons.palette_outlined,
                            color: AppPalette.brandBlue, size: 18),
                        const SizedBox(width: 8),
                        Text('APPEARANCE', style: t.labelSmall),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SegmentPills<ThemeMode>(
                      items: const [
                        (value: ThemeMode.system, label: 'Match system'),
                        (value: ThemeMode.dark, label: 'Dark'),
                        (value: ThemeMode.light, label: 'Light'),
                      ],
                      selected: settings.themeMode,
                      onChanged: settings.setTheme,
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        const Icon(Icons.nightlight_outlined,
                            color: AppPalette.accentSira, size: 18),
                        const SizedBox(width: 8),
                        Text('DISPLAY LANGUAGE', style: t.labelSmall),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SegmentPills<Locale?>(
                      items: const [
                        (value: Locale('en'), label: 'English'),
                        (value: Locale('fr'), label: 'Français'),
                        (value: Locale('tr'), label: 'Türkçe'),
                      ],
                      selected: settings.locale ?? const Locale('en'),
                      onChanged: settings.setLocale,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // AI provider (free, open-source models)
              GlassCard(
                tint: GlassTints.forIndex(2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const IconTile(
                            icon: Icons.auto_awesome_outlined,
                            color: AppPalette.accentSira),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text('Sira AI Coach', style: t.headlineMedium),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Sira runs on free, open-source models. Pick a provider, '
                      'create a free key, and paste it below. The key is stored '
                      'only on this device.',
                      style: t.bodyMedium,
                    ),
                    const SizedBox(height: 14),
                    Text('PROVIDER', style: t.labelSmall),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final p in LlmPreset.presets)
                          _ProviderChip(
                            label: p.label,
                            selected: settings.activePreset?.id == p.id,
                            onTap: () {
                              settings.applyPreset(p);
                              _model.text = p.defaultModel;
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Builder(builder: (context) {
                      final p = settings.activePreset;
                      if (p == null) return const SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          '${p.note}  Get a free key at ${p.keyUrl}',
                          style: t.bodySmall?.copyWith(height: 1.4),
                        ),
                      );
                    }),
                    const SizedBox(height: 14),
                    Text('API KEY', style: t.labelSmall),
                    const SizedBox(height: 8),
                    _glassField(
                      controller: _apiKey,
                      hint: 'paste your free key…',
                      obscure: true,
                      onChanged: settings.setLlmApiKey,
                    ),
                    const SizedBox(height: 14),
                    Text('MODEL', style: t.labelSmall),
                    const SizedBox(height: 8),
                    _glassField(
                      controller: _model,
                      hint: 'model id',
                      onChanged: settings.setLlmModel,
                    ),
                    if (settings.hasLlmKey) ...[
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.check_circle,
                              color: AppPalette.accentSuccess, size: 16),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'Key saved. Sira will use ${settings.llmModel}.',
                              style: t.bodySmall
                                  ?.copyWith(color: AppPalette.accentSuccess),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Danger zone
              GlassCard(
                tint: const Color(0x30FF6F6F),
                borderColor: AppPalette.accentDanger.withOpacity(0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded,
                            color: AppPalette.accentDanger),
                        const SizedBox(width: 8),
                        Text('Danger zone',
                            style: t.headlineMedium
                                ?.copyWith(color: context.c.text)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This clears saved practice, mock history, and the resume state for the currently selected exam only.',
                      style: t.bodyMedium,
                    ),
                    const SizedBox(height: 14),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GlowButton(
                        label: 'Reset progress for this exam',
                        icon: Icons.delete_outline,
                        danger: true,
                        onPressed: _confirmReset,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              Center(
                child: Text(
                  'TOEFLsix · v1.0.0',
                  style: t.labelSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassField({
    required TextEditingController controller,
    String? hint,
    bool obscure = false,
    TextInputType? keyboardType,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: TextStyle(color: context.c.text, fontSize: 15),
      cursorColor: AppPalette.brandBlue,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: context.c.textFaint),
        filled: true,
        fillColor: context.c.bg.withOpacity(0.55),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: context.c.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: context.c.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppPalette.brandBlue, width: 1.4),
        ),
      ),
    );
  }
}

class _ProviderChip extends StatelessWidget {
  const _ProviderChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: shape,
            color: selected
                ? AppPalette.accentSira.withOpacity(0.18)
                : context.c.glassFill,
            border: Border.all(
              color: selected
                  ? AppPalette.accentSira.withOpacity(0.6)
                  : context.c.border,
              width: selected ? 1.4 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected) ...[
                const Icon(Icons.check_rounded,
                    size: 15, color: AppPalette.accentSira),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: selected ? AppPalette.accentSira : context.c.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
