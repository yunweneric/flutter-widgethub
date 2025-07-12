const spotifyChooseThemeCode = """
import 'package:flutter/material.dart';
import '../shared/logo.dart';
import '../shared/button.dart';
import '../shared/constants.dart';
import '../shared/theme.dart';

class SpotifyChooseTheme extends StatefulWidget {
  const SpotifyChooseTheme({super.key});

  @override
  State<SpotifyChooseTheme> createState() => _SpotifyChooseThemeState();
}

class _SpotifyChooseThemeState extends State<SpotifyChooseTheme> {
  late ThemeMode _selectedMode;

  @override
  void initState() {
    super.initState();
    _selectedMode = ThemeMode.dark;
  }

  void _selectMode(ThemeMode mode) {
    setState(() => _selectedMode = mode);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _selectedMode == ThemeMode.dark ? SpotifyTheme.dark : SpotifyTheme.light,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(SpotifyConstants.chooseImage),
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
                      "Choose Mode",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ThemeModeSelector(
                          icon: Icons.nightlight_round,
                          label: "Dark Mode",
                          selected: _selectedMode == ThemeMode.dark,
                          onTap: () => _selectMode(ThemeMode.dark),
                        ),
                        const SizedBox(width: 32),
                        _ThemeModeSelector(
                          icon: Icons.wb_sunny,
                          label: "Light Mode",
                          selected: _selectedMode == ThemeMode.light,
                          onTap: () => _selectMode(ThemeMode.light),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    SpotifyButton(
                      text: "Continue",
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

class _ThemeModeSelector extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeModeSelector({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          bottom: selected ? 30 : 50,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  shape: BoxShape.circle,
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Icon(icon, size: 30),
              ),
              const SizedBox(height: 20),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
""";
