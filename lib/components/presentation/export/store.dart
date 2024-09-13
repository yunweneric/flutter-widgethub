import 'package:fwh/components/presentation/animations/skew_card/data.dart';
import 'package:fwh/app/shared/data/models/component.dart';
import 'package:fwh/components/presentation/templates/fade_carousel/fade_carousel_data.dart';
import 'package:fwh/components/presentation/templates/fruity_lips/fruity_lips_data.dart';
import 'package:fwh/components/presentation/templates/leave_review/leave_a_review_data.dart';
import 'package:fwh/components/presentation/templates/nike_zoomer/nike_zoomer_data.dart';

class AllComponents {
  static List<Component> widgets = [
    FruityLipsTemplateData.component,
    NikeZoomerTemplateData.component,
    FadeCarouselTemplateData.component,
    LeaveAReviewTemplateData.component,
    SkewCardData.component,
  ];
}
