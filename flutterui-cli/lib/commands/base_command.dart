import 'package:flutterui_cli/utils/logger.dart';

abstract class BaseCommand {
  Future<void> run(List<String> arguments, Logger logger);

  String get name;
  String get description;

  void printUsage() {
    print('''
Usage: flutterui $name [options]

$description

Options:
  --help, -h    Show this help message
  --verbose, -v Enable verbose output
''');
  }
}
