import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/components/presentation/effects/meshes/mesh_02/code.dart';
import 'package:flutterui/components/presentation/effects/meshes/mesh_02/setup.dart';
import 'package:flutterui/components/presentation/effects/meshes/mesh_02/widget.dart';

/// Component data definition for [MeshGradient02].
///
/// Provides the component metadata including:
/// - Title and description
/// - Category and subcategory
/// - Supported platforms
/// - Setup instructions
class MeshGradient02Data {
  static Widget widget = const MeshGradient02();
  static String code = meshGradient02;
  static String setup = mesh02Setup;
  static Component component = Component(
    createdAt: DateTime(2025, 03, 17),
    updatedAt: DateTime(2025, 03, 17),
    id: "mesh-gradient-02",
    codeComponents: [CodeComponent(code: code, widget: widget)],
    description: 'A sample implementation of a mesh gradient with OMesh',
    title: "Mesh Gradient 02",
    setup: setup,
    category: ComponentCategoryEnum.EFFECTS,
    subcategory: SubComponentCategoryEnum.LINEAR_GRADIENTS,
    supportedPlatforms: [
      SupportedPlatform.ANDROID,
      SupportedPlatform.IOS,
      SupportedPlatform.WEB,
      SupportedPlatform.LINUX,
      SupportedPlatform.MACOS,
    ],
    responsiveDevices: [
      AppDeviceType.MOBILE,
      AppDeviceType.TABLET,
      AppDeviceType.DESKTOP,
    ],
  );
}
