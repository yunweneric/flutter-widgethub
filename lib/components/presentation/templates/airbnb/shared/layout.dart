import 'package:flutter/material.dart';

import '../index.dart';

class AirbnbLayout extends StatefulWidget {
  final int? initialIndex;
  final Widget widget;
  const AirbnbLayout({super.key, this.initialIndex, required this.widget});

  @override
  State<AirbnbLayout> createState() => _AirbnbLayoutState();
}

class _AirbnbLayoutState extends State<AirbnbLayout> {
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
          child: widget.widget,
        ),
        bottomNavigationBar: AirbnbBottomNavigationBar(currentIndex: currentIndex),
      ),
    );
  }
}
