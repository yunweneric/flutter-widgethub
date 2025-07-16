import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'code_string_generator.dart';

Builder codeStringBuilder(BuilderOptions options) => SharedPartBuilder([CodeStringGenerator()], 'code_string');
