import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class CodeHighlighter2 extends StatefulWidget {
  final String code;
  const CodeHighlighter2({super.key, required this.code});

  @override
  State<CodeHighlighter2> createState() => _CodeHighlighter2State();
}

class _CodeHighlighter2State extends State<CodeHighlighter2> {
  @override
  Widget build(BuildContext context) {
    return SyntaxView(
        code: widget.code, // Code text
        syntax: Syntax.DART, // Language
        syntaxTheme: SyntaxTheme.vscodeDark(), // Theme
        fontSize: 12.0, // Font size
        withZoom: false, // Enable/Disable zoom icon controls
        withLinesCount: false, // Enable/Disable line number
        expanded: false, // Enable/Disable container expansion
        selectable: true // Enable/Disable code text selection
        );
  }
}
