import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterui/components/presentation/templates/nike_zoomer/utils/colors.dart';
import 'package:flutterui/components/presentation/templates/nike_zoomer/utils/sizing.dart';

class NavBar extends StatelessWidget {
  NavBar({super.key});

  List<String> navItems = ["LifeStyle", "New Release", "Sales"];
  List<String> navIcons = ["bag", "user", "heart"];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: NZSizing.width(context) / 3.5,
          child: Image.asset("assets/images/nike.png", height: 120),
        ),
        SizedBox(
          width: NZSizing.width(context) / 3.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...navItems.map((item) {
                return TextButton(
                  onPressed: () {},
                  child: Text(item, style: const TextStyle(color: NZColors.white, fontSize: 16)),
                );
              })
            ],
          ),
        ),
        SizedBox(
          width: NZSizing.width(context) / 3.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ...navIcons.map((item) {
                return TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  ),
                  child: SvgPicture.asset("assets/icons/$item.svg", width: 30, height: 30),
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}
