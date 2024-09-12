import 'dart:async';

import 'package:flutter/material.dart';
import "package:flutterui/shared/presentation/utils/sizing.dart";

class ButtonsBlocItem extends StatefulWidget {
  const ButtonsBlocItem({super.key});

  @override
  State<ButtonsBlocItem> createState() => _ButtonssideBarCategoriestate();
}

class _ButtonssideBarCategoriestate extends State<ButtonsBlocItem> {
  Timer? timer;
  int count = 50;
  final duration = const Duration(milliseconds: 200);
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    timer = Timer.periodic(duration, (tick) {
      setState(() {
        if (count == 100) {
          count = 0;
          return;
        }
        count = count + 1;
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizing.kWPercentage(context, 20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned(
                    child: Container(
                      width: AppSizing.kWPercentage(context, count * 0.5),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Container(
                    width: AppSizing.width(context),
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        "$count%",
                        style: TextStyle(color: count > 60 ? Colors.white : Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
