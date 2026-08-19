import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';

/// Landing-page section header: small uppercase eyebrow, section title
/// and a muted lead paragraph (shadcn docs style).
class SectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String description;

  const SectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow.toUpperCase(),
          style: AppTypography.sans(
            color: tokens.accent,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: AppSpace.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(title, style: context.text.h2),
        ),
        const SizedBox(height: AppSpace.lg),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(description, style: context.text.lead),
        ),
      ],
    );
  }
}
