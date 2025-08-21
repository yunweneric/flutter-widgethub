import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import 'shared.dart';

class AirbnbLayout extends StatefulWidget {
  const AirbnbLayout({super.key});

  @override
  State<AirbnbLayout> createState() => _AirbnbLayoutState();
}

class _AirbnbLayoutState extends State<AirbnbLayout> {
  List<Widget> pages = [HomeScreen(), HomeScreen(), HomeScreen(), HomeScreen(), HomeScreen()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Theme(
      data: AirbnbTheme.light,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: IndexedStack(
          index: currentIndex,
          children: pages,
        ),
      ),
    );
  }
}
