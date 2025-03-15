import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/presentation/effects/meshes/mesh_01/mesh_01_code.dart';
import 'package:flutterui/components/presentation/effects/meshes/mesh_01/mesh_01_setup.dart';
import 'package:flutterui/components/presentation/effects/meshes/mesh_01/mesh_01_widget.dart';

class MeshGradient01Data {
  static Widget widget = const MeshGradient01();
  static String code = meshGradient01;
  static String setup = mesh01Setup;
  static Component component = Component(
    createdAt: DateTime(2025, 03, 15),
    updatedAt: DateTime(2025, 03, 15),
    id: "mesh-gradient-01",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: 'A sample implementation of a mesh gradient with OMesh',
    title: "Mesh Gradient 01",
    setup: setup,
    category: ComponentCategoryEnum.ANIMATIONS,
    subcategory: SubComponentCategoryEnum.ONBOARDING_SCREENS,
    // assetLink: "https://github.com/yunweneric/flutter-open-ui/raw/9-implement-the-ui-for-doctor-onboarding/assets.zip",
    // gitHubLink: "https://github.com/yunweneric/flutter-open-ui/tree/9-implement-the-ui-for-doctor-onboarding",
    supportedPlatforms: [
      SupportedPlatform.ANDROID,
      SupportedPlatform.IOS,
    ],
    responsiveDevices: [
      AppDeviceType.MOBILE,
      AppDeviceType.TABLET,
      AppDeviceType.DESKTOP,
    ],
  );
}
