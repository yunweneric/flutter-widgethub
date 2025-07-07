import 'dart:io';
import 'package:path/path.dart' as path;

class ProjectService {
  Future<bool> isFlutterProject() async {
    final pubspecFile = File('pubspec.yaml');
    if (!await pubspecFile.exists()) return false;

    final content = await pubspecFile.readAsString();
    return content.contains('flutter:');
  }

  Future<String> getProjectName() async {
    final pubspecFile = File('pubspec.yaml');
    if (!await pubspecFile.exists()) return '';

    final content = await pubspecFile.readAsString();
    final lines = content.split('\n');

    for (final line in lines) {
      if (line.trim().startsWith('name:')) {
        return line.split(':')[1].trim();
      }
    }

    return '';
  }

  Future<void> createComponentDirectory(String path) async {
    await Directory(path).create(recursive: true);
  }

  Future<bool> hasComponent(String componentName, String componentsPath) async {
    final componentDir = Directory(path.join(componentsPath, componentName));
    return await componentDir.exists();
  }

  Future<void> removeComponent(String componentName, String componentsPath) async {
    final componentDir = Directory(path.join(componentsPath, componentName));
    if (await componentDir.exists()) {
      await componentDir.delete(recursive: true);
    }
  }
}
