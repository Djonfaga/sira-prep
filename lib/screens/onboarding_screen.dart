import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/exam_mode.dart';
import '../state/user_state.dart';
import '../theme/app_theme.dart';
import '../widgets/app_background.dart';
import '../widgets/glass_card.dart';
import '../widgets/glow_button.dart';
import '../widgets/segment_pills.dart';
import 'shell.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _name = TextEditingController();
  Exam _exam = Exam.toefl;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _start() {
    final name = _name.text.trim();
    if (name.isEmpty) return;
    context.read<ExamModeState>().set(_exam);
    context.read<UserState>().completeOnboarding(name: name);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const AppShell()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: context.c.bg,
      body: AppBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFB7D3FF), AppPalette.brandBlue],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppPalette.brandBlue.withOpacity(0.55),
                          blurRadius: 32,
                          spreadRadius: -4,
                        ),
                      ],
                      border: Border.all(color: Colors.white.withOpacity(0.25)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset('assets/icon.png', fit: BoxFit.cover),
                    ),
                  ).center(),
                  const SizedBox(height: 24),
                  Text('Welcome to Sira Prep',
                      style: t.displayMedium, textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Text(
                    'Coaching, drills, and full mock exams for TOEFL iBT and IELTS Academic.',
                    style: t.bodyLarge?.copyWith(color: context.c.textMuted),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  GlassCard(
                    tint: const Color(0x404F8AF6),
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('YOUR NAME', style: t.labelSmall),
                        const SizedBox(height: 10),
                        _GlassTextField(
                          controller: _name,
                          hint: 'How should we call you?',
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _start(),
                        ),
                        const SizedBox(height: 22),
                        Text('CHOOSE YOUR EXAM', style: t.labelSmall),
                        const SizedBox(height: 10),
                        SegmentPills<Exam>(
                          items: const [
                            (value: Exam.toefl, label: 'TOEFL'),
                            (value: Exam.ielts, label: 'IELTS'),
                          ],
                          selected: _exam,
                          onChanged: (v) => setState(() => _exam = v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  GlowButton(
                    label: 'Start learning',
                    icon: Icons.arrow_forward_rounded,
                    expand: true,
                    onPressed: _name.text.trim().isEmpty ? () => _start() : _start,
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      _name.text = 'Scholar';
                      _start();
                    },
                    child: Text(
                      'Skip for now',
                      style: TextStyle(color: context.c.textMuted),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassTextField extends StatelessWidget {
  const _GlassTextField({
    required this.controller,
    this.hint,
    this.textInputAction,
    this.onSubmitted,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String? hint;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: context.c.text, fontSize: 16),
      cursorColor: AppPalette.brandBlue,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: context.c.textFaint),
        filled: true,
        fillColor: context.c.bg.withOpacity(0.55),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
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

extension on Widget {
  Widget center() => Align(alignment: Alignment.center, child: this);
}
