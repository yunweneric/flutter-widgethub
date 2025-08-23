// Bottom Navigation Bar
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../shared.dart';

class AirbnbBottomNavigationBar extends StatelessWidget {
  const AirbnbBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 100,
      decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
      child: const SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BottomNavItem(
              svgIcon: AirbnbIconManager.explore,
              label: 'Explore',
              isActive: true,
            ),
            _BottomNavItem(
              svgIcon: AirbnbIconManager.wishlist,
              label: 'Wishlist',
              isActive: false,
            ),
            _BottomNavItem(
              svgIcon: AirbnbIconManager.trips,
              label: 'Trips',
              isActive: false,
            ),
            _BottomNavItem(
              svgIcon: AirbnbIconManager.inbox,
              label: 'Inbox',
              isActive: false,
            ),
            _BottomNavItem(
              svgIcon: AirbnbIconManager.profile,
              label: 'Profile',
              isActive: false,
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

  const _BottomNavItem({
    required this.svgIcon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.string(
          svgIcon,
          colorFilter: ColorFilter.mode(
            isActive ? theme.primaryColor : theme.primaryColorDark,
            BlendMode.srcIn,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? theme.primaryColor : theme.primaryColorDark,
            fontSize: 10,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
