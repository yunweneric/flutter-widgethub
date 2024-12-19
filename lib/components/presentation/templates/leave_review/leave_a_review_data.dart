import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/components/presentation/templates/leave_review/leave_a_review_code.dart';
import 'package:flutterui/components/presentation/templates/leave_review/leave_a_review_setup.dart';
import 'package:flutterui/components/presentation/templates/leave_review/leave_a_review_widget.dart';

class LeaveAReviewTemplateData {
  static Widget widget = const LeaveReviewHomeScreen();
  static String code = leaveAReviewCode;
  static String setup = leaveAReviewSetup;
  static Component component = Component(
    createdAt: DateTime(2024, 7, 2),
    updatedAt: DateTime(2024, 7, 2),
    codeComponents: [CodeComponent(code: code, widget: widget)],
    id: "leave-a-review",
    description: LangUtil.trans('leaveAReviewDescription'),
    title: LangUtil.trans('leaveAReviewTitle'),
    setup: setup,
    category: ComponentCategoryEnum.BLOCKS,
    subcategory: SubComponentCategoryEnum.SLIDERS_AND_CAROUSELS,
    gitHubLink: "https://github.com/yunweneric/flutter-open-ui/tree/leave_a_review",
    supportedPlatforms: [
      SupportedPlatform.ANDROID,
      SupportedPlatform.IOS,
      SupportedPlatform.MACOS,
      SupportedPlatform.WEB,
    ],
  );
}
