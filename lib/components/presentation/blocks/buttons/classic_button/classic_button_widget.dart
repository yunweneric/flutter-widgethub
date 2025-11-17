import 'package:flutter/material.dart';

/// A classic elevated button component with customizable styling.
///
/// API Reference:
/// - No public properties (uses internal state)
///
/// Usage:
/// ```dart
/// ClassicButton()
/// ```
class ClassicButton extends StatefulWidget {
  const ClassicButton({super.key});

  @override
  State<ClassicButton> createState() => _ClassicButtonState();
}

class _ClassicButtonState extends State<ClassicButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
        onPressed: () {
          print("Clicked");
        },
        child: Text("Hello world",
            style: Theme.of(context).textTheme.displaySmall),
      ),
    );
  }
}
