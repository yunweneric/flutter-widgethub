import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';

class AppCloneBlocItem extends StatefulWidget {
  const AppCloneBlocItem({super.key});

  @override
  State<AppCloneBlocItem> createState() => _AppCloneBlocItemState();
}

class _AppCloneBlocItemState extends State<AppCloneBlocItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        List<String> icons = [
          "assets/icons/google.svg",
          "assets/icons/tiktok.svg",
          "assets/icons/linkedin.svg",
          "assets/icons/youtube.svg",
          "assets/icons/spotify.svg",
        ];
        return Container(
          margin: EdgeInsets.only(top: AppSizing.kHPercentage(context, 22)),
          alignment: Alignment.topCenter,
          child: Wrap(
            spacing: 30,
            children: [
              ...icons.map((item) {
                return ClipOval(child: SvgPicture.asset(item, width: 30));
              }),
            ],
          ),
        );
      }),
    );
  }
}
