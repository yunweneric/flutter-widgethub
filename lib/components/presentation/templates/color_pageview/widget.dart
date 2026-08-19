import 'package:flutter/material.dart';

class ColorPageView extends StatefulWidget {
  const ColorPageView({super.key});

  @override
  State<ColorPageView> createState() => _ColorPageViewState();
}

class _ColorPageViewState extends State<ColorPageView> {
  List<Color> colors = [];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
          gradient: RadialGradient(colors: [
        colors[currentIndex],
        colors[currentIndex].withValues(alpha: 26)
      ])),
      duration: Duration(microseconds: 300),
      child: PageView.builder(
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }
}
