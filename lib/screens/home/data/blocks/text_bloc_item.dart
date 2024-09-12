import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterui/shared/presentation/utils/sizing.dart';

class TextBlocItem extends StatefulWidget {
  const TextBlocItem({super.key});

  @override
  State<TextBlocItem> createState() => _TextsideBarCategoriestate();
}

class _TextsideBarCategoriestate extends State<TextBlocItem> {
  Timer? timer;

  int count = 800;

  final duration = const Duration(milliseconds: 1200);

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    timer = Timer.periodic(duration, (tick) {
      setState(() {
        if (count > 1000) count = 0;
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: AppSizing.kHPercentage(context, 30),
                  child: Center(
                    child: TweenAnimationBuilder(
                        duration: duration,
                        key: ValueKey(count),
                        curve: Curves.elasticInOut,
                        tween: Tween<double>(begin: 1, end: 0),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, value * 80),
                            child: Opacity(
                              opacity: (1 - value.clamp(0, 1)),
                              child: Text(
                                "$count",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: AppSizing.kHPercentage(context, 30),
                  child: Center(
                    child: TweenAnimationBuilder(
                        duration: duration,
                        key: ValueKey(count),
                        curve: Curves.elasticInOut,
                        tween: Tween<double>(begin: 1, end: 0),
                        builder: (context, value, child) {
                          return Transform.translate(
                            offset: Offset(0, (1 - value) * -80),
                            child: Opacity(
                              opacity: (value.clamp(0, 1)),
                              child: Text(
                                "${count - 1}",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
