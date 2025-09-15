// Bottom Navigation Bar
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../shared.dart';

class AirbnbBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const AirbnbBottomNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: AirbnbTheme.black.withOpacity(0.1),
            blurRadius: AirbnbConstants.elevationL,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomNavItem(
              svgIcon: AirbnbIconManager.explore,
              label: 'Explore',
              isActive: currentIndex == 0,
            ),
            _BottomNavItem(
              svgIcon: AirbnbIconManager.wishlist,
              label: 'Wishlist',
              isActive: currentIndex == 1,
            ),
            _BottomNavItem(
              svgIcon: AirbnbIconManager.trips,
              label: 'Trips',
              isActive: currentIndex == 2,
            ),
            _BottomNavItem(
              svgIcon: AirbnbIconManager.inbox,
              label: 'Inbox',
              isActive: currentIndex == 3,
              showNotification: true,
            ),
            _BottomNavItem(
              svgIcon: AirbnbIconManager.profile,
              label: 'Profile',
              isActive: currentIndex == 4,
            ),
          ],
        ),
      ),
    );
  }
}

// Bottom Navigation Item
class _BottomNavItem extends StatelessWidget {
  final String svgIcon;
  final String label;
  final bool isActive;
  final bool showNotification;

  const _BottomNavItem({
    required this.svgIcon,
    required this.label,
    required this.isActive,
    this.showNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            SvgPicture.string(
              svgIcon,
              colorFilter: ColorFilter.mode(
                isActive ? AirbnbTheme.primaryRed : AirbnbTheme.mediumGray,
                BlendMode.srcIn,
              ),
            ),
            if (showNotification)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AirbnbTheme.primaryRed,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? AirbnbTheme.primaryRed : AirbnbTheme.mediumGray,
            fontSize: 10,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
