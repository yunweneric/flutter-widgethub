import 'package:flutter/material.dart';
import '../fruity_lips_widget.dart';

class BasicExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fruity Lips Example')),
      body: Center(
        child: FruityLips(),
      ),
    );
  }
}
