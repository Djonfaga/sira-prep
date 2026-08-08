import 'package:flutter/material.dart';

import '../data/grammar_guide.dart';
import '../theme/app_theme.dart';

/// Lightweight diagrams that ride next to grammar rules. Each one is a
/// pure-paint Flutter widget — no external assets — so the explanation
/// scales with the user's font and dark/light theme.
class GrammarVisualWidget extends StatelessWidget {
  const GrammarVisualWidget({super.key, required this.kind});
  final GrammarVisual kind;

  @override
  Widget build(BuildContext context) {
    switch (kind) {
      case GrammarVisual.tenseTimeline:
        return const _TenseTimeline();
      case GrammarVisual.conditionalFlow:
        return const _ConditionalFlow();
      case GrammarVisual.parallelismLines:
        return const _ParallelismLines();
      case GrammarVisual.none:
        return const SizedBox.shrink();
    }
  }
}

// ── Tense timeline ─────────────────────────────────────────────────────────
class _TenseTimeline extends StatelessWidget {
  const _TenseTimeline();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 16, 14, 12),
      decoration: BoxDecoration(
        color: context.c.glassFill,
        border: Border.all(color: context.c.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('TIME × ASPECT',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                  color: context.c.textFaint)),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: CustomPaint(
              painter: _TimelinePainter(
                axisColor: context.c.borderStrong,
                labelColor: context.c.text,
                mutedColor: context.c.textMuted,
                tickColor: AppPalette.brandBlue,
                glow: isDark
                    ? AppPalette.brandBlue.withOpacity(0.7)
                    : AppPalette.brandBlue.withOpacity(0.6),
              ),
              size: Size.infinite,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: const [
              _Legend(label: 'simple', color: AppPalette.brandBlue),
              _Legend(label: 'continuous', color: AppPalette.accentSira),
              _Legend(label: 'perfect', color: AppPalette.accentSuccess),
              _Legend(label: 'perfect continuous', color: AppPalette.accentWarn),
            ],
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.label, required this.color});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 11, color: context.c.textMuted)),
      ],
    );
  }
}

class _TimelinePainter extends CustomPainter {
  _TimelinePainter({
    required this.axisColor,
    required this.labelColor,
    required this.mutedColor,
    required this.tickColor,
    required this.glow,
  });
  final Color axisColor;
  final Color labelColor;
  final Color mutedColor;
  final Color tickColor;
  final Color glow;

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height * 0.55;
    final axisPaint = Paint()
      ..color = axisColor
      ..strokeWidth = 2;
    canvas.drawLine(
        Offset(8, centerY), Offset(size.width - 8, centerY), axisPaint);

    // Arrow head on the right.
    final arrow = Path()
      ..moveTo(size.width - 8, centerY - 5)
      ..lineTo(size.width - 2, centerY)
      ..lineTo(size.width - 8, centerY + 5)
      ..close();
    canvas.drawPath(arrow, axisPaint..style = PaintingStyle.fill);

    // Tick marks for past / now / future.
    final tickPaint = Paint()
      ..color = mutedColor
      ..strokeWidth = 1.5;
    final positions = [
      MapEntry('PAST', size.width * 0.18),
      MapEntry('NOW', size.width * 0.5),
      MapEntry('FUTURE', size.width * 0.82),
    ];
    for (final p in positions) {
      canvas.drawLine(Offset(p.value, centerY - 6),
          Offset(p.value, centerY + 6), tickPaint);
      _drawText(canvas, p.key, Offset(p.value, centerY + 12),
          color: mutedColor, fontSize: 10, weight: FontWeight.w700);
    }

    // The four aspect bands above the line, color-coded.
    void drawSpan(double leftPct, double rightPct, double yOffset, Color color,
        String label) {
      final left = size.width * leftPct;
      final right = size.width * rightPct;
      final y = centerY - yOffset;
      final paint = Paint()
        ..shader = LinearGradient(
          colors: [color.withOpacity(0.0), color, color.withOpacity(0.0)],
        ).createShader(Rect.fromLTWH(left, y - 4, right - left, 8));
      canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(left, y - 2, right - left, 4),
            const Radius.circular(2)),
        paint,
      );
      _drawText(canvas, label, Offset(left, y - 14),
          color: color, fontSize: 10, weight: FontWeight.w700, align: TextAlign.left);
    }

    drawSpan(0.05, 0.42, 18, AppPalette.brandBlue, 'past simple');
    drawSpan(0.42, 0.6, 18, AppPalette.brandBlue, 'present');
    drawSpan(0.6, 0.95, 18, AppPalette.brandBlue, 'future');

    drawSpan(0.08, 0.4, 36, AppPalette.accentSira, 'continuous');
    drawSpan(0.42, 0.62, 36, AppPalette.accentSira, 'is doing');
    drawSpan(0.62, 0.95, 36, AppPalette.accentSira, 'will be doing');

    drawSpan(0.32, 0.5, 54, AppPalette.accentSuccess, 'has done');
    drawSpan(0.5, 0.7, 54, AppPalette.accentSuccess, 'will have done');

    // "Now" marker
    final nowDotPaint = Paint()..color = tickColor;
    canvas.drawCircle(Offset(size.width * 0.5, centerY), 5, nowDotPaint);
    final glowPaint = Paint()
      ..color = glow
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(Offset(size.width * 0.5, centerY), 7, glowPaint);
  }

  void _drawText(Canvas canvas, String text, Offset pos,
      {required Color color,
      required double fontSize,
      FontWeight weight = FontWeight.w500,
      TextAlign align = TextAlign.center}) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style:
            TextStyle(color: color, fontSize: fontSize, fontWeight: weight),
      ),
      textDirection: TextDirection.ltr,
      textAlign: align,
    );
    tp.layout(maxWidth: 200);
    final dx = align == TextAlign.left ? pos.dx : pos.dx - tp.width / 2;
    tp.paint(canvas, Offset(dx, pos.dy));
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter old) =>
      old.axisColor != axisColor || old.tickColor != tickColor;
}

// ── Conditional flow ───────────────────────────────────────────────────────
class _ConditionalFlow extends StatelessWidget {
  const _ConditionalFlow();

  static const _rows = [
    ('Zero', 'If + present', 'present', 'general truths'),
    ('First', 'If + present', 'will + base', 'realistic future'),
    ('Second', 'If + past', 'would + base', 'present unreal'),
    ('Third', 'If + past perfect', 'would have + p.p.', 'past unreal'),
    ('Mixed', 'If + past perfect', 'would + base', 'past cause, present effect'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        color: context.c.glassFill,
        border: Border.all(color: context.c.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('CONDITIONAL TYPES',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                  color: context.c.textFaint)),
          const SizedBox(height: 10),
          for (final r in _rows) _FlowRow(
            type: r.$1,
            ifClause: r.$2,
            mainClause: r.$3,
            note: r.$4,
          ),
        ],
      ),
    );
  }
}

class _FlowRow extends StatelessWidget {
  const _FlowRow({
    required this.type,
    required this.ifClause,
    required this.mainClause,
    required this.note,
  });
  final String type;
  final String ifClause;
  final String mainClause;
  final String note;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 64,
            child: Text(type,
                style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppPalette.brandBlue)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _Token(text: ifClause, color: AppPalette.brandBlue),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(Icons.arrow_forward_rounded,
                          color: context.c.textFaint, size: 14),
                    ),
                    Flexible(
                        child: _Token(
                            text: mainClause, color: AppPalette.accentSira)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(note,
                    style: TextStyle(
                        color: context.c.textMuted, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Token extends StatelessWidget {
  const _Token({required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        border: Border.all(color: color.withOpacity(0.45)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text,
          style: TextStyle(
              color: color, fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }
}

// ── Parallelism lines ──────────────────────────────────────────────────────
class _ParallelismLines extends StatelessWidget {
  const _ParallelismLines();

  static const _items = ['reading the article', 'writing notes', 'preparing a question'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        color: context.c.glassFill,
        border: Border.all(color: context.c.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PARALLEL FORM',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                  color: context.c.textFaint)),
          const SizedBox(height: 12),
          for (final item in _items) ...[
            Row(
              children: [
                Container(
                  width: 38,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppPalette.brandBlue.withOpacity(0.18),
                    border: Border.all(
                        color: AppPalette.brandBlue.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '-ing',
                    style: TextStyle(
                        color: AppPalette.brandBlue,
                        fontWeight: FontWeight.w800,
                        fontSize: 11),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(item,
                      style: TextStyle(color: context.c.text, fontSize: 14)),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 4),
          Text(
              'Each item starts with the same form (-ing). Mixing in "to write" or "preparation of" breaks the pattern.',
              style: TextStyle(color: context.c.textMuted, fontSize: 12, height: 1.4)),
        ],
      ),
    );
  }
}
