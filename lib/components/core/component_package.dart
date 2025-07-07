import 'dart:convert';
import 'package:flutter/material.dart';

/// Represents a complete component package that can be exported and installed via CLI
class ComponentPackage {
  final String id;
  final String name;
  final String version;
  final String description;
  final String author;
  final String license;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> tags;
  final List<String> categories;
  final List<String> supportedPlatforms;
  final List<String> responsiveDevices;
  final List<ComponentFile> files;
  final List<ComponentDependency> dependencies;
  final ComponentMetadata metadata;
  final String? readme;
  final String? changelog;
  final String? documentation;
  final String? previewImage;
  final String? demoUrl;
  final String? repositoryUrl;
  final String? issueUrl;

  ComponentPackage({
    required this.id,
    required this.name,
    required this.version,
    required this.description,
    required this.author,
    required this.license,
    required this.createdAt,
    required this.updatedAt,
    required this.tags,
    required this.categories,
    required this.supportedPlatforms,
    required this.responsiveDevices,
    required this.files,
    required this.dependencies,
    required this.metadata,
    this.readme,
    this.changelog,
    this.documentation,
    this.previewImage,
    this.demoUrl,
    this.repositoryUrl,
    this.issueUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'version': version,
      'description': description,
      'author': author,
      'license': license,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'tags': tags,
      'categories': categories,
      'supportedPlatforms': supportedPlatforms,
      'responsiveDevices': responsiveDevices,
      'files': files.map((file) => file.toMap()).toList(),
      'dependencies': dependencies.map((dep) => dep.toMap()).toList(),
      'metadata': metadata.toMap(),
      'readme': readme,
      'changelog': changelog,
      'documentation': documentation,
      'previewImage': previewImage,
      'demoUrl': demoUrl,
      'repositoryUrl': repositoryUrl,
      'issueUrl': issueUrl,
    };
  }

  factory ComponentPackage.fromMap(Map<String, dynamic> map) {
    return ComponentPackage(
      id: map['id'] as String,
      name: map['name'] as String,
      version: map['version'] as String,
      description: map['description'] as String,
      author: map['author'] as String,
      license: map['license'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      tags: List<String>.from(map['tags'] as List),
      categories: List<String>.from(map['categories'] as List),
      supportedPlatforms: List<String>.from(map['supportedPlatforms'] as List),
      responsiveDevices: List<String>.from(map['responsiveDevices'] as List),
      files: List<ComponentFile>.from(
        (map['files'] as List).map((x) => ComponentFile.fromMap(x as Map<String, dynamic>)),
      ),
      dependencies: List<ComponentDependency>.from(
        (map['dependencies'] as List).map((x) => ComponentDependency.fromMap(x as Map<String, dynamic>)),
      ),
      metadata: ComponentMetadata.fromMap(map['metadata'] as Map<String, dynamic>),
      readme: map['readme'] as String?,
      changelog: map['changelog'] as String?,
      documentation: map['documentation'] as String?,
      previewImage: map['previewImage'] as String?,
      demoUrl: map['demoUrl'] as String?,
      repositoryUrl: map['repositoryUrl'] as String?,
      issueUrl: map['issueUrl'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ComponentPackage.fromJson(String source) =>
      ComponentPackage.fromMap(json.decode(source) as Map<String, dynamic>);

  ComponentPackage copyWith({
    String? id,
    String? name,
    String? version,
    String? description,
    String? author,
    String? license,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    List<String>? categories,
    List<String>? supportedPlatforms,
    List<String>? responsiveDevices,
    List<ComponentFile>? files,
    List<ComponentDependency>? dependencies,
    ComponentMetadata? metadata,
    String? readme,
    String? changelog,
    String? documentation,
    String? previewImage,
    String? demoUrl,
    String? repositoryUrl,
    String? issueUrl,
  }) {
    return ComponentPackage(
      id: id ?? this.id,
      name: name ?? this.name,
      version: version ?? this.version,
      description: description ?? this.description,
      author: author ?? this.author,
      license: license ?? this.license,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      categories: categories ?? this.categories,
      supportedPlatforms: supportedPlatforms ?? this.supportedPlatforms,
      responsiveDevices: responsiveDevices ?? this.responsiveDevices,
      files: files ?? this.files,
      dependencies: dependencies ?? this.dependencies,
      metadata: metadata ?? this.metadata,
      readme: readme ?? this.readme,
      changelog: changelog ?? this.changelog,
      documentation: documentation ?? this.documentation,
      previewImage: previewImage ?? this.previewImage,
      demoUrl: demoUrl ?? this.demoUrl,
      repositoryUrl: repositoryUrl ?? this.repositoryUrl,
      issueUrl: issueUrl ?? this.issueUrl,
    );
  }
}

/// Represents a file within a component package
class ComponentFile {
  final String path;
  final String content;
  final String type; // 'dart', 'yaml', 'md', 'json', etc.
  final bool isMain; // Whether this is the main component file
  final String? description;

  ComponentFile({
    required this.path,
    required this.content,
    required this.type,
    this.isMain = false,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'content': content,
      'type': type,
      'isMain': isMain,
      'description': description,
    };
  }

  factory ComponentFile.fromMap(Map<String, dynamic> map) {
    return ComponentFile(
      path: map['path'] as String,
      content: map['content'] as String,
      type: map['type'] as String,
      isMain: map['isMain'] as bool? ?? false,
      description: map['description'] as String?,
    );
  }
}

/// Represents a dependency required by the component
class ComponentDependency {
  final String name;
  final String version;
  final String type; // 'dependencies', 'dev_dependencies'
  final String? description;

  ComponentDependency({
    required this.name,
    required this.version,
    required this.type,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'version': version,
      'type': type,
      'description': description,
    };
  }

  factory ComponentDependency.fromMap(Map<String, dynamic> map) {
    return ComponentDependency(
      name: map['name'] as String,
      version: map['version'] as String,
      type: map['type'] as String,
      description: map['description'] as String?,
    );
  }
}

/// Additional metadata for the component
class ComponentMetadata {
  final String? setupInstructions;
  final String? usageExample;
  final List<String>? features;
  final Map<String, dynamic>? configuration;
  final String? minFlutterVersion;
  final String? maxFlutterVersion;
  final String? minDartVersion;
  final String? maxDartVersion;

  ComponentMetadata({
    this.setupInstructions,
    this.usageExample,
    this.features,
    this.configuration,
    this.minFlutterVersion,
    this.maxFlutterVersion,
    this.minDartVersion,
    this.maxDartVersion,
  });

  Map<String, dynamic> toMap() {
    return {
      'setupInstructions': setupInstructions,
      'usageExample': usageExample,
      'features': features,
      'configuration': configuration,
      'minFlutterVersion': minFlutterVersion,
      'maxFlutterVersion': maxFlutterVersion,
      'minDartVersion': minDartVersion,
      'maxDartVersion': maxDartVersion,
    };
  }

  factory ComponentMetadata.fromMap(Map<String, dynamic> map) {
    return ComponentMetadata(
      setupInstructions: map['setupInstructions'] as String?,
      usageExample: map['usageExample'] as String?,
      features: map['features'] != null ? List<String>.from(map['features'] as List) : null,
      configuration: map['configuration'] as Map<String, dynamic>?,
      minFlutterVersion: map['minFlutterVersion'] as String?,
      maxFlutterVersion: map['maxFlutterVersion'] as String?,
      minDartVersion: map['minDartVersion'] as String?,
      maxDartVersion: map['maxDartVersion'] as String?,
    );
  }
}
