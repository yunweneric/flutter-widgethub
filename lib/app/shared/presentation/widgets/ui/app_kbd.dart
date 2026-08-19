/// shadcn-style keyboard-shortcut hint (kbd) primitive.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';

/// Small bordered key-cap hint, e.g. `⌘K`.
class AppKbd extends StatelessWidget {
  final String label;

  const AppKbd({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: tokens.active,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: tokens.border),
      ),
      child: Text(
        label,
        style: AppTypography.mono(
          color: tokens.mutedForeground,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
