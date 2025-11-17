import 'dart:async';

import 'package:flutter/material.dart';

/// A text widget that cycles through a list of items with animation.
///
/// API Reference:
/// - No public properties (uses internal state)
///
/// Usage:
/// ```dart
/// SplitText()
/// ```
class SplitText extends StatefulWidget {
  const SplitText({super.key});

  @override
  State<SplitText> createState() => _SplitTextState();
}

class _SplitTextState extends State<SplitText> {
  List<String> items = ["Hello", "World", "Flutter", "Dart", "Android", "iOS"];
  int activeIndex = 0;
  Timer? timer;
  final duration = const Duration(milliseconds: 1000);
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(duration, (t) {
      setState(() {
        activeIndex++;
        if (activeIndex == items.length) {
          activeIndex = 0;
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedList(
          itemBuilder: (c, i, a) {
            return Text(items[i]);
          },
        ),
      ),
    );
  }
}
