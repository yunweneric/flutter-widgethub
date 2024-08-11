import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';

class BottomNavBarsBlocItem extends StatefulWidget {
  const BottomNavBarsBlocItem({super.key});

  @override
  State<BottomNavBarsBlocItem> createState() => _BottomNavBarsBlocItemState();
}

class _BottomNavBarsBlocItemState extends State<BottomNavBarsBlocItem> {
  int currentIndex = 0;
  Timer? timer;

  final duration = const Duration(milliseconds: 1200);
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    timer = Timer.periodic(duration, (tick) {
      setState(() {
        if (currentIndex == 2) {
          currentIndex = 0;
          return;
        }
        currentIndex = currentIndex + 1;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Color generateColor() {
    switch (currentIndex) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.purple;
      case 3:
        return Colors.amber;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onTap: (index) => {
          setState(() {
            currentIndex = index;
          })
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.notification_add), label: "Notifications"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            alignment: Alignment.bottomCenter,
            duration: const Duration(milliseconds: 500),
            height: AppSizing.kHPercentage(context, 50),
            width: AppSizing.width(context),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: generateColor(),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          AppSizing.khSpacer(AppSizing.kHPercentage(context, 2)),
        ],
      ),
    );
  }
}
