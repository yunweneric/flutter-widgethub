const spotifySplashCode = """
import 'package:flutter/material.dart';

import '../index.dart';

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
""";
