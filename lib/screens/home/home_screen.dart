import 'package:flutter/material.dart';
import 'package:flutterui/shared/data/components.dart';
import 'package:flutterui/shared/widgets/code_highlighter.dart';
import 'package:flutterui/shared/widgets/code_highlighter2.dart';
import 'package:flutterui/shared/widgets/layout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      children: [
        Text("Loader"),
        Card(child: CodeHighlighter(code: sampleCode)),
      ],
    );
  }
}
