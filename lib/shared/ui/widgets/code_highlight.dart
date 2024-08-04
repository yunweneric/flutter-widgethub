import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/chip.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class CodeHighlight extends StatefulWidget {
  final String code;
  const CodeHighlight({super.key, required this.code});

  @override
  State<CodeHighlight> createState() => _CodeHighlightState();
}

class _CodeHighlightState extends State<CodeHighlight> {
  Future<Text>? futureWidget;
  TextSpan? content;
  final duration = const Duration(seconds: 1);
  bool hasCopied = false;
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
    var highlightedCode = highlighter.highlight(widget.code);
    setState(() {
      content = highlightedCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    setupHighLighter(Theme.of(context).brightness);
    return content == null ? loader(context) : codeAndPreview();
  }

  Widget codeAndPreview() {
    return Stack(
      children: [
        Container(
          // alignment: Alignment.center,
          width: AppSizing.width(context),
          // constraints: BoxConstraints(minHeight: 50.h),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: AppSizing.radiusMd(),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Text.rich(
              content!,
              style: GoogleFonts.spaceMono(
                fontSize: AppSizing.isMobile(context) ? 10.sp : 14.sp,
                height: 1.7.h,
                wordSpacing: 7.w,
              ),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: AppChip(
            onTap: () => setState(() {
              hasCopied = true;
            }),
            active: hasCopied,
            icon: AppIcons.clipboard,
            title: AppSizing.isMobile(context)
                ? null
                : hasCopied
                    ? "Copied"
                    : "Copy",
          ),
        ),
      ],
    );
  }

  Container loader(BuildContext context) {
    return Container(
      height: 500.h,
      color: Theme.of(context).cardColor,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
