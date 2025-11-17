import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../shared/theme.dart';
import '../music/widget.dart' show PlayerIcons;

class LyricLine {
  final String text;
  final bool isSection;
  final bool isActive;
  const LyricLine({required this.text, this.isActive = false, this.isSection = false});

  LyricLine copyWith({String? text, bool? isActive, bool? isSection}) {
    return LyricLine(
      text: text ?? this.text,
      isActive: isActive ?? this.isActive,
      isSection: isSection ?? this.isSection,
    );
  }
}

/// Spotify lyrics screen with synchronized lyric display and background effects.
///
/// API Reference:
/// - No public properties (uses internal state)
///
/// Usage:
/// ```dart
/// SpotifyLyricScreen()
/// ```
class SpotifyLyricScreen extends StatefulWidget {
  const SpotifyLyricScreen({super.key});

  @override
  State<SpotifyLyricScreen> createState() => _SpotifyLyricScreenState();
}

class _SpotifyLyricScreenState extends State<SpotifyLyricScreen> {
  late List<LyricLine> lyrics;

  @override
  void initState() {
    super.initState();
    lyrics = [
      LyricLine(text: '( Verse 1 )', isSection: true),
      LyricLine(text: "Sleepin', You're On Your Tippy Toes"),
      LyricLine(text: "Creepin' Around Like No One Knows"),
      LyricLine(text: "Think You're So Criminal"),
      LyricLine(text: "Bruises On Both My Knees For You"),
      LyricLine(text: "Don't Say Thank You Or Please"),
      LyricLine(text: "I Do What I Want When I'm Wanting To"),
      LyricLine(text: 'My Soul? So Cynical', isActive: true),
      LyricLine(text: '( Verse 2 )', isSection: true),
      LyricLine(text: "Sleepin', You're On Your Tippy Toes"),
      LyricLine(text: "Creepin' Around Like No One Knows"),
      LyricLine(text: "Think You're So Criminal"),
      LyricLine(text: "Bruises On Both My Knees For You"),
    ];
  }

  void _setActive(int index) {
    setState(() {
      lyrics = [
        for (int i = 0; i < lyrics.length; i++)
          lyrics[i].isSection ? lyrics[i] : lyrics[i].copyWith(isActive: i == index)
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = SpotifyTheme.dark;
    return Theme(
      data: theme,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
            ),
            // Background image with green overlay
            Positioned.fill(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.green.withOpacity(0.7),
                  BlendMode.modulate,
                ),
                child: Image.network(
                  'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=600',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Content overlay
            Positioned.fill(
              child: SafeArea(
                child: Column(
                  children: [
                    // AppBar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: SvgPicture.string(PlayerIcons.back, width: 28, height: 28),
                            onPressed: () {},
                            splashRadius: 24,
                          ),
                          const Text(
                            'Bad Guy',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          IconButton(
                            icon: RotatedBox(
                              quarterTurns: 1,
                              child: SvgPicture.string(PlayerIcons.more, width: 28, height: 28),
                            ),
                            onPressed: () {},
                            splashRadius: 24,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Lyrics
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        itemCount: lyrics.length,
                        itemBuilder: (context, index) {
                          final line = lyrics[index];
                          Widget item;
                          if (line.isSection) {
                            item = Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text(
                                line.text,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            );
                          } else if (line.isActive) {
                            item = GestureDetector(
                              onTap: () => _setActive(index),
                              child: Row(
                                children: [
                                  SvgPicture.string(PlayerIcons.play, width: 24, height: 24, color: Color(0xFF1ED760)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      line.text,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            item = GestureDetector(
                              onTap: () => _setActive(index),
                              child: _LyricLine(text: line.text, faded: true),
                            );
                          }

                          // If this is the last item, add extra space below
                          if (index == lyrics.length - 1) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                item,
                                SizedBox(height: MediaQuery.sizeOf(context).height * 0.5),
                              ],
                            );
                          } else {
                            return item;
                          }
                        },
                      ),
                    ),
                    // Bottom music control bar (reuse from music/widget.dart if possible)
                  ],
                ),
              ),
            ),
            // _SpotifyBottomBar(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _SpotifyBottomBar(),
            ),
          ],
        ),
      ),
    );
  }
}

class _LyricLine extends StatelessWidget {
  final String text;
  final bool faded;

  const _LyricLine({
    required this.text,
    this.faded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: TextStyle(
          color: faded ? Colors.white.withOpacity(0.5) : Colors.white,
          fontWeight: faded ? FontWeight.normal : FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}

class _SpotifyBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20).copyWith(bottom: kBottomNavigationBarHeight),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.85)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=600',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bad Guy', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 2),
                    Text('Billie Eilish', style: TextStyle(color: Color(0xFFB3B3B3), fontSize: 14)),
                  ],
                ),
              ),
              IconButton(
                icon: SvgPicture.string(PlayerIcons.heart, width: 28, height: 28),
                onPressed: () {},
                splashRadius: 24,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Slider(
            value: 145.0,
            min: 0.0,
            max: 242.0,
            onChanged: (value) {},
            activeColor: theme.primaryColor,
            inactiveColor: const Color(0xFF535353),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('2:25', style: TextStyle(color: Color(0xFFB3B3B3))),
              Text('4:02', style: TextStyle(color: Color(0xFFB3B3B3))),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: SvgPicture.string(PlayerIcons.repeat, width: 28, height: 28),
                onPressed: () {},
                splashRadius: 28,
              ),
              IconButton(
                icon: SvgPicture.string(PlayerIcons.previous, width: 36, height: 36),
                onPressed: () {},
                splashRadius: 36,
              ),
              Container(
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: SvgPicture.string(PlayerIcons.pause, width: 36, height: 36),
                  onPressed: () {},
                  splashRadius: 36,
                ),
              ),
              IconButton(
                icon: SvgPicture.string(PlayerIcons.next, width: 36, height: 36),
                onPressed: () {},
                splashRadius: 36,
              ),
              IconButton(
                icon: SvgPicture.string(PlayerIcons.shuffle, width: 28, height: 28),
                onPressed: () {},
                splashRadius: 28,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
