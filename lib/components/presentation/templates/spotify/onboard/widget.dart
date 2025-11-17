import 'package:flutter/material.dart';
import '../shared/logo.dart';
import '../shared/button.dart';
import '../shared/constants.dart';
import '../shared/theme.dart';

/// Spotify onboarding screen with welcome message and get started button.
///
/// API Reference:
/// - No public properties
///
/// Usage:
/// ```dart
/// SpotifyOnboarding()
/// ```
class SpotifyOnboarding extends StatelessWidget {
  const SpotifyOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SpotifyTheme.dark,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(SpotifyConstants.onboardImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SpotifyLogo(width: 50, height: 50),
                    const Spacer(),
                    Text(
                      "Enjoy listening to music",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Discover, collect, and enjoy millions of songs and podcasts.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    SpotifyButton(
                      text: "Get Started",
                      onPressed: () {},
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
