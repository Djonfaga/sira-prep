import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Brand color tokens. Anything theme-dependent (surfaces, text, borders)
/// lives on [BrandColors] — a [ThemeExtension] that swaps values between the
/// dark and light themes. Anything strictly brand (logo blue, Sira purple,
/// danger red, etc.) stays here as a const.
class AppPalette {
  AppPalette._();

  // Brand (theme-independent)
  static const brandBlue = Color(0xFF4F8AF6);
  static const brandIndigo = Color(0xFF4F46E5);
  static const accentSira = Color(0xFFB06CFF);
  static const accentDanger = Color(0xFFFF6F6F);
  static const accentSuccess = Color(0xFF34D399);
  static const accentWarn = Color(0xFFFFB44C);

  // ── Dark token defaults (kept as const so const widgets can still ref them) ──
  static const darkBg = Color(0xFF050912);
  static const darkBgSoft = Color(0xFF0A0F1F);
  static const darkSurface = Color(0x66131A2A);
  static const darkSurfaceStrong = Color(0xCC131A2A);
  static const darkBorder = Color(0x1AFFFFFF);
  static const darkBorderStrong = Color(0x33FFFFFF);
  static const darkText = Color(0xFFEDEEF3);
  static const darkTextMuted = Color(0xFFA3A9B8);
  static const darkTextFaint = Color(0xFF6B7385);

  // ── Light token defaults ──
  static const lightBg = Color(0xFFF3F5FA);
  static const lightBgSoft = Color(0xFFFFFFFF);
  static const lightSurface = Color(0xCCFFFFFF);
  static const lightSurfaceStrong = Color(0xF2FFFFFF);
  static const lightBorder = Color(0x14000000);
  static const lightBorderStrong = Color(0x29000000);
  static const lightText = Color(0xFF0E1224);
  static const lightTextMuted = Color(0xFF4F566B);
  static const lightTextFaint = Color(0xFF8A92A6);
}

/// All brightness-dependent tokens live here. Widgets read via
/// [BuildContext.c] so they automatically swap when the theme toggles.
@immutable
class BrandColors extends ThemeExtension<BrandColors> {
  const BrandColors({
    required this.bg,
    required this.bgSoft,
    required this.surface,
    required this.surfaceStrong,
    required this.border,
    required this.borderStrong,
    required this.text,
    required this.textMuted,
    required this.textFaint,
    required this.glassFill,
    required this.glassFillStrong,
    required this.scrim,
  });

  final Color bg;
  final Color bgSoft;
  final Color surface;
  final Color surfaceStrong;
  final Color border;
  final Color borderStrong;
  final Color text;
  final Color textMuted;
  final Color textFaint;

  /// Used as the translucent fill inside [GlassCard] on top of the blur.
  final Color glassFill;
  final Color glassFillStrong;

  /// Used to darken behind overlays (palette/tutorial/onboarding).
  final Color scrim;

  static const dark = BrandColors(
    bg: AppPalette.darkBg,
    bgSoft: AppPalette.darkBgSoft,
    surface: AppPalette.darkSurface,
    surfaceStrong: AppPalette.darkSurfaceStrong,
    border: AppPalette.darkBorder,
    borderStrong: AppPalette.darkBorderStrong,
    text: AppPalette.darkText,
    textMuted: AppPalette.darkTextMuted,
    textFaint: AppPalette.darkTextFaint,
    glassFill: Color(0x12FFFFFF),
    glassFillStrong: Color(0x33121A2E),
    scrim: Color(0xCC050912),
  );

  static const light = BrandColors(
    bg: AppPalette.lightBg,
    bgSoft: AppPalette.lightBgSoft,
    surface: AppPalette.lightSurface,
    surfaceStrong: AppPalette.lightSurfaceStrong,
    border: AppPalette.lightBorder,
    borderStrong: AppPalette.lightBorderStrong,
    text: AppPalette.lightText,
    textMuted: AppPalette.lightTextMuted,
    textFaint: AppPalette.lightTextFaint,
    glassFill: Color(0x99FFFFFF),
    glassFillStrong: Color(0xE6FFFFFF),
    scrim: Color(0xB30E1224),
  );

  @override
  BrandColors copyWith({
    Color? bg,
    Color? bgSoft,
    Color? surface,
    Color? surfaceStrong,
    Color? border,
    Color? borderStrong,
    Color? text,
    Color? textMuted,
    Color? textFaint,
    Color? glassFill,
    Color? glassFillStrong,
    Color? scrim,
  }) =>
      BrandColors(
        bg: bg ?? this.bg,
        bgSoft: bgSoft ?? this.bgSoft,
        surface: surface ?? this.surface,
        surfaceStrong: surfaceStrong ?? this.surfaceStrong,
        border: border ?? this.border,
        borderStrong: borderStrong ?? this.borderStrong,
        text: text ?? this.text,
        textMuted: textMuted ?? this.textMuted,
        textFaint: textFaint ?? this.textFaint,
        glassFill: glassFill ?? this.glassFill,
        glassFillStrong: glassFillStrong ?? this.glassFillStrong,
        scrim: scrim ?? this.scrim,
      );

  @override
  BrandColors lerp(ThemeExtension<BrandColors>? other, double t) {
    if (other is! BrandColors) return this;
    return BrandColors(
      bg: Color.lerp(bg, other.bg, t)!,
      bgSoft: Color.lerp(bgSoft, other.bgSoft, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceStrong: Color.lerp(surfaceStrong, other.surfaceStrong, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      text: Color.lerp(text, other.text, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textFaint: Color.lerp(textFaint, other.textFaint, t)!,
      glassFill: Color.lerp(glassFill, other.glassFill, t)!,
      glassFillStrong: Color.lerp(glassFillStrong, other.glassFillStrong, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
    );
  }
}

extension BrandColorsContext on BuildContext {
  /// Shorthand: `context.c.text`, `context.c.surface`, etc.
  BrandColors get c =>
      Theme.of(this).extension<BrandColors>() ?? BrandColors.dark;
}

/// Per-card color tints turned off — design is monochromatic liquid glass.
/// Kept so existing screens that pass `tint: GlassTints.forIndex(i)` compile.
class GlassTints {
  static Color forIndex(int i) => Colors.transparent;
}

class AppTheme {
  static ThemeData dark() => _build(_DarkSeed());
  static ThemeData light() => _build(_LightSeed());
}

abstract class _ThemeSeed {
  Brightness get brightness;
  Color get scaffoldBg;
  ColorScheme get colorScheme;
  BrandColors get brandColors;
}

class _DarkSeed implements _ThemeSeed {
  @override
  Brightness get brightness => Brightness.dark;
  @override
  Color get scaffoldBg => AppPalette.darkBg;
  @override
  ColorScheme get colorScheme => const ColorScheme.dark(
        primary: AppPalette.brandBlue,
        secondary: AppPalette.accentSira,
        surface: AppPalette.darkSurfaceStrong,
        onSurface: AppPalette.darkText,
        onSurfaceVariant: AppPalette.darkTextMuted,
        outline: AppPalette.darkBorderStrong,
        error: AppPalette.accentDanger,
      );
  @override
  BrandColors get brandColors => BrandColors.dark;
}

class _LightSeed implements _ThemeSeed {
  @override
  Brightness get brightness => Brightness.light;
  @override
  Color get scaffoldBg => AppPalette.lightBg;
  @override
  ColorScheme get colorScheme => const ColorScheme.light(
        primary: AppPalette.brandBlue,
        secondary: AppPalette.accentSira,
        surface: AppPalette.lightSurfaceStrong,
        onSurface: AppPalette.lightText,
        onSurfaceVariant: AppPalette.lightTextMuted,
        outline: AppPalette.lightBorderStrong,
        error: AppPalette.accentDanger,
      );
  @override
  BrandColors get brandColors => BrandColors.light;
}

ThemeData _build(_ThemeSeed seed) {
  final base = seed.brightness == Brightness.dark
      ? ThemeData.dark(useMaterial3: true)
      : ThemeData.light(useMaterial3: true);
  final c = seed.brandColors;
  final textTheme = GoogleFonts.interTextTheme(base.textTheme).apply(
    bodyColor: c.text,
    displayColor: c.text,
  );
  return base.copyWith(
    scaffoldBackgroundColor: seed.scaffoldBg,
    colorScheme: seed.colorScheme,
    extensions: <ThemeExtension<dynamic>>{c},
    textTheme: textTheme.copyWith(
      displayLarge: GoogleFonts.outfit(
          textStyle: TextStyle(
              fontSize: 42, fontWeight: FontWeight.w800, height: 1.05, color: c.text)),
      displayMedium: GoogleFonts.outfit(
          textStyle: TextStyle(
              fontSize: 32, fontWeight: FontWeight.w800, height: 1.1, color: c.text)),
      headlineLarge: GoogleFonts.outfit(
          textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: c.text)),
      headlineMedium: GoogleFonts.outfit(
          textStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: c.text)),
      titleLarge: GoogleFonts.inter(
          textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: c.text)),
      titleMedium: GoogleFonts.inter(
          textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: c.text)),
      bodyLarge: GoogleFonts.inter(
          textStyle: TextStyle(fontSize: 16, height: 1.45, color: c.text)),
      bodyMedium: GoogleFonts.inter(
          textStyle: TextStyle(fontSize: 14, height: 1.45, color: c.textMuted)),
      bodySmall: GoogleFonts.inter(
          textStyle: TextStyle(fontSize: 12, height: 1.4, color: c.textMuted)),
      labelSmall: GoogleFonts.inter(
          textStyle: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
              color: c.textFaint)),
    ),
  );
}
