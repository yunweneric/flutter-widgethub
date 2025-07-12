import 'package:flutter/material.dart';

class SpotifyTheme {
  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color(0xFF1ED760),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF1ED760),
          secondary: Color(0xFF1ED760),
          background: Colors.white,
          surface: Color(0xFFF6F6F6),
          onPrimary: Colors.white,
          onBackground: Colors.black,
          onSurface: Colors.black,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF6F6F6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xFF1ED760)),
          ),
          hintStyle: TextStyle(color: Color(0xFFB3B3B3), fontWeight: FontWeight.w600),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
          bodyMedium: TextStyle(color: Colors.black),
          titleMedium: TextStyle(color: Color(0xFFB3B3B3)),
          labelLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1ED760),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF121212),
        primaryColor: Color(0xFF1ED760),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF1ED760),
          secondary: Color(0xFF1ED760),
          background: Color(0xFF121212),
          surface: Color(0xFF232323),
          onPrimary: Colors.white,
          onBackground: Colors.white,
          onSurface: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF232323),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xFF232323)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xFF232323)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Color(0xFF1ED760)),
          ),
          hintStyle: TextStyle(color: Color(0xFFB3B3B3), fontWeight: FontWeight.w600),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
          bodyMedium: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Color(0xFFB3B3B3)),
          labelLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1ED760),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      );
}
