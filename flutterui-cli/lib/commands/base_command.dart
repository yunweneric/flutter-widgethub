import 'package:args/args.dart';

abstract class BaseCommand {
  String get name;
  String get description;

  ArgParser get argParser;

  Future<void> run(ArgResults results);

  void printUsage() {
    print('Usage: flutterui $name ${argParser.usage}');
    print('\n$description');
  }
}
