import 'package:flutterui/components/presentation/animations/skew_card/data.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/presentation/templates/fade_carousel/fade_carousel_data.dart';
import 'package:flutterui/components/presentation/templates/fruity_lips/fruity_lips_data.dart';
import 'package:flutterui/components/presentation/templates/leave_review/leave_a_review_data.dart';

class AllComponents {
  static List<Component> widgets = [
    FruityLipsTemplateData.component,
    FadeCarouselTemplateData.component,
    LeaveAReviewTemplateData.component,
    SkewCardData.component,
  ];
}
