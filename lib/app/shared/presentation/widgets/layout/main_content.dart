import 'package:flutter/material.dart';
import 'package:flutterui/app/core/routes/route_names.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/component_footer.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
import 'package:flutterui/app/shared/presentation/widgets/ui/app_button.dart';
import 'package:go_router/go_router.dart';

/// Docs content column: max-width, generous padding, back link on top and
/// the component footer at the bottom.
class MainContent extends StatefulWidget {
  final List<Widget> children;
  const MainContent({super.key, required this.children});

  /// Maximum width of the readable content column.
  static const double maxContentWidth = 960;

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool isMobile = AppSizing.isMobile(context);

    return Scaffold(
      backgroundColor: tokens.background,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: MainContent.maxContentWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? AppSpace.lg : AppSpace.xxl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpace.xl),
                  AppButton(
                    label: LangUtil.trans("back"),
                    variant: AppButtonVariant.ghost,
                    size: AppButtonSize.sm,
                    leading: const AppIcon(icon: AppIcons.back, size: 14),
                    onPressed: () => context.go(RouteNames.components),
                  ),
                  const SizedBox(height: AppSpace.xl),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: AppSizing.kHPercentage(context, 60)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [...widget.children],
                    ),
                  ),
                  const SizedBox(height: AppSpace.xxl),
                  Container(height: 1, color: tokens.border),
                  const ComponentFooter(),
                  const SizedBox(height: AppSpace.huge),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
