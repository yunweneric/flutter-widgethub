import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

/// shadcn-style code block.
///
/// Dark surface in both themes, JetBrains Mono, optional filename header
/// and a copy button pinned top-right.
class CodeHighlight extends StatefulWidget {
  final String code;
  final double? fontSize;
  final BorderRadiusGeometry? borderRadius;

  /// Optional filename/label shown in a header bar above the code.
  final String? title;

  /// Cap on the scrollable code area (defaults to 640).
  ///
  /// When the block is laid out inside a bounded height (a fixed-height
  /// pane), the code area shrinks to fit instead of overflowing.
  final double? maxHeight;

  const CodeHighlight({
    required this.code,
    super.key,
    this.borderRadius,
    this.fontSize,
    this.title,
    this.maxHeight,
  });

  @override
  State<CodeHighlight> createState() => _CodeHighlightState();
}

class _CodeHighlightState extends State<CodeHighlight> {
  TextSpan? content;
  bool hasCopied = false;

  Future<void> setupHighLighter() async {
    await Highlighter.initialize(['dart', 'yaml']);
    // Code blocks are always dark (shadcn docs style).
    final theme = await HighlighterTheme.loadDarkTheme();
    final highlighter = Highlighter(language: 'dart', theme: theme);
    content = highlighter.highlight(widget.code);
  }

  void _copy() {
    setState(() => hasCopied = true);
    UtilHelper.copy(context, data: widget.code);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => hasCopied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return LayoutBuilder(
      builder: (context, constraints) {
        // Inside a fixed-height pane the code area flexes; in a scrolling
        // page it keeps its natural height up to [maxHeight].
        final bool bounded = constraints.hasBoundedHeight;

        return FutureBuilder(
          future: setupHighLighter(),
          builder: (ctx, snapshot) {
            final Widget codeArea = Stack(
              children: [
                snapshot.connectionState == ConnectionState.waiting
                    ? const _CodeLoader()
                    : ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: widget.maxHeight ?? 640,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpace.xl),
                              child: Text.rich(
                                content!,
                                softWrap: false,
                                overflow: TextOverflow.clip,
                                style: AppTypography.mono(
                                  color: tokens.codeForeground,
                                  fontSize: widget.fontSize ??
                                      (AppSizing.isMobile(context) ? 12 : 13),
                                  height: 1.7,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                if (widget.title == null)
                  Positioned(
                    right: AppSpace.md,
                    top: AppSpace.md,
                    child: _CopyButton(hasCopied: hasCopied, onTap: _copy),
                  ),
              ],
            );

            return Container(
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: tokens.codeBackground,
                borderRadius: widget.borderRadius ?? AppRadii.lgAll,
                border: Border.all(color: ZincColors.zinc800),
              ),
              child: Column(
                mainAxisSize: bounded ? MainAxisSize.max : MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.title != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpace.lg, vertical: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: ZincColors.zinc800),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.title!,
                            style: AppTypography.mono(
                              color: ZincColors.zinc400,
                              fontSize: 12,
                            ),
                          ),
                          _CopyButton(hasCopied: hasCopied, onTap: _copy),
                        ],
                      ),
                    ),
                  if (bounded) Flexible(child: codeArea) else codeArea,
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _CodeLoader extends StatelessWidget {
  const _CodeLoader();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 120,
      child: Center(
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: ZincColors.zinc500,
          ),
        ),
      ),
    );
  }
}

class _CopyButton extends StatefulWidget {
  final bool hasCopied;
  final VoidCallback onTap;

  const _CopyButton({required this.hasCopied, required this.onTap});

  @override
  State<_CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<_CopyButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final Color fg = widget.hasCopied ? ZincColors.zinc50 : ZincColors.zinc400;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding:
              const EdgeInsets.symmetric(horizontal: AppSpace.sm, vertical: 6),
          decoration: BoxDecoration(
            color: _hovered
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: AppRadii.smAll,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.hasCopied
                  ? const AppIcon(
                      icon: AppIcons.check,
                      size: 14,
                      color: ZincColors.zinc50,
                    )
                  : AppIcon(icon: AppIcons.clipboard, color: fg, size: 14),
              if (!AppSizing.isMobile(context)) ...[
                const SizedBox(width: 6),
                Text(
                  LangUtil.trans(widget.hasCopied ? "copied" : "copy"),
                  style: AppTypography.sans(
                    color: fg,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 1.0,
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
