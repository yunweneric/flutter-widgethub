import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/chip.dart';
import 'package:flutterui/app/shared/presentation/widgets/code_highlight.dart';
import 'package:flutterui/app/shared/presentation/widgets/device_frame.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

class CodePreview extends StatefulWidget {
  final Component component;
  const CodePreview({super.key, required this.component});

  static List<DropdownMenuEntry> get menu => [
        DropdownMenuEntry(
            value: AppDeviceType.MOBILE, label: AppDeviceType.MOBILE.describe()),
        DropdownMenuEntry(
            value: AppDeviceType.TABLET, label: AppDeviceType.TABLET.describe()),
        DropdownMenuEntry(
            value: AppDeviceType.DESKTOP, label: AppDeviceType.DESKTOP.describe()),
      ];

  @override
  State<CodePreview> createState() => _CodePreviewState();
}

class _CodePreviewState extends State<CodePreview> {
  Future<Text>? futureWidget;
  TextSpan? content;
  bool hideSizers = true;
  bool isCode = false;
  bool hasCopied = false;
  AppDeviceType selectedDevice = AppDeviceType.MOBILE;

  final duration = const Duration(seconds: 1);
  bool isFrameVisible = true;
  final themBloc = getIt.get<ThemeBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          width: AppSizing.width(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopBar(
                isCode: isCode,
                hasCopied: hasCopied,
                selectedDevice: selectedDevice,
                hideSizers: hideSizers,
                component: widget.component,
                onPreviewTap: () => setState(() => isCode = false),
                onCodeTap: () => setState(() => isCode = true),
                onCopyTap: () {
                  setState(() => hasCopied = true);
                  UtilHelper.copy(context,
                      data: widget.component.codeComponents.first.code);
                  Future.delayed(const Duration(seconds: 5), () {
                    setState(() => hasCopied = false);
                  });
                },
                onDeviceSelected: (device) => setState(() => selectedDevice = device),
              ),
              _CodeAndPreview(
                isCode: isCode,
                code: widget.component.codeComponents.first.code,
                previewWidget: widget.component.codeComponents.first.widget,
                selectedDevice: selectedDevice,
                isFrameVisible: isFrameVisible,
                duration: duration,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DeviceIcon extends StatelessWidget {
  final AppDeviceType deviceType;
  const _DeviceIcon({required this.deviceType});

  @override
  Widget build(BuildContext context) {
    String iconPath;
    switch (deviceType) {
      case AppDeviceType.MOBILE:
        iconPath = AppIcons.mobile;
        break;
      case AppDeviceType.TABLET:
        iconPath = AppIcons.tablet;
        break;
      case AppDeviceType.DESKTOP:
        iconPath = AppIcons.desktop;
        break;
    }
    return Transform.scale(
      scale: 0.6,
      child: AppIcon(icon: iconPath, size: 10.w),
    );
  }
}

class _CodeAndPreview extends StatelessWidget {
  final bool isCode;
  final String code;
  final Widget previewWidget;
  final AppDeviceType selectedDevice;
  final bool isFrameVisible;
  final Duration duration;

  const _CodeAndPreview({
    required this.isCode,
    required this.code,
    required this.previewWidget,
    required this.selectedDevice,
    required this.isFrameVisible,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.02),
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
          ? Container(
              key: const ValueKey('code'),
              width: AppSizing.width(context),
              padding: EdgeInsets.all(16.w),
              child: CodeHighlight(
                code: code,
                borderRadius: BorderRadius.circular(12.r),
              ),
            )
          : Container(
              key: const ValueKey('preview'),
              child: _Preview(
                isFrameVisible: isFrameVisible,
                duration: duration,
                child: previewWidget,
              ),
            ),
    );
  }
}

class _Preview extends StatelessWidget {
  final Widget child;
  final bool isFrameVisible;
  final Duration duration;

  const _Preview({
    required this.child,
    required this.isFrameVisible,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 40.h),
      child: AnimatedSwitcher(
        duration: duration,
        child: AppDeviceFrame(
          isFrameVisible: isFrameVisible,
          child: child,
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final bool isCode;
  final bool hasCopied;
  final AppDeviceType selectedDevice;
  final bool hideSizers;
  final Component component;
  final VoidCallback onPreviewTap;
  final VoidCallback onCodeTap;
  final VoidCallback onCopyTap;
  final void Function(AppDeviceType) onDeviceSelected;

  const _TopBar({
    required this.isCode,
    required this.hasCopied,
    required this.selectedDevice,
    required this.hideSizers,
    required this.component,
    required this.onPreviewTap,
    required this.onCodeTap,
    required this.onCopyTap,
    required this.onDeviceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        // color: Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppChip(
                onTap: onPreviewTap,
                active: !isCode,
                icon: AppIcons.tab,
                title: AppSizing.isMobile(context) ? null : LangUtil.trans("preview"),
              ),
              KwSpacer(width: 10.w),
              AppChip(
                active: isCode,
                onTap: onCodeTap,
                icon: AppIcons.code,
                title: AppSizing.isMobile(context) ? null : LangUtil.trans("code"),
              ),
            ],
          ),
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 500),
            key: ValueKey(isCode),
            tween: isCode
                ? Tween<double>(begin: 1, end: 0)
                : Tween<double>(begin: -1, end: 0),
            builder: (context, value, child) {
              return Opacity(
                opacity: isCode ? 1 - value : 1 + value,
                child: Container(
                  child: isCode
                      ? Transform.translate(
                          offset: Offset(0, value * 20),
                          child: AppChip(
                            icon: AppIcons.clipboard,
                            title: AppSizing.isMobile(context)
                                ? null
                                : hasCopied
                                    ? LangUtil.trans('copied')
                                    : LangUtil.trans("copy"),
                            onTap: onCopyTap,
                          ),
                        )
                      : Transform.translate(
                          offset: Offset(0, value * 20),
                          child: !AppSizing.isDesktop(context)
                              ? _SelectDevices(
                                  selectedDevice: selectedDevice,
                                  onDeviceSelected: onDeviceSelected,
                                )
                              : Row(
                                  children: [
                                    TweenAnimationBuilder(
                                      duration: const Duration(milliseconds: 500),
                                      key: ValueKey(hideSizers),
                                      tween: !hideSizers
                                          ? Tween<double>(begin: 1, end: 0)
                                          : Tween<double>(begin: 0, end: 1),
                                      builder: (context, value, child) {
                                        List<AppDeviceType> platforms =
                                            component.responsiveDevices;
                                        return Transform(
                                          alignment: Alignment.centerRight,
                                          transform: Matrix4.identity()..scale(value),
                                          child: Opacity(
                                            opacity: value,
                                            child: Row(
                                              children: [
                                                ...platforms.map((platform) {
                                                  return Container(
                                                    margin: EdgeInsets.only(right: 10.w),
                                                    child: AppChip(
                                                      active: selectedDevice == platform,
                                                      icon: platform.generateIcon(),
                                                      title: LangUtil.trans(platform
                                                          .describe()
                                                          .toLowerCase()),
                                                      onTap: () =>
                                                          onDeviceSelected(platform),
                                                    ),
                                                  );
                                                }),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    KwSpacer(width: 10.w),
                                  ],
                                ),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SelectDevices extends StatelessWidget {
  final AppDeviceType selectedDevice;
  final void Function(AppDeviceType) onDeviceSelected;

  const _SelectDevices({
    required this.selectedDevice,
    required this.onDeviceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: 150.w,
      menuStyle: MenuStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r),
            ),
          ),
        ),
      ),
      initialSelection: selectedDevice,
      onSelected: (device) => onDeviceSelected(device ?? selectedDevice),
      textStyle: Theme.of(context).textTheme.bodyMedium,
      leadingIcon: _DeviceIcon(deviceType: selectedDevice),
      trailingIcon:
          AppIcon(icon: AppIcons.chevron_down, color: Theme.of(context).highlightColor),
      dropdownMenuEntries: CodePreview.menu,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Theme.of(context).cardColor,
        outlineBorder: BorderSide.none,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: AppSizing.radiusMd(),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: AppSizing.radiusMd(),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: AppSizing.radiusMd(),
        ),
      ),
    );
  }
}
