import 'dart:math';

import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/shared/data/components.dart';
import 'package:flutterui/shared/data/enums/device_type.dart';
import 'package:flutterui/shared/data/enums/theme.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/utils/util.dart';
import 'package:flutterui/shared/ui/widgets/chip.dart';
import 'package:flutterui/shared/ui/widgets/device_frame.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class CodeHighlighter extends StatefulWidget {
  final Component component;
  const CodeHighlighter({super.key, required this.component});

  @override
  State<CodeHighlighter> createState() => _CodeHighlighterState();
}

class _CodeHighlighterState extends State<CodeHighlighter> {
  Future<Text>? futureWidget;
  TextSpan? content;
  bool isCode = false;
  AppDeviceType selectedDevice = AppDeviceType.MOBILE;

  final duration = const Duration(seconds: 1);

  final themBloc = getIt.get<ThemeBloc>();
  @override
  initState() {
    // setupHighLighter(Theme.of(context).brightness);
    super.initState();
  }

  setupHighLighter(Brightness brightness) async {
    await Highlighter.initialize(['dart', 'yaml']);
    var lightTheme = await HighlighterTheme.loadLightTheme();
    var darkTheme = await HighlighterTheme.loadDarkTheme();

    var highlighter = Highlighter(
      language: 'dart',
      theme: brightness == Brightness.dark ? darkTheme : lightTheme,
    );
    var highlightedCode = highlighter.highlight(widget.component.code);
    setState(() {
      content = highlightedCode;
    });
  }

  List<DropdownMenuEntry> menu = [
    DropdownMenuEntry(value: AppDeviceType.MOBILE, label: AppDeviceType.MOBILE.describe()),
    DropdownMenuEntry(value: AppDeviceType.TABLET, label: AppDeviceType.TABLET.describe()),
    DropdownMenuEntry(value: AppDeviceType.DESKTOP, label: AppDeviceType.DESKTOP.describe()),
  ];

  Widget generateDeviceIcon(AppDeviceType selectedDevice) {
    if (selectedDevice == AppDeviceType.MOBILE) return Icon(AntDesign.mobile1, size: 20.w, color: Theme.of(context).highlightColor);
    if (selectedDevice == AppDeviceType.TABLET) return Icon(AntDesign.tablet1, size: 20.w, color: Theme.of(context).highlightColor);
    if (selectedDevice == AppDeviceType.DESKTOP) return Icon(AntDesign.laptop, size: 20.w, color: Theme.of(context).highlightColor);
    return Icon(AntDesign.mobile1, size: 20.w, color: Theme.of(context).highlightColor);
  }

  @override
  Widget build(BuildContext context) {
    setupHighLighter(Theme.of(context).brightness);

    return content == null
        ? loader(context)
        : BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              setupHighLighter(Theme.of(context).brightness);
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
                      codeAndPreview(),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget codeAndPreview() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 300),
        key: ValueKey(isCode),
        tween: isCode ? Tween<double>(begin: 0, end: 1) : Tween<double>(begin: 1, end: 0),
        builder: (context, value, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: value,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                  width: AppSizing.width(context),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: AppSizing.radiusSm(),
                  ),
                  child: Text.rich(
                    content!,
                    style: GoogleFonts.spaceMono(fontSize: 14.sp, height: 1.7.h, wordSpacing: 7.w),
                  ),
                ),
              ),
              Opacity(
                opacity: 1 - value,
                child: preview(
                  child: widget.component.widget,
                  device: selectedDevice,
                ),
              ),
            ],
          );
        },
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
                icon: const Icon(AntDesign.dashboard),
                title: AppSizing.isMobile(context) ? null : "Preview",
              ),
              AppSizing.kwSpacer(10.w),
              AppChip(
                active: isCode,
                onTap: () => setState(() => isCode = true),
                icon: const Icon(AntDesign.codesquareo),
                title: AppSizing.isMobile(context) ? null : "Code",
              ),
            ],
          ),

          // if (AppSizing.isDesktop(context))
          TweenAnimationBuilder(
            duration: Duration(milliseconds: 500),
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
                            icon: const Icon(AntDesign.copy1),
                            title: AppSizing.isMobile(context) ? null : "Copy",
                          ),
                        )
                      : Transform.translate(
                          offset: Offset(0, value * 20),
                          child: !AppSizing.isDesktop(context)
                              ? selectDevices()
                              : Row(
                                  children: [
                                    AppChip(
                                      icon: const Icon(AntDesign.mobile1),
                                      title: "Mobile",
                                      onTap: () => setState(() => selectedDevice = AppDeviceType.MOBILE),
                                    ),
                                    AppSizing.kwSpacer(10.w),
                                    AppChip(
                                      icon: const Icon(AntDesign.tablet1),
                                      title: "Tablet",
                                      onTap: () => setState(() => selectedDevice = AppDeviceType.TABLET),
                                    ),
                                    AppSizing.kwSpacer(10.w),
                                    AppChip(
                                      icon: const Icon(AntDesign.laptop),
                                      title: "Desktop",
                                      onTap: () => setState(() => selectedDevice = AppDeviceType.DESKTOP),
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
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget preview({required Widget child, required AppDeviceType device}) {
    return SizedBox(
      child: AnimatedSwitcher(
        duration: duration,
        child: AppDeviceFrame(
          deviceInfo: UtilHelper.findDevice(type: device),
          isFrameVisible: true,
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
      trailingIcon: Icon(Icons.keyboard_arrow_down_outlined, size: 20.w, color: Theme.of(context).highlightColor),
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
