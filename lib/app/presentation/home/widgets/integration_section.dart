import 'package:flutter/material.dart';
import 'package:flutterui/app/presentation/home/widgets/device_interactive.dart';
import 'package:flutterui/app/presentation/home/widgets/section_header.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';

/// "Integration" landing section: eyebrow, title, lead and the interactive
/// device demo.
class IntegrationSection extends StatelessWidget {
  const IntegrationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = AppSizing.isMobile(context);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1400),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppSpace.lg : AppSpace.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpace.huge),
              SectionHeader(
                eyebrow: LangUtil.trans("integration"),
                title: LangUtil.trans("integrationTitle"),
                description: LangUtil.trans("integrationDescription"),
              ),
              const SizedBox(height: AppSpace.xxl),
              const DeviceInteractive(),
              const SizedBox(height: AppSpace.huge),
            ],
          ),
        ),
      ),
    );
  }
}
