import 'package:flutter/material.dart';

class ComponentCTA extends StatefulWidget {
  const ComponentCTA({super.key});

  @override
  State<ComponentCTA> createState() => _ComponentCTAState();
}

class _ComponentCTAState extends State<ComponentCTA> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("CTA"),
    );
  }
}
