import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/shared/data/components.dart';
import 'package:flutterui/shared/utils/sizing.dart';
import 'package:flutterui/shared/utils/util.dart';
import 'package:flutterui/shared/widgets/chip.dart';
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
                            icon: Icon(AntDesign.dashboard),
                            title: "Preview",
                          ),
                          AppSizing.kwSpacer(10.w),
                          AppChip(
                            active: isCode,
                            onTap: () => setState(() => isCode = true),
                            icon: Icon(AntDesign.codesquareo),
                            title: "Code",
                          ),
                        ],
                      ),
                      AnimatedSwitcher(
                        duration: Duration(seconds: 1),
                        child: isCode
                            ? AppChip(
                                icon: Icon(AntDesign.copy1),
                                title: "Copy",
                              )
                            : Row(
                                children: [
                                  AppChip(
                                    icon: Icon(AntDesign.mobile1),
                                    title: "Mobile",
                                  ),
                                  AppSizing.kwSpacer(10.w),
                                  AppChip(
                                    icon: Icon(AntDesign.tablet1),
                                    title: "Tablet",
                                  ),
                                  AppSizing.kwSpacer(10.w),
                                  AppChip(
                                    icon: Icon(AntDesign.laptop),
                                    title: "Desktop",
                                  )
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Theme.of(context).dividerColor),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                  child: Container(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    height: 500.h,
                    width: AppSizing.width(context),
                    child: SingleChildScrollView(
                      child: AnimatedSwitcher(
                        duration: const Duration(seconds: 1),
                        child: isCode
                            ? Container(
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
                              )
                            : widget.component.widget,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget preview(String widget) {
    return Container(
      child: UtilHelper.convertWidgetToString("./chip.dart"),
    );
  }
}
