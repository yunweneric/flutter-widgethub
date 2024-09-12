import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterui/shared/presentation/utils/icons.dart';
import 'package:flutterui/shared/presentation/utils/sizing.dart';

class InputsBlocItem extends StatefulWidget {
  const InputsBlocItem({super.key});

  @override
  State<InputsBlocItem> createState() => _InputssideBarCategoriestate();
}

class _InputssideBarCategoriestate extends State<InputsBlocItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizing.kWPercentage(context, 10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: SvgPicture.asset(AppIcons.search, width: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
