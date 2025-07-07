class Component {
  final String name;
  final String displayName;
  final String description;
  final String category;
  final List<String> tags;
  final String version;
  final String author;
  final String license;
  final List<String> dependencies;
  final List<ComponentProperty> properties;
  final List<String> files;
  final List<String> examples;

  Component({
    required this.name,
    required this.displayName,
    required this.description,
    required this.category,
    required this.tags,
    required this.version,
    required this.author,
    required this.license,
    required this.dependencies,
    required this.properties,
    required this.files,
    required this.examples,
  });

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component(
      name: json['name'],
      displayName: json['displayName'],
      description: json['description'],
      category: json['category'],
      tags: List<String>.from(json['tags']),
      version: json['version'],
      author: json['author'],
      license: json['license'],
      dependencies: List<String>.from(json['dependencies']),
      properties: (json['properties'] as List).map((prop) => ComponentProperty.fromJson(prop)).toList(),
      files: List<String>.from(json['files']),
      examples: List<String>.from(json['examples']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'displayName': displayName,
      'description': description,
      'category': category,
      'tags': tags,
      'version': version,
      'author': author,
      'license': license,
      'dependencies': dependencies,
      'properties': properties.map((prop) => prop.toJson()).toList(),
      'files': files,
      'examples': examples,
    };
  }
}

class ComponentProperty {
  final String name;
  final String type;
  final bool required;
  final String? defaultValue;
  final String description;

  ComponentProperty({
    required this.name,
    required this.type,
    required this.required,
    this.defaultValue,
    required this.description,
  });

  factory ComponentProperty.fromJson(Map<String, dynamic> json) {
    return ComponentProperty(
      name: json['name'],
      type: json['type'],
      required: json['required'],
      defaultValue: json['defaultValue'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'required': required,
      'defaultValue': defaultValue,
      'description': description,
    };
  }
}
