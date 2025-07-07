import 'package:flutter/material.dart';
import '../blocks.dart';

class BasicExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blocks Example')),
      body: Center(
        child: Blocks(),
      ),
    );
  }
}
