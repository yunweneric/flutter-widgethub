import 'package:flutter/material.dart';

class SkewCard extends StatelessWidget {
  final Widget child;
  final double skewAngle;

  const SkewCard({
    Key? key,
    required this.child,
    this.skewAngle = 0.1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.skewX(skewAngle),
      child: Card(
        child: child,
      ),
    );
  }
}
