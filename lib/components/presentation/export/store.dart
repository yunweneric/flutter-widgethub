import 'package:flutterui/components/presentation/animations/skew_card/data.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/presentation/blocks/bottom_nav_bars/docking_bar/data.dart';
import 'package:flutterui/components/presentation/blocks/tabs/blurred_slide_tab/data.dart';
import 'package:flutterui/components/presentation/blocks/tabs/expandable_tab/data.dart';
import 'package:flutterui/components/presentation/blocks/tabs/slide_tab/data.dart';
import 'package:flutterui/components/presentation/templates/basuu/exports/data.dart';
import 'package:flutterui/components/presentation/templates/doctor_onboarding/doctor_onboarding_data.dart';
import 'package:flutterui/components/presentation/templates/fade_carousel/fade_carousel_data.dart';
import 'package:flutterui/components/presentation/templates/fruity_lips/fruity_lips_data.dart';
import 'package:flutterui/components/presentation/templates/leave_review/leave_a_review_data.dart';
import 'package:flutterui/components/presentation/templates/nike_zoomer/nike_zoomer_data.dart';

class AllComponents {
  static List<Component> widgets = [
    BasuuData.component,
    FruityLipsTemplateData.component,
    NikeZoomerTemplateData.component,
    FadeCarouselTemplateData.component,
    LeaveAReviewTemplateData.component,
    SkewCardData.component,
    DockingBarData.component,
    ExpandableTabData.component,
    SlideTabData.component,
    BlurredSlideTabData.component,
    DoctorOnboardingData.component,
  ];
}
