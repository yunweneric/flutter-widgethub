import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/screens/home/widgets/assets_section.dart';
import 'package:flutterui/screens/home/widgets/integration_section.dart';
import 'package:flutterui/screens/home/widgets/hero_section.dart';
import 'package:flutterui/screens/home/widgets/home_footer.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/layout/nav_bar.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(listenToScroll);
    super.initState();
  }

  void listenToScroll() {}

  @override
  void dispose() {
    _controller.removeListener(listenToScroll);

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            const NavBar(isHomeScreenLayout: true),
            HeroSection(
              onBrowserAll: () {
                _controller.animateTo(
                  AppSizing.height(context) * 1.8,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                );
              },
            ),
            const IntegrationSection(),
            const AssetsSection(),
            const HomeFooter(),
          ],
        ),
      ),
    );
  }
}
