import 'package:flutter/material.dart';

class SpotifyTheme {
  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF1ED760),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF1ED760),
          secondary: Color(0xFF1ED760),
          surface: Color(0xFFF6F6F6),
          onPrimary: Colors.white,
          onSurface: Colors.black,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          fillColor: Color(0xFFF6F6F6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            borderSide: BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            borderSide: BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            borderSide: BorderSide(color: Color(0xFF1ED760)),
          ),
          hintStyle: TextStyle(color: Color(0xFFB3B3B3)),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40),
          bodyMedium: TextStyle(color: Colors.black),
          titleMedium: TextStyle(color: Color(0xFFB3B3B3)),
          labelLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1ED760),
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      );

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFF1ED760),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF1ED760),
          secondary: Color(0xFF1ED760),
          surface: Color(0xFF232323),
          onPrimary: Colors.white,
          onSurface: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 26, 27, 27),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          filled: true,
          fillColor: Color(0xFF232323),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            borderSide: BorderSide(color: Color(0xFF232323)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            borderSide: BorderSide(color: Color(0xFF232323)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            borderSide: BorderSide(color: Color(0xFF1ED760)),
          ),
          hintStyle: TextStyle(color: Color(0xFFB3B3B3)),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
          displayMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          displaySmall: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Color(0xFFB3B3B3)),
          labelLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1ED760),
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      );
}
