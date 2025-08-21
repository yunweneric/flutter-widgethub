import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';
import '../shared.dart';

class AirbnbSearchBar extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onFilterTap;

  const AirbnbSearchBar({
    super.key,
    this.onTap,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AirbnbConstants.paddingL,
        vertical: AirbnbConstants.paddingM,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AirbnbConstants.radiusXXL),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AirbnbConstants.paddingL,
            vertical: AirbnbConstants.paddingM,
          ),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(AirbnbConstants.radiusXXL),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              SvgPicture.string(
                AirbnbIconManager.search,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  theme.colorScheme.onSurface.withOpacity(0.6),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: AirbnbConstants.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Where to?', style: textTheme.displaySmall),
                    Text(
                      'Anywhere • Any week • Add guests',
                      style: textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AirbnbConstants.paddingM),
              GestureDetector(
                onTap: onFilterTap,
                child: Container(
                  padding: const EdgeInsets.all(AirbnbConstants.paddingS),
                  decoration: BoxDecoration(border: Border.all(), shape: BoxShape.circle),
                  child: SvgPicture.string(
                    AirbnbIconManager.filter,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
