import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
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

  List<DropdownMenuEntry> menu = [
    DropdownMenuEntry(value: AppDeviceType.MOBILE, label: AppDeviceType.MOBILE.describe()),
    DropdownMenuEntry(value: AppDeviceType.TABLET, label: AppDeviceType.TABLET.describe()),
    DropdownMenuEntry(value: AppDeviceType.DESKTOP, label: AppDeviceType.DESKTOP.describe()),
  ];

  Widget generateDeviceIcon(AppDeviceType selectedDevice) {
    if (selectedDevice == AppDeviceType.MOBILE) return icon(AppIcons.mobile);
    if (selectedDevice == AppDeviceType.TABLET) return icon(AppIcons.tablet);
    if (selectedDevice == AppDeviceType.DESKTOP) return icon(AppIcons.desktop);
    return icon(AppIcons.mobile);
  }

  Widget icon(String file) {
    return Transform.scale(scale: 0.6, child: AppIcon(icon: file, size: 10.w));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: AppSizing.radiusMd(),
          ),
          width: AppSizing.width(context),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topBar(context),
                codeAndPreview(
                  code: widget.component.codeComponents.first.code,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget codeAndPreview({required String code, BorderRadiusGeometry? borderRadius}) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1300),
      child: isCode
          ? Container(
              width: AppSizing.width(context),
              decoration: BoxDecoration(borderRadius: AppSizing.radiusSm()),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: CodeHighlight(
                  code: code,
                  borderRadius: borderRadius ?? AppSizing.radiusSm(),
                ),
              ),
            )
          : preview(
              child: widget.component.codeComponents.first.widget,
              device: selectedDevice,
            ),
    );
  }

  Container topBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppChip(
                onTap: () => setState(() => isCode = false),
                active: !isCode,
                icon: AppIcons.tab,
                title: AppSizing.isMobile(context) ? null : LangUtil.trans("preview"),
              ),
              AppSizing.kwSpacer(10.w),
              AppChip(
                active: isCode,
                onTap: () => setState(() => isCode = true),
                icon: AppIcons.code,
                title: AppSizing.isMobile(context) ? null : LangUtil.trans("code"),
              ),
            ],
          ),
          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 500),
            key: ValueKey(isCode),
            tween: isCode ? Tween<double>(begin: 1, end: 0) : Tween<double>(begin: -1, end: 0),
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
                            onTap: () async {
                              setState(() => hasCopied = true);
                              UtilHelper.copy(context, data: widget.component.codeComponents.first.code);
                              Future.delayed(const Duration(seconds: 5), () {
                                setState(() => hasCopied = false);
                              });
                            },
                          ),
                        )
                      : Transform.translate(
                          offset: Offset(0, value * 20),
                          child: !AppSizing.isDesktop(context)
                              ? selectDevices()
                              : Row(
                                  children: [
                                    TweenAnimationBuilder(
                                      duration: const Duration(milliseconds: 500),
                                      key: ValueKey(hideSizers),
                                      tween: !hideSizers ? Tween<double>(begin: 1, end: 0) : Tween<double>(begin: 0, end: 1),
                                      builder: (context, value, child) {
                                        List<AppDeviceType> platforms = widget.component.responsiveDevices;
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
                                                      title: LangUtil.trans(platform.describe().toLowerCase()),
                                                      onTap: () => setState(() => selectedDevice = platform),
                                                    ),
                                                  );
                                                }),
                                                // AppChip(
                                                //   active: selectedDevice == AppDeviceType.MOBILE,
                                                //   icon: AppIcons.mobile,
                                                //   title: LangUtil.trans("mobile"),
                                                //   onTap: () => setState(() => selectedDevice = AppDeviceType.MOBILE),
                                                // ),
                                                // AppSizing.kwSpacer(10.w),
                                                // AppChip(
                                                //   active: selectedDevice == AppDeviceType.TABLET,
                                                //   icon: AppIcons.tablet,
                                                //   title: LangUtil.trans("tablet"),
                                                //   onTap: () => setState(() => selectedDevice = AppDeviceType.TABLET),
                                                // ),
                                                // AppSizing.kwSpacer(10.w),
                                                // AppChip(
                                                //   active: selectedDevice == AppDeviceType.DESKTOP,
                                                //   icon: AppIcons.desktop,
                                                //   title: LangUtil.trans("desktop"),
                                                //   onTap: () => setState(() => selectedDevice = AppDeviceType.DESKTOP),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    AppSizing.kwSpacer(10.w),
                                    Switch.adaptive(
                                      value: isFrameVisible,
                                      onChanged: (val) {
                                        setState(() {
                                          hideSizers = val;
                                          isFrameVisible = val;
                                        });
                                      },
                                    )
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

  Container loader(BuildContext context) {
    return Container(
      height: 500.h,
      color: Theme.of(context).cardColor,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget preview({required Widget child, required AppDeviceType device}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 45.h),
      child: AnimatedSwitcher(
        duration: duration,
        child: AppDeviceFrame(
          deviceInfo: UtilHelper.findDevice(type: device),
          isFrameVisible: isFrameVisible,
          child: child,
        ),
      ),
    );
  }

  Widget selectDevices() {
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
      onSelected: (device) => setState(() => selectedDevice = device),
      textStyle: Theme.of(context).textTheme.bodyMedium,
      leadingIcon: generateDeviceIcon(selectedDevice),
      trailingIcon: AppIcon(icon: AppIcons.chevron_down, color: Theme.of(context).highlightColor),
      dropdownMenuEntries: menu,
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
