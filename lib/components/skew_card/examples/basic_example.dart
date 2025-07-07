import 'package:flutter/material.dart';
import '../skew_card.dart';

class BasicExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Skew Card Example')),
      body: Center(
        child: SkewCard(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('This is a skewed card!'),
          ),
          skewAngle: 0.2,
        ),
      ),
    );
  }
}
