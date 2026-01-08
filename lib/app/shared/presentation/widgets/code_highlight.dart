import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
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
            return const _CodeLoader();
          }
          return _CodeContent(
            content: content!,
            code: widget.code,
            fontSize: widget.fontSize,
            borderRadius: widget.borderRadius,
            hasCopied: hasCopied,
            onCopyTap: () {
              setState(() => hasCopied = true);
              UtilHelper.copy(context, data: widget.code);
              Future.delayed(const Duration(seconds: 3), () {
                if (mounted) {
                  setState(() => hasCopied = false);
                }
              });
            },
          );
        });
  }
}

class _CodeLoader extends StatelessWidget {
  const _CodeLoader();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _CodeContent extends StatelessWidget {
  final TextSpan content;
  final String code;
  final double? fontSize;
  final BorderRadiusGeometry? borderRadius;
  final bool hasCopied;
  final VoidCallback onCopyTap;

  const _CodeContent({
    required this.content,
    required this.code,
    this.fontSize,
    this.borderRadius,
    required this.hasCopied,
    required this.onCopyTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        Container(
          width: AppSizing.kWPercentage(context, 100),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withValues(alpha: isDark ? 0.6 : 0.1),
            borderRadius: borderRadius ?? BorderRadius.circular(12.r),
            border: Border.all(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Text.rich(
                  content,
                  softWrap: false,
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.sourceCodePro(
                    fontSize: fontSize ?? (AppSizing.isMobile(context) ? 11.sp : 14.sp),
                    height: 1.8,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 16,
          top: 16,
          child: _CopyButton(
            hasCopied: hasCopied,
            onTap: onCopyTap,
          ),
        ),
      ],
    );
  }
}

class _CopyButton extends StatelessWidget {
  final bool hasCopied;
  final VoidCallback onTap;

  const _CopyButton({
    required this.hasCopied,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color:
                isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: Theme.of(context).dividerColor.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(
                icon: AppIcons.clipboard,
                color: hasCopied
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).highlightColor,
                size: 16,
              ),
              if (!AppSizing.isMobile(context)) ...[
                KwSpacer(width: 6.w),
                Text(
                  LangUtil.trans(hasCopied ? "copied" : "copy"),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        color: hasCopied
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).highlightColor,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
