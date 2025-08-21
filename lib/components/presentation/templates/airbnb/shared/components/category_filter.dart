import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import '../shared.dart';

class CategoryFilter extends StatefulWidget {
  const CategoryFilter({super.key});

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {
      'name': 'OMG!',
      'icon': AirbnbIconManager.ufo,
      'isSelected': true,
    },
    {
      'name': 'Beach',
      'icon': AirbnbIconManager.island,
      'isSelected': false,
    },
    {
      'name': 'Amazing pools',
      'icon': AirbnbIconManager.pool,
      'isSelected': false,
    },
    {
      'name': 'Islands',
      'icon': AirbnbIconManager.island,
      'isSelected': false,
    },
    {
      'name': 'Arctic',
      'icon': AirbnbIconManager.ice,
      'isSelected': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 90,
      margin: const EdgeInsets.only(bottom: AirbnbConstants.paddingM),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AirbnbConstants.paddingL),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: AirbnbConstants.paddingM),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(AirbnbConstants.paddingM),
                    decoration: BoxDecoration(
                      color: isSelected ? colorScheme.onSurface : colorScheme.surface,
                      borderRadius: BorderRadius.circular(AirbnbConstants.radiusL),
                      // border: Border.all(
                      //   color: isSelected
                      //       ? colorScheme.onSurface
                      //       : colorScheme.outline.withOpacity(0.3),
                      //   width: 1,
                      // ),
                    ),
                    child: SvgPicture.string(
                      category['icon'],
                      colorFilter: ColorFilter.mode(
                        isSelected ? colorScheme.surface : colorScheme.onSurface,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(height: AirbnbConstants.paddingXS),
                  Text(
                    category['name'],
                    style: textTheme.labelSmall?.copyWith(
                      color: isSelected
                          ? colorScheme.onSurface
                          : colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  if (isSelected)
                    Container(
                      margin: const EdgeInsets.only(top: AirbnbConstants.paddingXS),
                      width: 20,
                      height: 2,
                      decoration: BoxDecoration(
                        color: colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
