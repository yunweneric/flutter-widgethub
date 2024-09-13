import 'package:flutter/material.dart';
import 'package:fwh/app/shared/data/enums/component_category_enum.dart';
import 'package:fwh/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:fwh/app/shared/data/enums/supported_platform.dart';
import 'package:fwh/app/shared/data/models/component.dart';
import 'package:fwh/components/presentation/templates/leave_review/leave_a_review_code.dart';
import 'package:fwh/components/presentation/templates/leave_review/leave_a_review_setup.dart';
import 'package:fwh/components/presentation/templates/leave_review/leave_a_review_widget.dart';

class LeaveAReviewTemplateData {
  static Widget widget = const LeaveReviewHomeScreen();
  static String code = leaveAReviewCode;
  static String setup = leaveAReviewSetup;
  static Component component = Component(
    code: code,
    id: "leave-a-review",
    widget: widget,
    description: 'A new and fun way of getting feedback from your flutter app. Inspired by @musabalfawal',
    title: 'Animate Leave A Review',
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.SLIDERS_AND_CAROUSELS,
    gitHubLink: "https://github.com/yunweneric/flutter-widgethub/flutter-open-ui/tree/leave_a_review",
    supportedPlatforms: [
      SupportedPlatform.ANDROID,
      SupportedPlatform.IOS,
      SupportedPlatform.MACOS,
      SupportedPlatform.WEB,
    ],
  );
}
