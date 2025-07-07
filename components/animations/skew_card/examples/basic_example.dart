import 'package:flutter/material.dart';
import '../skew_card_widget.dart';

class BasicExample extends StatelessWidget {
  const BasicExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skew Card Example')),
      body: const Center(
        child: SkewCard(),
      ),
    );
  }
}
