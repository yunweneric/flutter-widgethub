import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class CodeHighlighter extends StatefulWidget {
  final String code;
  const CodeHighlighter({super.key, required this.code});

  @override
  State<CodeHighlighter> createState() => _CodeHighlighterState();
}

class _CodeHighlighterState extends State<CodeHighlighter> {
  Future<Text>? futureWidget;
  TextSpan? content;
  @override
  initState() {
    // highlightCode();
    setup();
    super.initState();
  }

  setup() async {
    await Highlighter.initialize(['dart', 'yaml', 'sql']);
    var theme = await HighlighterTheme.loadDarkTheme();
    var highlighter = Highlighter(
      language: 'dart',
      theme: theme,
    );
    var highlightedCode = highlighter.highlight(widget.code);
    setState(() {
      content = highlightedCode;
    });
  }

  highlightCode() async {
    await Highlighter.initialize(['dart', 'yaml', 'sql']);
    var theme = await HighlighterTheme.loadDarkTheme();
    var highlighter = Highlighter(
      language: 'dart',
      theme: theme,
    );
    var highlightedCode = highlighter.highlight(widget.code);
    setState(() {
      futureWidget = Future.value(Text.rich(
        highlightedCode,
        style: GoogleFonts.montserrat(fontSize: 12),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return content == null
        ? SizedBox.shrink()
        : Text.rich(
            content!,
            style: GoogleFonts.dmSans(fontSize: 14),
          );
    return FutureBuilder(
      future: futureWidget,
      key: ValueKey(Random()),
      builder: ((context, snapshot) {
        print(["hasData", snapshot.hasData]);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {}
        if (snapshot.hasData) {
          return snapshot.data!;
        }
        return SizedBox.shrink();
      }),
    );
  }
}
