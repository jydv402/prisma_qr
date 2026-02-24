import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Common Colors
  static const Color primaryLight = Color(0xFF18181B); // Zinc 900
  static const Color primaryDark = Color(
    0xFF000000,
  ); // Or #111827 depending on screen
  static const Color accentBlue = Color(0xFF3B82F6);

  // Backgrounds
  static const Color bgLight = Color.fromARGB(
    255,
    239,
    241,
    238,
  ); // iOS system gray light or F2F2F4
  static const Color bgDark = Color.fromARGB(255, 0, 0, 0); // Pitch black

  // Cards
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1C1C1E);

  // Text
  static const Color textMainLight = Color(0xFF111827);
  static const Color textMainDark = Color(0xFFF9FAFB);
  static const Color textSubLight = Color(0xFF6B7280);
  static const Color textSubDark = Color(0xFF9CA3AF);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryLight,
      scaffoldBackgroundColor: bgLight,
      colorScheme: ColorScheme.light(
        primary: primaryLight,
        secondary: accentBlue,
        surface: cardLight,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.dmSans(
          color: textMainLight,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.dmSans(
          color: textMainLight,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.dmSans(
          color: textMainLight,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: GoogleFonts.dmSans(
          color: textMainLight,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.dmSans(
          color: textMainLight,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: GoogleFonts.dmSans(
          color: textMainLight,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.dmSans(
          color: textMainLight,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.dmSans(
          color: textMainLight,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: GoogleFonts.dmSans(
          color: textMainLight,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: GoogleFonts.inter(color: textMainLight),
        bodyMedium: GoogleFonts.inter(color: textMainLight),
        bodySmall: GoogleFonts.inter(color: textSubLight),
        labelLarge: GoogleFonts.inter(
          color: textMainLight,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: GoogleFonts.inter(
          color: textMainLight,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: GoogleFonts.inter(
          color: textSubLight,
          fontWeight: FontWeight.w500,
        ),
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryDark,
      scaffoldBackgroundColor: bgDark,
      colorScheme: ColorScheme.dark(
        primary: primaryDark,
        secondary: accentBlue,
        surface: cardDark,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.dmSans(
          color: textMainDark,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.dmSans(
          color: textMainDark,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.dmSans(
          color: textMainDark,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: GoogleFonts.dmSans(
          color: textMainDark,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.dmSans(
          color: textMainDark,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: GoogleFonts.dmSans(
          color: textMainDark,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.dmSans(
          color: textMainDark,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.dmSans(
          color: textMainDark,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: GoogleFonts.dmSans(
          color: textMainDark,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: GoogleFonts.inter(color: textMainDark),
        bodyMedium: GoogleFonts.inter(color: textMainDark),
        bodySmall: GoogleFonts.inter(color: textSubDark),
        labelLarge: GoogleFonts.inter(
          color: textMainDark,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: GoogleFonts.inter(
          color: textMainDark,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: GoogleFonts.inter(
          color: textSubDark,
          fontWeight: FontWeight.w500,
        ),
      ),
      useMaterial3: true,
    );
  }
}
