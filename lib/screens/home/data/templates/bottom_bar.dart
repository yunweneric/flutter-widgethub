import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterui/shared/presentation/utils/sizing.dart';

class BottomBarBlocItem extends StatefulWidget {
  const BottomBarBlocItem({super.key});

  @override
  State<BottomBarBlocItem> createState() => _BottomBarsideBarCategoriestate();
}

class _BottomBarsideBarCategoriestate extends State<BottomBarBlocItem> {
  Timer? timer;
  int activeIndex = 0;

  final duration = const Duration(milliseconds: 1200);
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    timer = Timer.periodic(duration, (tick) {
      setState(() {
        if (activeIndex == 4) {
          activeIndex = 0;
          return;
        }
        activeIndex = activeIndex + 1;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Color generateColor() {
    switch (activeIndex) {
      case 0:
        return Colors.teal;
      case 1:
        return Colors.blue;
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: AppSizing.kHPercentage(context, 60),
            width: AppSizing.width(context),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: generateColor(),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          AppSizing.khSpacer(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(5, (item) => item).map((item) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      activeIndex = item;
                    });
                  },
                  child: AnimatedContainer(
                    height: 10,
                    decoration: BoxDecoration(
                      color: activeIndex == item ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: activeIndex == item ? AppSizing.kWPercentage(context, 8) : AppSizing.kWPercentage(context, 2.5),
                    duration: const Duration(milliseconds: 200),
                  ),
                );
              })
            ],
          ),
          AppSizing.khSpacer(40),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Get started"),
          ),
          AppSizing.khSpacer(40),
        ],
      ),
    );
  }
}
