/// Screen for requesting new components.
///
/// Displays a placeholder screen for users to request new components
/// to be added to the library. Currently shows a "coming soon" message.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/app_layout.dart';

/// Screen for component requests.
class RequestComponentScreen extends StatelessWidget {
  /// Creates a request component screen.
  const RequestComponentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      children: [
        Text(
          LangUtil.trans("comingSoon"),
          style: context.text.h1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpace.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.xl),
          child: Text(
            LangUtil.trans("requestComingSoonDescription"),
            style: context.text.lead,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
