final sampleCode = '''import 'package:flutter/material.dart';
import 'package:flutterui/shared/widgets/app_container.dart';
class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    List<String> links = ["Get started", "Templates"];
    return AppContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Logo"),
          Container(
            child: Row(
              children: [...links.map((item) => Text(item))],
            ),
          )
        ],
      ),
    );
  }
}
''';
