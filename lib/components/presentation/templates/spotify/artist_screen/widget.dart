import 'package:flutter/material.dart';
import '../shared/theme.dart';
import '../shared/spotify_icons.dart';

/// Spotify artist screen variant 1 with collapsible header and playlists.
///
/// API Reference:
/// - No public properties
///
/// Usage:
/// ```dart
/// SpotifyArtistScreen()
/// ```
class SpotifyArtistScreen extends StatelessWidget {
  const SpotifyArtistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SpotifyTheme.dark,
      child: const Scaffold(
        bottomNavigationBar: _BottomNavigationBar(),
        body: CustomScrollView(
          slivers: [
            // Collapsible Header Section
            _CollapsibleHeader(),

            // Public Playlists Section
            _PlaylistsSliver(),
          ],
        ),
      ),
    );
  }
}

class _CollapsibleHeader extends StatelessWidget {
  const _CollapsibleHeader();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340, // Height when fully expanded
      collapsedHeight: 80, // Height when fully collapsed
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      leading: IconButton(
        style: IconButton.styleFrom(backgroundColor: Theme.of(context).cardColor),
        onPressed: () {},
        icon: SpotifyIcons.getIcon(SpotifyIcons.back, color: Colors.white),
      ),
      actions: [
        IconButton(
          style: IconButton.styleFrom(backgroundColor: Theme.of(context).cardColor),
          onPressed: () {},
          icon: SpotifyIcons.getIcon(SpotifyIcons.menu, color: Colors.white),
        ),
      ],
      title: Text(
        'Soroushnrz',
        style: Theme.of(context).textTheme.displayMedium,
      ),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 120), // Space for app bar

              // Profile Picture with Geometric Shapes
              Stack(
                alignment: Alignment.center,
                children: [
                  // Geometric shapes around the profile picture
                  Positioned(
                    top: -10,
                    right: -10,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1ED760),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -15,
                    left: -15,
                    child: Container(
                      width: 50,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1ED760),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: -20,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  // Main Profile Picture
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=400&fit=crop'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Email
              Text(
                'soroushnorozyui@gmail.com',
                style: Theme.of(context).textTheme.bodySmall,
              ),

              const SizedBox(height: 8),

              // Username
              Text(
                'Soroushnrz',
                style: Theme.of(context).textTheme.displayMedium,
              ),

              const SizedBox(height: 10),

              // Followers/Following Stats
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatItem(count: '778', label: 'Followes'),
                  _StatItem(count: '243', label: 'Followes'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String count;
  final String label;

  const _StatItem({
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _PlaylistsSliver extends StatelessWidget {
  const _PlaylistsSliver();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          const SizedBox(height: 16),

          Text(
            'PUBLIC PLAYLISTS',
            style: Theme.of(context).textTheme.displaySmall,
          ),

          const SizedBox(height: 16),

          const _PlaylistItem(
            title: 'Dont Smile At Me',
            artist: 'Billie Eilish',
            duration: '5:33',
            imagePath: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=200&h=200&fit=crop',
          ),
          const _PlaylistItem(
            title: 'As It Was',
            artist: 'Harry Styles',
            duration: '5:33',
            imagePath: 'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=200&h=200&fit=crop',
          ),
          const _PlaylistItem(
            title: 'Super Freaky Girl',
            artist: 'Nicki Minaj',
            duration: '5:33',
            imagePath: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=200&h=200&fit=crop',
          ),
          const _PlaylistItem(
            title: 'Bad Habit',
            artist: 'Steve Lacy',
            duration: '5:33',
            imagePath: 'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=200&h=200&fit=crop',
          ),
          const _PlaylistItem(
            title: 'Planet Her',
            artist: 'Doja Cat',
            duration: '5:33',
            imagePath: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=200&h=200&fit=crop',
          ),
          const _PlaylistItem(
            title: 'Sweetest Pie',
            artist: 'Megan Thee Stallion',
            duration: '5:33',
            imagePath: 'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=200&h=200&fit=crop',
          ),

          const SizedBox(height: 100), // Bottom padding
        ]),
      ),
    );
  }
}

class _PlaylistItem extends StatelessWidget {
  final String title;
  final String artist;
  final String duration;
  final String imagePath;

  const _PlaylistItem({
    required this.title,
    required this.artist,
    required this.duration,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Album Art
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Song Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 4),
                Text(
                  artist,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),

          // Duration
          Text(
            duration,
            style: Theme.of(context).textTheme.bodySmall,
          ),

          const SizedBox(width: 8),

          // Options Menu
          IconButton(
            onPressed: () {},
            icon: SpotifyIcons.getIcon(SpotifyIcons.menu, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20).add(EdgeInsets.only(bottom: 15)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: SpotifyIcons.home,
              isSelected: false,
            ),
            _NavItem(
              icon: SpotifyIcons.search,
              isSelected: false,
            ),
            _NavItem(
              icon: SpotifyIcons.heart,
              isSelected: true,
            ),
            _NavItem(
              icon: SpotifyIcons.profile,
              isSelected: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final bool isSelected;

  const _NavItem({
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isSelected)
          Container(
            width: 20,
            height: 2,
            decoration: const BoxDecoration(
              color: Color(0xFF1ED760),
              borderRadius: BorderRadius.all(Radius.circular(1)),
            ),
          ),
        if (isSelected) const SizedBox(height: 4),
        SpotifyIcons.getIcon(
          icon,
          color: isSelected ? const Color(0xFF1ED760) : const Color(0xFFB3B3B3),
        ),
      ],
    );
  }
}
