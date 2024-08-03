import 'dart:math';

import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/shared/data/components.dart';
import 'package:flutterui/shared/data/enums/device_type.dart';
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
  AppDeviceType deviceType = AppDeviceType.MOBILE;

  final duration = const Duration(seconds: 1);
  @override
  initState() {
    setup();
    super.initState();
  }

  setup() async {
    await Highlighter.initialize(['dart', 'yaml', 'sql']);
    var theme = await HighlighterTheme.loadDarkTheme();
    var highlighter = Highlighter(
      language: 'dart',
      theme: theme,
    );
    var highlightedCode = highlighter.highlight(widget.component.code);
    setState(() {
      content = highlightedCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return content == null
        ? CircularProgressIndicator()
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: AppSizing.radiusMd(),
            ),
            width: AppSizing.width(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
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
                            title: "Preview",
                          ),
                          AppSizing.kwSpacer(10.w),
                          AppChip(
                            active: isCode,
                            onTap: () => setState(() => isCode = true),
                            icon: const Icon(AntDesign.codesquareo),
                            title: "Code",
                          ),
                        ],
                      ),
                      TweenAnimationBuilder(
                          duration: Duration(milliseconds: 500),
                          key: ValueKey(isCode),
                          tween: isCode ? Tween<double>(begin: 1, end: 0) : Tween<double>(begin: -1, end: 0),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: isCode ? 1 - value : 1 + value,
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(),
                                child: isCode
                                    ? Transform.translate(
                                        offset: Offset(0, value * 20),
                                        child: const AppChip(
                                          icon: Icon(AntDesign.copy1),
                                          title: "Copy",
                                        ),
                                      )
                                    : Transform.translate(
                                        offset: Offset(0, value * 20),
                                        child: Row(
                                          children: [
                                            AppChip(
                                              icon: const Icon(AntDesign.mobile1),
                                              title: "Mobile",
                                              onTap: () => setState(() => deviceType = AppDeviceType.MOBILE),
                                            ),
                                            AppSizing.kwSpacer(10.w),
                                            AppChip(
                                              icon: const Icon(AntDesign.tablet1),
                                              title: "Tablet",
                                              onTap: () => setState(() => deviceType = AppDeviceType.TABLET),
                                            ),
                                            AppSizing.kwSpacer(10.w),
                                            AppChip(
                                              icon: const Icon(AntDesign.laptop),
                                              title: "Desktop",
                                              onTap: () => setState(() => deviceType = AppDeviceType.DESKTOP),
                                            )
                                          ],
                                        ),
                                      ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                Divider(color: Theme.of(context).dividerColor),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                  child: TweenAnimationBuilder(
                      duration: Duration(milliseconds: 300),
                      key: ValueKey(isCode),
                      tween: isCode ? Tween<double>(begin: 0, end: 1) : Tween<double>(begin: 1, end: 0),
                      builder: (context, value, child) {
                        return Container(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          height: 500.h,
                          width: AppSizing.width(context),
                          child: SingleChildScrollView(
                            child: Stack(
                              children: [
                                Opacity(
                                  opacity: value,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                                    width: AppSizing.width(context),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Theme.of(context).dividerColor),
                                      borderRadius: AppSizing.radiusSm(),
                                      color: Theme.of(context).cardColor,
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
                                    device: deviceType,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
  }

  Widget preview({required Widget child, required AppDeviceType device}) {
    return Container(
      height: 500.h,
      width: AppSizing.width(context),
      child: AnimatedSwitcher(
        duration: duration,
        // key: ValueKey(device),
        child: AppDeviceFrame(
          deviceInfo: UtilHelper.findDevice(type: device),
          child: Center(child: child),
        ),
      ),
    );
  }
}
