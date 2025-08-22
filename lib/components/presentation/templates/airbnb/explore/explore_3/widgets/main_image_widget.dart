import 'package:flutter/material.dart';
import '../../../shared/shared.dart';

class MainImageWidget extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const MainImageWidget({
    super.key,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
            child: Image.network(
              'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Theme.of(context).cardColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home, size: 48),
                      const SizedBox(height: AirbnbConstants.paddingS),
                      Text(
                        'Property Image',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Photo counter
          Positioned(
            bottom: AirbnbConstants.paddingM,
            right: AirbnbConstants.paddingM,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AirbnbConstants.paddingM,
                vertical: AirbnbConstants.paddingS,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(AirbnbConstants.radiusM),
              ),
              child: Text(
                '1/27',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
