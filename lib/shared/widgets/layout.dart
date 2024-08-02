import 'package:flutter/material.dart';
import 'package:flutterui/shared/widgets/nav_bar.dart';

class AppLayout extends StatefulWidget {
  final List<Widget> children;
  const AppLayout({super.key, required this.children});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NavBar(),
          mainContent(),
        ],
      ),
    );
  }

  Widget mainContent() {
    return Column(
      children: [...widget.children],
    );
  }
}
