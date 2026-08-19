import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/core/routes/route_names.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/sidebar/sidebar_bloc.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_icon_button.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_logo.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_search_bar.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
import 'package:flutterui/app/shared/presentation/widgets/theme_variant_button.dart';
import 'package:go_router/go_router.dart';

/// Floating top navigation (mobile): menu + logo on the left, search and
/// the theme control on the right — same pill as desktop.
class HomeMobileNav extends StatefulWidget {
  final bool isHomeScreenLayout;
  const HomeMobileNav({super.key, required this.isHomeScreenLayout});

  /// Total vertical space the floating mobile bar occupies.
  static const double navHeight = 76;

  @override
  State<HomeMobileNav> createState() => _HomeMobileNavState();
}

class _HomeMobileNavState extends State<HomeMobileNav> {
  final sidebarBloc = getIt.get<SidebarBloc>();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<SidebarBloc, SidebarState>(
      builder: (context, sidebarState) {
        return Container(
          width: double.infinity,
          height: HomeMobileNav.navHeight,
          padding: const EdgeInsets.fromLTRB(
              AppSpace.md, AppSpace.md, AppSpace.md, AppSpace.md),
          child: Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.sm),
            decoration: BoxDecoration(
              color: tokens.card.withValues(alpha: isDark ? 0.9 : 0.92),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: tokens.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                AppIconButton(
                  onPressed: () {
                    sidebarBloc.add(
                      UpdateSideBarEvent(newStatus: !sidebarState.isOpen),
                    );
                  },
                  child: const AppIcon(icon: AppIcons.menu, size: 20),
                ),
                const SizedBox(width: AppSpace.xs),
                AppLogo(
                  width: 84,
                  onTap: () => context.go(RouteNames.home),
                ),
                const Spacer(),
                AppIconButton(
                  onPressed: () => showSearchModal(context),
                  child: const AppIcon(icon: AppIcons.search, size: 16),
                ),
                const SizedBox(width: AppSpace.xs),
                const ThemeControlButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
