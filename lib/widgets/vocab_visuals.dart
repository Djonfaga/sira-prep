import 'package:flutter/material.dart';

import '../data/vocab_guide.dart';
import '../theme/app_theme.dart';

/// Lightweight diagrams that accompany vocabulary lessons. Each one is pure
/// Flutter — no asset images — so they recolour with the active theme.
class VocabVisualWidget extends StatelessWidget {
  const VocabVisualWidget({super.key, required this.kind});
  final VocabVisual kind;

  @override
  Widget build(BuildContext context) {
    switch (kind) {
      case VocabVisual.wordBuilder:
        return const _WordBuilder();
      case VocabVisual.familyTree:
        return const _FamilyTree();
      case VocabVisual.collocationWeb:
        return const _CollocationWeb();
      case VocabVisual.registerScale:
        return const _RegisterScale();
      case VocabVisual.prefixGrid:
        return const _PrefixGrid();
      case VocabVisual.none:
        return const SizedBox.shrink();
    }
  }
}

Widget _frame(BuildContext context, String label, Widget body) {
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
        Text(label,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
                color: context.c.textFaint)),
        const SizedBox(height: 12),
        body,
      ],
    ),
  );
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.color, this.dense = false});
  final String text;
  final Color color;
  final bool dense;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: dense ? 8 : 10, vertical: dense ? 4 : 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.14),
        border: Border.all(color: color.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text,
          style: TextStyle(
              color: color,
              fontSize: dense ? 12 : 13,
              fontWeight: FontWeight.w800)),
    );
  }
}

// ── Word builder ──────────────────────────────────────────────────────────
class _WordBuilder extends StatelessWidget {
  const _WordBuilder();

  static const _rows = [
    ('un-', 'believe', '-able', 'unbelievable'),
    ('trans-', 'port', '-ation', 'transportation'),
    ('in-', 'cred', '-ible', 'incredible'),
  ];

  @override
  Widget build(BuildContext context) {
    return _frame(
      context,
      'WORD BUILDER  ·  prefix + root + suffix',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final r in _rows) ...[
            Wrap(
              spacing: 6,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _Pill(text: r.$1, color: AppPalette.brandBlue),
                Text('+', style: TextStyle(color: context.c.textMuted)),
                _Pill(text: r.$2, color: AppPalette.accentSira),
                Text('+', style: TextStyle(color: context.c.textMuted)),
                _Pill(text: r.$3, color: AppPalette.accentSuccess),
                Icon(Icons.arrow_forward_rounded,
                    color: context.c.textFaint, size: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: context.c.glassFillStrong,
                    border: Border.all(color: context.c.borderStrong),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(r.$4,
                      style: TextStyle(
                          color: context.c.text,
                          fontWeight: FontWeight.w800,
                          fontSize: 13)),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
          Row(
            children: [
              _LegendDot(color: AppPalette.brandBlue, label: 'prefix'),
              const SizedBox(width: 10),
              _LegendDot(color: AppPalette.accentSira, label: 'root'),
              const SizedBox(width: 10),
              _LegendDot(color: AppPalette.accentSuccess, label: 'suffix'),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});
  final Color color;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label,
            style: TextStyle(fontSize: 11, color: context.c.textMuted)),
      ],
    );
  }
}

// ── Word family tree ──────────────────────────────────────────────────────
class _FamilyTree extends StatelessWidget {
  const _FamilyTree();
  @override
  Widget build(BuildContext context) {
    final branches = [
      ('verb', 'analyse'),
      ('noun · action', 'analysis'),
      ('noun · agent', 'analyst'),
      ('adjective', 'analytical'),
      ('adverb', 'analytically'),
    ];

    return _frame(
      context,
      'WORD FAMILY  ·  one base, five forms',
      Column(
        children: [
          Center(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFB7D3FF), AppPalette.brandBlue],
                ),
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                      color: AppPalette.brandBlue.withOpacity(0.4),
                      blurRadius: 14,
                      spreadRadius: -4),
                ],
              ),
              child: const Text('analys-',
                  style: TextStyle(
                      color: Color(0xFF0A1430),
                      fontWeight: FontWeight.w800,
                      fontSize: 14)),
            ),
          ),
          const SizedBox(height: 10),
          // Five-branch diverging arrows + tag/word pairs.
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              for (final b in branches)
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                  decoration: BoxDecoration(
                    color: context.c.glassFillStrong,
                    border: Border.all(color: context.c.borderStrong),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(b.$1.toUpperCase(),
                          style: TextStyle(
                              color: context.c.textFaint,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2)),
                      const SizedBox(height: 2),
                      Text(b.$2,
                          style: TextStyle(
                              color: context.c.text,
                              fontWeight: FontWeight.w800,
                              fontSize: 14)),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Collocation web ───────────────────────────────────────────────────────
class _CollocationWeb extends StatelessWidget {
  const _CollocationWeb();
  @override
  Widget build(BuildContext context) {
    return _frame(
      context,
      'COLLOCATIONS  ·  partners around a node',
      Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFB7D3FF), AppPalette.brandBlue],
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text('MAKE',
                        style: TextStyle(
                            color: Color(0xFF0A1430),
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                            letterSpacing: 1.2)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final w in const [
                      'a decision',
                      'a mistake',
                      'progress',
                      'an effort',
                      'money',
                      'a choice',
                    ])
                      _Pill(text: w, color: AppPalette.brandBlue, dense: true),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE0CFFF), AppPalette.accentSira],
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text('DO',
                        style: TextStyle(
                            color: Color(0xFF0A1430),
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                            letterSpacing: 1.2)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final w in const [
                      'research',
                      'homework',
                      'business',
                      'exercise',
                      'the dishes',
                      'a favour',
                    ])
                      _Pill(text: w, color: AppPalette.accentSira, dense: true),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Register scale ────────────────────────────────────────────────────────
class _RegisterScale extends StatelessWidget {
  const _RegisterScale();

  static const _rows = [
    ['commence', 'begin', 'start', 'kick off'],
    ['inquire',  'ask',   'check', 'poke around'],
    ['assist',   'help',  'help out', 'pitch in'],
    ['purchase', 'buy',   'pick up', 'snag'],
  ];

  @override
  Widget build(BuildContext context) {
    return _frame(
      context,
      'REGISTER  ·  formal ←→ informal',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('formal',
                  style: TextStyle(
                      color: AppPalette.brandBlue,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2)),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppPalette.brandBlue,
                        AppPalette.brandBlue.withOpacity(0.4),
                        AppPalette.accentSira.withOpacity(0.4),
                        AppPalette.accentSira,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text('informal',
                  style: TextStyle(
                      color: AppPalette.accentSira,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2)),
            ],
          ),
          const SizedBox(height: 12),
          for (final r in _rows) ...[
            Row(
              children: [
                for (var i = 0; i < r.length; i++) ...[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        color: Color.lerp(
                                AppPalette.brandBlue.withOpacity(0.18),
                                AppPalette.accentSira.withOpacity(0.18),
                                i / (r.length - 1))!,
                        border: Border.all(
                            color: Color.lerp(
                                    AppPalette.brandBlue.withOpacity(0.45),
                                    AppPalette.accentSira.withOpacity(0.45),
                                    i / (r.length - 1))!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(r[i],
                          style: TextStyle(
                              color: context.c.text,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                  if (i != r.length - 1) const SizedBox(width: 6),
                ]
              ],
            ),
            const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }
}

// ── Prefix grid ───────────────────────────────────────────────────────────
class _PrefixGrid extends StatelessWidget {
  const _PrefixGrid();

  static const _entries = [
    ('un-', 'not / reverse', 'unhappy · unlock'),
    ('re-', 'again / back', 'rewrite · return'),
    ('pre-', 'before', 'preview · predict'),
    ('post-', 'after', 'postpone · postgraduate'),
    ('sub-', 'under', 'submarine · subway'),
    ('super-', 'above / beyond', 'supervisor · superhuman'),
    ('inter-', 'between', 'international · interactive'),
    ('trans-', 'across', 'transport · transmit'),
    ('over-', 'too much', 'overeat · overestimate'),
    ('under-', 'too little', 'undervalue · underrate'),
    ('mis-', 'wrongly', 'misunderstand · misplace'),
    ('anti-', 'against', 'antibiotic · antisocial'),
  ];

  @override
  Widget build(BuildContext context) {
    return _frame(
      context,
      'PREFIX QUICK REFERENCE',
      Column(
        children: [
          for (final e in _entries) ...[
            Row(
              children: [
                SizedBox(
                  width: 64,
                  child:
                      _Pill(text: e.$1, color: AppPalette.brandBlue, dense: true),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 110,
                  child: Text(e.$2,
                      style: TextStyle(
                          color: context.c.text,
                          fontSize: 12,
                          fontWeight: FontWeight.w700)),
                ),
                Expanded(
                  child: Text(e.$3,
                      style: TextStyle(
                          color: context.c.textMuted,
                          fontSize: 12,
                          fontStyle: FontStyle.italic)),
                ),
              ],
            ),
            const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }
}
