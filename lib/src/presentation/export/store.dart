library store;

import 'package:flutterui/src/presentation/animations/skew_card/data.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/src/presentation/blocks/blocks.dart';
import 'package:flutterui/src/presentation/effects/meshes/mesh_01/mesh_01_data.dart';
import 'package:flutterui/src/presentation/templates/onboarding/doctor_onboarding/doctor_onboarding_data.dart';
import 'package:flutterui/src/presentation/templates/fade_carousel/fade_carousel_data.dart';
import 'package:flutterui/src/presentation/templates/fruity_lips/fruity_lips_data.dart';
import 'package:flutterui/src/presentation/templates/leave_review/leave_a_review_data.dart';
import 'package:flutterui/src/presentation/templates/nike_zoomer/nike_zoomer_data.dart';
import 'package:flutterui/src/presentation/templates/onboarding/mental_health/mental_health_data.dart';
import 'package:flutterui/src/presentation/templates/onboarding/online/online_data.dart';
import 'package:flutterui/src/presentation/templates/templates.dart';

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
    AppleBooksFABData.component,
    OnlineOnboardingData.component,
    MentalHealthOnboardingData.component,
    DoctorOnboardingData.component,
    MeshGradient01Data.component,
  ];
}
