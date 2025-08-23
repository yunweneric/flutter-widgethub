import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../index.dart';

class AirbnbLayout extends StatefulWidget {
  final int? initialIndex;
  const AirbnbLayout({super.key, this.initialIndex});

  @override
  State<AirbnbLayout> createState() => _AirbnbLayoutState();
}

class _AirbnbLayoutState extends State<AirbnbLayout> {
  List<Widget> pages = [HomeScreen(), HomeScreen2(), HomeScreen(), HomeScreen(), HomeScreen()];
  int currentIndex = 0;
  @override
  void initState() {
    setState(() {
      currentIndex = widget.initialIndex ?? 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Theme(
      data: isDark ? AirbnbTheme.dark : AirbnbTheme.light,
      child: Scaffold(
        body: Container(
          child: pages[currentIndex],
        ),
        bottomNavigationBar: AirbnbBottomNavigationBar(),
      ),
    );
  }
}
