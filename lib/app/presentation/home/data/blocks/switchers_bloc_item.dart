import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fwh/app/shared/presentation/utils/sizing.dart';

class SwitchersBlocItem extends StatefulWidget {
  const SwitchersBlocItem({super.key});

  @override
  State<SwitchersBlocItem> createState() => _TabssideBarCategoriestate();
}

class _TabssideBarCategoriestate extends State<SwitchersBlocItem> {
  Timer? timer;

  bool isOn = false;
  final duration = const Duration(milliseconds: 2000);
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    timer = Timer.periodic(duration, (tick) {
      setState(() {
        isOn = !isOn;
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: AppSizing.width(context),
              height: AppSizing.kHPercentage(context, 40),
              child: Switch.adaptive(
                value: isOn,
                onChanged: (val) {
                  setState(() {
                    isOn = !isOn;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
