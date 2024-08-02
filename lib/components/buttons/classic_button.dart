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
      onPressed: () {},
      child: Text("Hello world"),
    );
  }
}
