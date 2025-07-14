String spotifyHomepageCode = """
import 'package:flutter/material.dart';
import '../shared/logo.dart';
import '../shared/theme.dart';

// Data Models
class AlbumData {
  final String imageUrl;
  final String title;
  final String artist;

  const AlbumData({
    required this.imageUrl,
    required this.title,
    required this.artist,
  });
}

class PlaylistItemData {
  final String title;
  final String artist;
  final String duration;

  const PlaylistItemData({
    required this.title,
    required this.artist,
    required this.duration,
  });
}

// Main Widget
class SpotifyHomepage extends StatefulWidget {
  const SpotifyHomepage({super.key});

  @override
  State<SpotifyHomepage> createState() => _SpotifyHomepageState();
}

class _SpotifyHomepageState extends State<SpotifyHomepage> {
  // State variables
  int currentIndex = 0;

  // Static data
  static const List<String> categories = ['News', 'Video', 'Artists', 'Podcast'];

  static const List<AlbumData> albums = [
    AlbumData(
      imageUrl: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=200',
      title: 'Bad Guy',
      artist: 'Billie Eilish',
    ),
    AlbumData(
      imageUrl: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=200',
      title: 'Scorpion',
      artist: 'Drake',
    ),
    AlbumData(
      imageUrl: 'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=200',
      title: 'Midnight',
      artist: 'Taylor Swift',
    ),
  ];

  static const List<PlaylistItemData> playlist = [
    PlaylistItemData(
      title: 'As It Was',
      artist: 'Harry Styles',
      duration: '5:33',
    ),
    PlaylistItemData(
      title: 'God Did',
      artist: 'DJ Khaled',
      duration: '3:43',
    ),
    PlaylistItemData(
      title: 'Blinding Lights',
      artist: 'The Weeknd',
      duration: '3:20',
    ),
    PlaylistItemData(
      title: 'Levitating',
      artist: 'Dua Lipa',
      duration: '3:23',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SpotifyTheme.dark,
      child: Builder(builder: (context) {
        final theme = Theme.of(context);
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _buildTopNavigationBar(theme),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        _buildFeaturedAlbumBanner(theme),
                        const SizedBox(height: 24),
                        _buildCategoryTabs(),
                        const SizedBox(height: 24),
                        _buildAlbumCards(),
                        const SizedBox(height: 32),
                        _buildPlaylistSection(theme),
                        const SizedBox(height: 100), // Space for bottom navigation
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: _BottomNavigationBar(),
        );
      }),
    );
  }

  // Top Navigation Bar
  Widget _buildTopNavigationBar(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          _buildCircularIconButton(
            icon: Icons.search,
            onPressed: () {},
            theme: theme,
          ),
          const Spacer(),
          const SpotifyLogo(width: 100, height: 32),
          const Spacer(),
          _buildCircularIconButton(
            icon: Icons.more_vert,
            onPressed: () {},
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIconButton({
    required IconData icon,
    required VoidCallback onPressed,
    required ThemeData theme,
  }) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: theme.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      icon: Icon(icon, size: 24, color: Colors.white),
      onPressed: onPressed,
      splashRadius: 24,
    );
  }

  // Featured Album Banner
  Widget _buildFeaturedAlbumBanner(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1ED760), Color(0xFF1DB954)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Background image overlay
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400',
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.1,
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New Album',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Happier Than Ever',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Billie Eilish',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                // Artist image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=200',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Category Tabs
  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              right: 16.0,
              left: index == 0 ? 16 : 20,
            ),
            child: _CategoryTab(
              text: categories[index],
              isActive: index == currentIndex,
              onTap: () => setState(() => currentIndex = index),
            ),
          );
        },
        itemCount: categories.length,
      ),
    );
  }

  // Album Cards Section
  Widget _buildAlbumCards() {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: albums.length,
        itemBuilder: (context, index) {
          final album = albums[index];
          return Container(
            margin: EdgeInsets.only(
              right: 16.0,
              left: index == 0 ? 16 : 15,
            ),
            child: _AlbumCard(
              imageUrl: album.imageUrl,
              title: album.title,
              artist: album.artist,
            ),
          );
        },
      ),
    );
  }

  // Playlist Section
  Widget _buildPlaylistSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Playlist',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'See More',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFFB3B3B3),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: playlist.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = playlist[index];
            return _PlaylistItem(
              title: item.title,
              artist: item.artist,
              duration: item.duration,
            );
          },
        ),
      ],
    );
  }
}

// Category Tab Widget
class _CategoryTab extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const _CategoryTab({
    required this.text,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isActive ? Colors.white : const Color(0xFFB3B3B3),
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 40,
            height: 3,
            decoration: BoxDecoration(
              color: isActive ? theme.primaryColor : Colors.transparent,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Album Card Widget
class _AlbumCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String artist;

  const _AlbumCard({
    required this.imageUrl,
    required this.title,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 140,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                artist,
                style: const TextStyle(
                  color: Color(0xFFB3B3B3),
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Playlist Item Widget
class _PlaylistItem extends StatelessWidget {
  final String title;
  final String artist;
  final String duration;

  const _PlaylistItem({
    required this.title,
    required this.artist,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Play button
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF535353),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.play_arrow,
              color: Color(0xFFFFFFFF),
              size: 18,
            ),
          ),
          const SizedBox(width: 16),
          // Song info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  artist,
                  style: const TextStyle(
                    color: Color(0xFFB3B3B3),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Duration
          Text(
            duration,
            style: const TextStyle(
              color: Color(0xFFB3B3B3),
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 16),
          // Heart icon
          const Icon(
            Icons.favorite_border,
            color: Color(0xFF535353),
            size: 22,
          ),
        ],
      ),
    );
  }
}

// Bottom Navigation Bar
class _BottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF181818),
        border: Border(
          top: BorderSide(
            color: const Color(0xFF282828),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavItem(
            icon: Icons.home,
            label: 'Home',
            isActive: true,
          ),
          _BottomNavItem(
            icon: Icons.explore,
            label: 'Search',
            isActive: false,
          ),
          _BottomNavItem(
            icon: Icons.favorite_border,
            label: 'Your Library',
            isActive: false,
          ),
          _BottomNavItem(
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: false,
          ),
        ],
      ),
    );
  }
}

// Bottom Navigation Item
class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF1ED760) : const Color(0xFFB3B3B3),
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF1ED760) : const Color(0xFFB3B3B3),
            fontSize: 10,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

""";
