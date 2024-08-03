import 'package:flutter/material.dart';

class ClassicButton extends StatefulWidget {
  const ClassicButton({super.key});

  @override
  State<ClassicButton> createState() => _ClassicButtonState();
}

class _ClassicButtonState extends State<ClassicButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
      onPressed: () {},
      child: Text("Hello world", style: Theme.of(context).textTheme.displaySmall),
    );
  }
}
