/// Component registry and export store.
///
/// Central registry that contains all components available in the Flutter WidgetHub.
/// This file imports and registers all components from different categories:
/// - Animations
/// - Blocks (buttons, tabs, switches, navigation bars)
/// - Effects (mesh gradients)
/// - Templates (auth screens, onboarding, app clones)
library;

import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/presentation/animations/animations.dart';
import 'package:flutterui/components/presentation/blocks/blocks.dart';
import 'package:flutterui/components/presentation/effects/effects.dart';
import 'package:flutterui/components/presentation/templates/templates.dart';

/// Registry containing all available components.
///
/// This class maintains a static list of all components registered in the system.
/// Components are organized by category and can be accessed through this registry.
class AllComponents {
  /// List of all registered components in the system.
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
    DiscloseSwitcherData.component,
  ];
}
