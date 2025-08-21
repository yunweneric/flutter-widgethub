import 'package:flutter/material.dart';

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
        colorScheme: const ColorScheme.light(
          primary: primaryRed,
          secondary: secondaryTeal,
          surface: backgroundGray,
          onPrimary: white,
          onSurface: darkGray,
          background: white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: white,
          elevation: 0,
          iconTheme: IconThemeData(color: darkGray),
          titleTextStyle: TextStyle(
            color: darkGray,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          fillColor: white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide(color: primaryRed, width: 2),
          ),
          hintStyle: TextStyle(
            color: mediumGray,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: darkGray,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
          displayMedium: TextStyle(
            color: darkGray,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
          displaySmall: TextStyle(
            color: darkGray,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          headlineMedium: TextStyle(
            color: darkGray,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          bodyLarge: TextStyle(
            color: darkGray,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            color: darkGray,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            color: mediumGray,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            color: white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          labelMedium: TextStyle(
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
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            elevation: 0,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: white,
          selectedItemColor: darkGray,
          unselectedItemColor: mediumGray,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        cardTheme: CardTheme(
          color: white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: white,
          selectedColor: darkGray,
          labelStyle: const TextStyle(
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
        colorScheme: const ColorScheme.dark(
          primary: primaryRed,
          secondary: secondaryTeal,
          surface: const Color(0xFF232323),
          onPrimary: white,
          onSurface: white,
          background: const Color(0xFF121212),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1A1B1B),
          selectedItemColor: white,
          unselectedItemColor: mediumGray,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          filled: true,
          fillColor: Color(0xFF232323),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            borderSide: BorderSide(color: primaryRed, width: 2),
          ),
          hintStyle: TextStyle(
            color: mediumGray,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
          displayMedium: TextStyle(
            color: white,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
          displaySmall: TextStyle(
            color: white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          headlineMedium: TextStyle(
            color: white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          bodyLarge: TextStyle(
            color: white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          bodyMedium: TextStyle(
            color: white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            color: mediumGray,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            color: white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          labelMedium: TextStyle(
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
            textStyle: const TextStyle(
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
        cardTheme: CardTheme(
          color: const Color(0xFF232323),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFF232323),
          selectedColor: white,
          labelStyle: const TextStyle(
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
