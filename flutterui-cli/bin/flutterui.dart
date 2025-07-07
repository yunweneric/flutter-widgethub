#!/usr/bin/env dart

import 'dart:io';
import 'package:args/args.dart';
import 'package:flutterui_cli/commands/install_command.dart';
import 'package:flutterui_cli/commands/list_command.dart';
import 'package:flutterui_cli/commands/search_command.dart';
import 'package:flutterui_cli/commands/update_command.dart';
import 'package:flutterui_cli/commands/remove_command.dart';
import 'package:flutterui_cli/commands/validate_command.dart';

void main(List<String> arguments) async {
  final installCommand = InstallCommand();
  final listCommand = ListCommand();
  final searchCommand = SearchCommand();
  final updateCommand = UpdateCommand();
  final removeCommand = RemoveCommand();
  final validateCommand = ValidateCommand();

  final parser = ArgParser()
    ..addCommand('install', installCommand.argParser)
    ..addCommand('list', listCommand.argParser)
    ..addCommand('search', searchCommand.argParser)
    ..addCommand('update', updateCommand.argParser)
    ..addCommand('remove', removeCommand.argParser)
    ..addCommand('validate', validateCommand.argParser);

  try {
    final results = parser.parse(arguments);
    final command = results.command;

    switch (command?.name) {
      case 'install':
        await installCommand.run(command!);
        break;
      case 'list':
        await listCommand.run(command!);
        break;
      case 'search':
        await searchCommand.run(command!);
        break;
      case 'update':
        await updateCommand.run(command!);
        break;
      case 'remove':
        await removeCommand.run(command!);
        break;
      case 'validate':
        await validateCommand.run(command!);
        break;
      default:
        printUsage(parser);
    }
  } catch (e) {
    print('Error: $e');
    exit(1);
  }
}

void printUsage(ArgParser parser) {
  print('''
FlutterUI CLI - Component Management Tool

Usage: flutterui <command> [arguments]

Commands:
  install    Install a component into your project
  list       List available components
  search     Search for components
  update     Update installed components
  remove     Remove a component from your project
  validate   Validate component structure

Run 'flutterui help <command>' for more information about a command.
''');
}
