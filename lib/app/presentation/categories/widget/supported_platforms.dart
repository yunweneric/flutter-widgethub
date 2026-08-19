import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';

/// Supported-platform pills for a component (shadcn badge style).
class SupportPlatformSection extends StatelessWidget {
  final Component component;
  const SupportPlatformSection({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangUtil.trans("supportOn"),
          style: context.text.h4,
        ),
        const SizedBox(height: AppSpace.md),
        Wrap(
          spacing: AppSpace.sm,
          runSpacing: AppSpace.sm,
          children: [
            ...component.supportedPlatforms.map((item) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpace.md, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: tokens.border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.string(
                      item.icon(),
                      colorFilter:
                          ColorFilter.mode(tokens.accent, BlendMode.srcIn),
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.describe(),
                      style: AppTypography.sans(
                        color: tokens.foreground,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
        const SizedBox(height: AppSpace.xxl),
      ],
    );
  }
}
