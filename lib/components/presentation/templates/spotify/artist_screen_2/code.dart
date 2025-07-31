String artistScreen2 = """import 'package:flutter/material.dart';
import '../shared/theme.dart';
import '../shared/spotify_icons.dart';

class SpotifyArtistScreen2 extends StatelessWidget {
  const SpotifyArtistScreen2({super.key});

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

            // Albums Section
            _AlbumsSection(),

            // Songs Section
            _SongsSection(),
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
      expandedHeight: 350, // Height when fully expanded
      collapsedHeight: 80, // Height when fully collapsed
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFF2A2A2A),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          style: IconButton.styleFrom(backgroundColor: Theme.of(context).cardColor),
          onPressed: () {},
          icon: SpotifyIcons.getIcon(
            SpotifyIcons.back,
            color: Colors.white,
          ),
        ),
      ),
      actions: [
        IconButton(
          style: IconButton.styleFrom(backgroundColor: Theme.of(context).cardColor),
          onPressed: () {},
          icon: SpotifyIcons.getIcon(
            SpotifyIcons.menu,
            color: Colors.white,
          ),
        ),
      ],
      title: Text(
        'Billie Eilish',
        style: Theme.of(context).textTheme.displayMedium,
      ),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Artist Image
              Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=800&h=600&fit=crop'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Artist Name
              Text(
                'Billie Eilish',
                style: Theme.of(context).textTheme.displayMedium,
              ),

              const SizedBox(height: 8),

              // Album and Track Count
              Text(
                '2 Album , 67 Track',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 16),

              // Artist Description
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AlbumsSection extends StatelessWidget {
  const _AlbumsSection();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Albums',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _AlbumCard(
                    title: 'Lilbubblegum',
                    imagePath: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=400&fit=crop',
                  ),
                  SizedBox(width: 16),
                  _AlbumCard(
                    title: 'Happier Than Ever',
                    imagePath: 'https://images.unsplash.com/photo-1511379938547-c1f69419868d?w=400&h=400&fit=crop',
                  ),
                  SizedBox(width: 16),
                  _AlbumCard(
                    title: 'Dont S',
                    imagePath: 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=400&fit=crop',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlbumCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const _AlbumCard({
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: NetworkImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 140,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _SongsSection extends StatelessWidget {
  const _SongsSection();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Songs',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See More',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Songs List
          const _SongItem(
            title: 'Dont Smile At Me',
            artist: 'Billie Eilish',
            duration: '5:33',
          ),
          const _SongItem(
            title: 'Lilbubblegum',
            artist: 'billie eilish',
            duration: '5:33',
          ),
          const _SongItem(
            title: 'Ocean Eyes',
            artist: 'Billie Eilish',
            duration: '3:20',
          ),
          const _SongItem(
            title: 'Bad Guy',
            artist: 'Billie Eilish',
            duration: '3:14',
          ),
          const _SongItem(
            title: 'Everything I Wanted',
            artist: 'Billie Eilish',
            duration: '4:05',
          ),

          const SizedBox(height: 100), // Bottom padding
        ]),
      ),
    );
  }
}

class _SongItem extends StatelessWidget {
  final String title;
  final String artist;
  final String duration;

  const _SongItem({
    required this.title,
    required this.artist,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          // Play Button
          IconButton(
            style: IconButton.styleFrom(backgroundColor: Theme.of(context).cardColor),
            padding: EdgeInsets.zero,
            icon: SpotifyIcons.getIcon(SpotifyIcons.play_arrow),
            onPressed: () {},
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

          // Heart Icon
          IconButton(
            onPressed: () {},
            icon: SpotifyIcons.getIcon(
              SpotifyIcons.heart,
            ),
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

""";
