import 'dart:async';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'annotations.dart';

class CodeStringGenerator extends GeneratorForAnnotation<GenerateCodeString> {
  @override
  FutureOr<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final inputId = buildStep.inputId;
    final source = await buildStep.readAsString(inputId);
    final name = annotation.peek('name')?.stringValue ?? '${element.name}Code';
    return '''
// GENERATED CODE - DO NOT MODIFY BY HAND
const String $name = r"""$source""";
''';
  }
}
