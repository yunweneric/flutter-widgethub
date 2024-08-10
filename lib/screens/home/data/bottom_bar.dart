import 'package:flutter/material.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';

class BottomBarBlocItem extends StatefulWidget {
  const BottomBarBlocItem({super.key});

  @override
  State<BottomBarBlocItem> createState() => _BottomBarBlocItemState();
}

class _BottomBarBlocItemState extends State<BottomBarBlocItem> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: AppSizing.kHPercentage(context, 60),
            width: AppSizing.width(context),
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
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
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: activeIndex == item ? AppSizing.kWPercentage(context, 5) : AppSizing.kWPercentage(context, 2),
                    duration: Duration(milliseconds: 200),
                  ),
                );
              })
            ],
          ),
          AppSizing.khSpacer(40),
          ElevatedButton(
            onPressed: () {},
            child: Text("Get started"),
          ),
          AppSizing.khSpacer(40),
        ],
      ),
    );
  }
}
