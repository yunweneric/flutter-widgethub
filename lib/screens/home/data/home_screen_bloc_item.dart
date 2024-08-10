import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';

class HomeScreenBlocItem extends StatefulWidget {
  const HomeScreenBlocItem({super.key});

  @override
  State<HomeScreenBlocItem> createState() => _HomeScreenBlocItemState();
}

class _HomeScreenBlocItemState extends State<HomeScreenBlocItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          List<String> icons = [
            "assets/icons/linkedin.svg",
            "assets/icons/tiktok.svg",
            "assets/icons/linkedin.svg",
            "assets/icons/youtube.svg",
            "assets/icons/spotify.svg",
          ];
          return SafeArea(
            child: Container(
              padding: AppSizing.kMainPadding(context),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(child: Icon(Icons.notifications, color: Colors.white)),
                      AppSizing.kwSpacer(10),
                      CircleAvatar(
                        child: ClipOval(child: Image.asset("assets/images/profile_0.jpg")),
                      ),
                    ],
                  ),
                  AppSizing.kh20Spacer(),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search chats...",
                    ),
                  ),
                  AppSizing.kh20Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Trending", style: Theme.of(context).textTheme.displayMedium),
                      Text("See all"),
                    ],
                  ),
                  AppSizing.kh20Spacer(),
                  ListTile(
                    leading: ClipOval(child: Image.asset("assets/images/profile_0.jpg")),
                    title: Text("Mary BB"),
                    subtitle: Text("Hi, how have yoou been?"),
                    trailing: Chip(
                      side: BorderSide.none,
                      label: Text("20", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  AppSizing.kh10Spacer(),
                  ListTile(
                    leading: ClipOval(child: Image.asset("assets/images/profile_1.jpg")),
                    title: Text("Mary BB"),
                    subtitle: Text("Hi, how have yoou been?"),
                    trailing: Chip(
                      side: BorderSide.none,
                      label: Text("20", style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
