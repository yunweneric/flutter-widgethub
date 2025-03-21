import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/chip.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class CodeHighlight extends StatefulWidget {
  final String code;
  final double? fontSize;
  final BorderRadiusGeometry? borderRadius;
  const CodeHighlight({
    required this.code,
    super.key,
    this.borderRadius,
    this.fontSize,
  });

  @override
  State<CodeHighlight> createState() => _CodeHighlightState();
}

class _CodeHighlightState extends State<CodeHighlight> {
  TextSpan? content;
  final duration = const Duration(seconds: 1);
  bool hasCopied = false;
  final themBloc = getIt.get<ThemeBloc>();

  Future setupHighLighter(Brightness brightness) async {
    await Highlighter.initialize(['dart', 'yaml']);
    var lightTheme = await HighlighterTheme.loadLightTheme();
    var darkTheme = await HighlighterTheme.loadDarkTheme();
    var highlighter = Highlighter(
      language: 'dart',
      theme: brightness == Brightness.dark ? darkTheme : lightTheme,
    );
    var highlightedCode = highlighter.highlight(widget.code);
    content = highlightedCode;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: setupHighLighter(Theme.of(context).brightness),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: loader(context));
          }
          return codeAndPreview();
        });
  }

  Widget codeAndPreview() {
    return Stack(
      children: [
        Container(
          width: AppSizing.kWPercentage(context, 76),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: widget.borderRadius ?? AppSizing.radiusSm(),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Text.rich(
                  content!,
                  softWrap: false,
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.sourceCodePro(
                    fontSize: widget.fontSize ?? (AppSizing.isMobile(context) ? 10.sp : 14.sp),
                    height: 1.7.h,
                    wordSpacing: 7.w,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: StatefulBuilder(builder: (context, setState) {
            return AppChip(
              onTap: () {
                setState(() => hasCopied = true);
                UtilHelper.copy(context, data: widget.code);
                Future.delayed(const Duration(seconds: 5), () {
                  setState(() => hasCopied = false);
                });
              },
              active: hasCopied,
              icon: AppIcons.clipboard,
              title: LangUtil.trans(
                AppSizing.isMobile(context)
                    ? null
                    : hasCopied
                        ? "copied"
                        : "copy",
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget loader(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
