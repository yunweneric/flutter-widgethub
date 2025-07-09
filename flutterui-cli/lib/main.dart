#!/usr/bin/env dart

import 'package:args/args.dart';
import 'package:flutterui_cli/commands/commands.dart';
import 'package:flutterui_cli/utils/logger.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addCommand('list')
    ..addCommand('search')
    ..addCommand('download')
    ..addCommand('info')
    ..addCommand('categories')
    ..addCommand('init')
    ..addFlag('help', abbr: 'h', help: 'Show this help message')
    ..addFlag('verbose', abbr: 'v', help: 'Enable verbose output');

  try {
    final results = parser.parse(arguments);

    final logger = Logger(verbose: results['verbose']);

    if (results.command == null) {
      _printUsage(parser);
      return;
    }

    // Check if help is requested for a specific command
    final args = results.command!.arguments;
    if (args.contains('--help') || args.contains('-h')) {
      // Let the individual command handle its own help
    } else if (results['help']) {
      _printUsage(parser);
      return;
    }

    final command = results.command!.name;
    final commandArgs = results.command!.arguments;

    switch (command) {
      case 'list':
        await ListCommand().run(commandArgs, logger);
        break;
      case 'search':
        await SearchCommand().run(commandArgs, logger);
        break;
      case 'download':
        await DownloadCommand().run(commandArgs, logger);
        break;
      case 'info':
        await InfoCommand().run(commandArgs, logger);
        break;
      case 'categories':
        await CategoriesCommand().run(commandArgs, logger);
        break;
      case 'init':
        await InitCommand().run(commandArgs, logger);
        break;
      default:
        logger.error('Unknown command: $command');
        _printUsage(parser);
    }
  } catch (e) {
    print('Error: $e');
    _printUsage(parser);
  }
}

void _printUsage(ArgParser parser) {
  print('''
Flutter Widget Hub CLI - Download and manage Flutter UI components

Usage: flutterui <command> [arguments]

Commands:
  list        List all available components
  search      Search for components by name or description
  download    Download a component to your project
  info        Show detailed information about a component
  categories  List all component categories
  init        Initialize a new Flutter project with components

Examples:
  flutterui list
  flutterui search button
  flutterui download apple-books-fab
  flutterui info apple-books-fab
  flutterui categories
  flutterui init my_app

For more information about a command, run:
  flutterui <command> --help
''');
}
