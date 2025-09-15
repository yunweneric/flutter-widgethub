import 'package:flutter/material.dart';
import '../../shared/shared.dart';

class Wishlist01 extends StatelessWidget {
  const Wishlist01({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme = Theme.of(context).textTheme;

    return Theme(
      data: isDark ? AirbnbTheme.dark : AirbnbTheme.light,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(AirbnbConstants.paddingL),
                child: Row(
                  children: [
                    Text(
                      'Wishlist',
                      style: textTheme.displayLarge,
                    ),
                    const Spacer(),
                  ],
                ),
              ),

              // Wishlist Items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: AirbnbConstants.paddingL),
                  children: const [
                    WishlistItem(
                      imageUrl: 'https://picsum.photos/seed/nice/80/80',
                      title: 'Nice',
                      dates: 'May 14 - 19, 2023',
                    ),
                    SizedBox(height: AirbnbConstants.height20),
                    WishlistItem(
                      imageUrl: 'https://picsum.photos/seed/chill/80/80',
                      title: 'Chill',
                      dates: 'Jun 2 - 7, 2023',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: const AirbnbBottomNavigationBar(),
      ),
    );
  }
}

class WishlistItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String dates;

  const WishlistItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.dates,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        // Image Thumbnail
        ClipRRect(
          borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
          child: Image.network(
            imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
                ),
                child: Icon(Icons.image, size: 32),
              );
            },
          ),
        ),

        const SizedBox(width: AirbnbConstants.height10),

        // Text Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.displaySmall),
              const SizedBox(height: AirbnbConstants.height5),
              Text(dates, style: textTheme.labelMedium),
            ],
          ),
        ),
      ],
    );
  }
}
