import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TraveloopColors {
  // Primary palette
  static const Color primary = Color(0xFF000109);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF0A1B3D);
  static const Color onPrimaryContainer = Color(0xFF7584AC);

  // Secondary (brand orange-brown)
  static const Color secondary = Color(0xFF9F4200);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFC7C31);
  static const Color onSecondaryContainer = Color(0xFF602500);
  static const Color secondaryFixed = Color(0xFFFFDBCB);
  static const Color secondaryFixedDim = Color(0xFFFFB692);
  static const Color onSecondaryFixed = Color(0xFF341100);
  static const Color onSecondaryFixedVariant = Color(0xFF793100);

  // Surface
  static const Color background = Color(0xFFF8F9FF);
  static const Color surface = Color(0xFFF8F9FF);
  static const Color surfaceBright = Color(0xFFF8F9FF);
  static const Color surfaceDim = Color(0xFFCBDBF5);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFEFF4FF);
  static const Color surfaceContainer = Color(0xFFE5EEFF);
  static const Color surfaceContainerHigh = Color(0xFFDCE9FF);
  static const Color surfaceContainerHighest = Color(0xFFD3E4FE);
  static const Color surfaceVariant = Color(0xFFD3E4FE);

  // On-surface
  static const Color onBackground = Color(0xFF0B1C30);
  static const Color onSurface = Color(0xFF0B1C30);
  static const Color onSurfaceVariant = Color(0xFF45464E);

  // Outline
  static const Color outline = Color(0xFF75777F);
  static const Color outlineVariant = Color(0xFFC5C6CF);

  // Error
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);

  // Inverse
  static const Color inverseSurface = Color(0xFF213145);
  static const Color inverseOnSurface = Color(0xFFEAF1FF);
  static const Color inversePrimary = Color(0xFFB7C6F1);
}

class TraveloopTheme {
  static ThemeData get theme {
    final textTheme = GoogleFonts.plusJakartaSansTextTheme().copyWith(
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: -0.64, height: 1.25,
      ),
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: -0.24, height: 1.33,
      ),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 20, fontWeight: FontWeight.w700, height: 1.4,
      ),
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 18, fontWeight: FontWeight.w400, height: 1.56,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 16, fontWeight: FontWeight.w400, height: 1.5,
      ),
      bodySmall: GoogleFonts.plusJakartaSans(
        fontSize: 14, fontWeight: FontWeight.w400, height: 1.43,
      ),
      labelLarge: GoogleFonts.plusJakartaSans(
        fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.28, height: 1.14,
      ),
      labelMedium: GoogleFonts.plusJakartaSans(
        fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.48, height: 1.33,
      ),
      labelSmall: GoogleFonts.plusJakartaSans(
        fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.5, height: 1.2,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: TraveloopColors.primary,
        onPrimary: TraveloopColors.onPrimary,
        primaryContainer: TraveloopColors.primaryContainer,
        onPrimaryContainer: TraveloopColors.onPrimaryContainer,
        secondary: TraveloopColors.secondary,
        onSecondary: TraveloopColors.onSecondary,
        secondaryContainer: TraveloopColors.secondaryContainer,
        onSecondaryContainer: TraveloopColors.onSecondaryContainer,
        surface: TraveloopColors.surface,
        onSurface: TraveloopColors.onSurface,
        onSurfaceVariant: TraveloopColors.onSurfaceVariant,
        outline: TraveloopColors.outline,
        outlineVariant: TraveloopColors.outlineVariant,
        error: TraveloopColors.error,
        onError: TraveloopColors.onError,
      ),
      textTheme: textTheme,
      scaffoldBackgroundColor: TraveloopColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: TraveloopColors.surfaceBright.withValues(alpha: 0.9),
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          color: TraveloopColors.primary,
          fontSize: 24,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.24,
        ),
        iconTheme: const IconThemeData(color: TraveloopColors.primary),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: TraveloopColors.surfaceContainerLowest.withValues(alpha: 0.9),
        indicatorColor: TraveloopColors.secondaryFixed.withValues(alpha: 0.4),
        labelTextStyle: WidgetStateProperty.all(
          GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.48),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: TraveloopColors.surfaceContainerLowest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: TraveloopColors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: TraveloopColors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: TraveloopColors.secondary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
