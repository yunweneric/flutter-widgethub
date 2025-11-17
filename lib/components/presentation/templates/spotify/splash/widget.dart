import 'package:flutter/material.dart';

import '../index.dart';

/// Spotify splash screen with logo display.
///
/// API Reference:
/// - No public properties (uses internal state)
///
/// Usage:
/// ```dart
/// SpotifySplashScreen()
/// ```
class SpotifySplashScreen extends StatefulWidget {
  const SpotifySplashScreen({super.key});

  @override
  State<SpotifySplashScreen> createState() => _SpotifySplashScreenState();
}

class _SpotifySplashScreenState extends State<SpotifySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SpotifyTheme.dark,
      child: const Scaffold(
        body: Center(
          child: SpotifyLogo(),
        ),
      ),
    );
  }
}
