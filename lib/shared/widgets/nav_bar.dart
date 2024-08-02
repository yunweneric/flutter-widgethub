import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/shared/data/components.dart';
import 'package:flutterui/shared/utils/sizing.dart';
import 'package:flutterui/shared/widgets/app_container.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    List<String> links = ["Component", "Templates", 'Pricing'];
    List<String> socials = ["Twitter", "LinkedIn"];
    return AppContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("Logo"),
              AppSizing.kwSpacer(50.w),
              Container(
                child: Row(
                  children: [
                    ...links.map(
                      (item) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              ...socials.map(
                (item) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(item),
                ),
              ),
              SizedBox(
                width: 280.w,
                child: Transform.scale(
                  scale: 0.8,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                      hintText: "Search component...",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(AntDesign.search1, size: 20.w, color: Theme.of(context).highlightColor),
                      ),
                      // suffixIcon: Icon(AntDesign.search1, size: 20.w, color: Theme.of(context).highlightColor),
                    ),
                  ),
                ),
              ),
            ],
          )
          // navBar
        ],
      ),
    );
  }
}
