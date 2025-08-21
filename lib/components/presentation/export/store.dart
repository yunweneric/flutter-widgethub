import 'package:flutterui/components/presentation/animations/skew_card/data.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/presentation/blocks/bottom_nav_bars/docking_bar/data.dart';
import 'package:flutterui/components/presentation/blocks/buttons/apple_books_fab/data.dart';
import 'package:flutterui/components/presentation/blocks/tabs/blurred_slide_tab/data.dart';
import 'package:flutterui/components/presentation/blocks/tabs/expandable_tab/data.dart';
import 'package:flutterui/components/presentation/blocks/tabs/liquid_glass_tab/data.dart';
import 'package:flutterui/components/presentation/blocks/tabs/slide_tab/data.dart';
import 'package:flutterui/components/presentation/effects/meshes/mesh_01/mesh_01_data.dart';
import 'package:flutterui/components/presentation/effects/meshes/mesh_02/mesh_02_data.dart';
import 'package:flutterui/components/presentation/templates/airbnb/airbnb.dart';
import 'package:flutterui/components/presentation/templates/basuu/exports/data.dart';
import 'package:flutterui/components/presentation/templates/onboarding/doctor_onboarding/doctor_onboarding_data.dart';
import 'package:flutterui/components/presentation/templates/fade_carousel/fade_carousel_data.dart';
import 'package:flutterui/components/presentation/templates/fruity_lips/fruity_lips_data.dart';
import 'package:flutterui/components/presentation/templates/leave_review/leave_a_review_data.dart';
import 'package:flutterui/components/presentation/templates/nike_zoomer/nike_zoomer_data.dart';
import 'package:flutterui/components/presentation/templates/onboarding/mental_health/mental_health_data.dart';
import 'package:flutterui/components/presentation/templates/onboarding/online/online_data.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_01/auth_01_data.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_02/auth_02_data.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_03/auth_03_data.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_04/auth_04_data.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_05/auth_05_data.dart';
import 'package:flutterui/components/presentation/templates/spotify/spotify.dart';

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
    MeshGradient02Data.component,
    LiquidGlassTabData.component,
    Auth01Data.component,
    Auth02Data.component,
    Auth03Data.component,
    Auth04Data.component,
    Auth05Data.component,
    SpotifyData.component,
    AirbnbData.component,
  ];
}
