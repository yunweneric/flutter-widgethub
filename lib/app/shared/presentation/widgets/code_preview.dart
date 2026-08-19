import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/chip.dart';
import 'package:flutterui/app/shared/presentation/widgets/code_highlight.dart';
import 'package:flutterui/app/shared/presentation/widgets/device_frame.dart';
import 'package:flutterui/app/shared/presentation/widgets/fullscreen_preview.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
import 'package:flutterui/app/shared/presentation/widgets/ui/app_tabs.dart';

/// Live preview / source code panel for a component (shadcn docs style):
/// segmented Preview | Code tabs on a bordered rounded canvas.
class CodePreview extends StatefulWidget {
  final Component component;
  const CodePreview({super.key, required this.component});

  @override
  State<CodePreview> createState() => _CodePreviewState();
}

class _CodePreviewState extends State<CodePreview> {
  bool isCode = false;
  AppDeviceType selectedDevice = AppDeviceType.MOBILE;

  final duration = const Duration(seconds: 1);
  final bool isFrameVisible = true;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toolbar: tabs left, device sizes right.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTabs(
                  activeIndex: isCode ? 1 : 0,
                  onChanged: (i) => setState(() => isCode = i == 1),
                  items: [
                    AppTabItem(
                      label: LangUtil.trans("preview"),
                      icon: const AppIcon(icon: AppIcons.preview),
                    ),
                    AppTabItem(
                      label: LangUtil.trans("code"),
                      icon: const AppIcon(icon: AppIcons.code),
                    ),
                  ],
                ),
                if (!isCode)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _DeviceSelector(
                        component: widget.component,
                        selectedDevice: selectedDevice,
                        onDeviceSelected: (device) =>
                            setState(() => selectedDevice = device),
                      ),
                      const SizedBox(width: AppSpace.xs),
                      FullscreenPreviewButton(component: widget.component),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: AppSpace.md),

            // Canvas.
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.01),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    )),
                    child: child,
                  ),
                );
              },
              child: isCode
                  ? SizedBox(
                      key: const ValueKey('code'),
                      width: double.infinity,
                      child: CodeHighlight(
                        code: widget.component.codeComponents.first.code,
                        title:
                            '${widget.component.id.replaceAll('-', '_')}.dart',
                      ),
                    )
                  : Container(
                      key: const ValueKey('preview'),
                      width: double.infinity,
                      padding:
                          const EdgeInsets.symmetric(vertical: AppSpace.xxl),
                      decoration: BoxDecoration(
                        color: tokens.background,
                        borderRadius: AppRadii.lgAll,
                        border: Border.all(color: tokens.border),
                      ),
                      child: AnimatedSwitcher(
                        duration: duration,
                        child: AppDeviceFrame(
                          isFrameVisible: isFrameVisible,
                          child: widget.component.codeComponents.first.widget,
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}

/// Device-size selector shown while previewing.
class _DeviceSelector extends StatelessWidget {
  final Component component;
  final AppDeviceType selectedDevice;
  final void Function(AppDeviceType) onDeviceSelected;

  const _DeviceSelector({
    required this.component,
    required this.selectedDevice,
    required this.onDeviceSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bool compact = !AppSizing.isDesktop(context);
    final platforms = component.responsiveDevices;
    if (platforms.length <= 1) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...platforms.map((platform) {
          return Container(
            margin: const EdgeInsets.only(left: AppSpace.xs),
            child: AppChip(
              active: selectedDevice == platform,
              icon: platform.generateIcon(),
              title: compact
                  ? null
                  : LangUtil.trans(platform.describe().toLowerCase()),
              onTap: () => onDeviceSelected(platform),
            ),
          );
        }),
      ],
    );
  }
}
