import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

class DrawersBlocItem extends StatefulWidget {
  const DrawersBlocItem({super.key});

  @override
  State<DrawersBlocItem> createState() => _DrawerssideBarCategoriestate();
}

class _DrawerssideBarCategoriestate extends State<DrawersBlocItem> {
  bool isExpanded = false;

  final duration = const Duration(milliseconds: 2400);
  final curve = Curves.elasticInOut;
  Timer? timer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    timer = Timer.periodic(duration, (tick) {
      setState(() {
        isExpanded = !isExpanded;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () => setState(() {
                  isExpanded = !isExpanded;
                }),
                child: const AppIcon(
                  icon: AppIcons.menu,
                  size: 40,
                ),
              ),
            ),
            AnimatedPositioned(
              curve: curve,
              duration: duration,
              left: isExpanded ? 25 : -200,
              top: 80,
              child: AnimatedContainer(
                duration: duration,
                width: AppSizing.width(context),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...['Home', "About", "Cart", "Contact", "Settings"].map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          item,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 22),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              left: isExpanded ? 200 : 0,
              curve: curve,
              top: 0,
              duration: duration,
              child: AnimatedContainer(
                curve: curve,
                transform: Matrix4.identity()..rotateZ(isExpanded ? -0.1 : 0),
                duration: duration,
                width: AppSizing.width(context),
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: isExpanded ? Theme.of(context).primaryColor.withOpacity(0.4) : Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextField(
                      decoration: InputDecoration(hintText: "Search chats"),
                    ),
                    AppSizing.kh20Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Latest chats", style: Theme.of(context).textTheme.displayMedium),
                        const Text("See all"),
                      ],
                    ),
                    AppSizing.kh20Spacer(),
                    ListTile(
                      leading: ClipOval(
                        child: Image.asset("assets/images/profile_0.jpg"),
                      ),
                      title: const Text("Lina Assoh"),
                      subtitle: const Text("Hi Flutter dev, how have you been?"),
                    ),
                    ListTile(
                      leading: ClipOval(
                        child: Image.asset("assets/images/profile_1.jpg"),
                      ),
                      title: const Text("Lina Assoh"),
                      subtitle: const Text("Hi Flutter dev, how have you been?"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
