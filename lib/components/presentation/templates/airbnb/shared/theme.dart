import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AirbnbTheme {
  // Airbnb brand colors
  static const Color primaryRed = Color(0xFFFF5A5F);
  static const Color secondaryTeal = Color(0xFF00A699);
  static const Color darkGray = Color(0xFF222222);
  static const Color mediumGray = Color(0xFF717171);
  static const Color lightGray = Color(0xFFDDDDDD);
  static const Color backgroundGray = Color(0xFFF7F7F7);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: white,
        primaryColor: primaryRed,
        primaryColorDark: black,
        primaryColorLight: white,
        colorScheme: const ColorScheme.light(
          primary: primaryRed,
          secondary: secondaryTeal,
          surface: backgroundGray,
          onPrimary: white,
          onSurface: darkGray,
          background: white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: white,
          surfaceTintColor: white,
          elevation: 0,
          iconTheme: const IconThemeData(color: darkGray),
          titleTextStyle: GoogleFonts.lato(
            color: darkGray,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          fillColor: white,
          border: const OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide(color: primaryRed, width: 2),
          ),
          hintStyle: GoogleFonts.lato(
            color: mediumGray,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.lato(
            color: darkGray,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
          displayMedium: GoogleFonts.lato(
            color: darkGray,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
          displaySmall: GoogleFonts.lato(
            color: darkGray,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          headlineMedium: GoogleFonts.lato(
            color: darkGray,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          bodyLarge: GoogleFonts.lato(
            color: darkGray,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: GoogleFonts.lato(
            color: darkGray,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: GoogleFonts.lato(
            color: mediumGray,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: GoogleFonts.lato(
            color: white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          labelMedium: GoogleFonts.lato(
            color: darkGray,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryRed,
            foregroundColor: white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            textStyle: GoogleFonts.lato(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            elevation: 0,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: white,
          selectedItemColor: darkGray,
          unselectedItemColor: mediumGray,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedLabelStyle: GoogleFonts.lato(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: GoogleFonts.lato(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        cardTheme: CardThemeData(
          color: white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: white,
          selectedColor: darkGray,
          labelStyle: GoogleFonts.lato(
            color: darkGray,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: lightGray),
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: primaryRed,
        primaryColorDark: white,
        primaryColorLight: black,
        colorScheme: const ColorScheme.dark(
          primary: primaryRed,
          secondary: secondaryTeal,
          surface: const Color(0xFF232323),
          onPrimary: white,
          onSurface: white,
          background: const Color(0xFF121212),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: black,
          surfaceTintColor: black,
          elevation: 0,
          iconTheme: const IconThemeData(color: white),
          titleTextStyle: GoogleFonts.lato(
            color: white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1A1B1B),
          selectedItemColor: white,
          unselectedItemColor: mediumGray,
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          filled: true,
          fillColor: Color(0xFF232323),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide(color: primaryRed, width: 2),
          ),
          hintStyle: GoogleFonts.lato(
            color: mediumGray,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.lato(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
          displayMedium: GoogleFonts.lato(
            color: white,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
          displaySmall: GoogleFonts.lato(
            color: white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          headlineMedium: GoogleFonts.lato(
            color: white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          bodyLarge: GoogleFonts.lato(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: GoogleFonts.lato(
            color: white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: GoogleFonts.lato(
            color: mediumGray,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: GoogleFonts.lato(
            color: white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          labelMedium: GoogleFonts.lato(
            color: white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryRed,
            foregroundColor: white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            textStyle: GoogleFonts.lato(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            elevation: 0,
          ),
        ),
        iconTheme: const IconThemeData(
          color: white,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF232323),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFF232323),
          selectedColor: white,
          labelStyle: GoogleFonts.lato(
            color: white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: mediumGray),
          ),
        ),
      );
}
