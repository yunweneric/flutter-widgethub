import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterui/components/presentation/templates/nike_zoomer/utils/colors.dart';
import 'package:flutterui/components/presentation/templates/nike_zoomer/utils/sizing.dart';
import 'package:flutterui/shared/presentation/utils/util.dart';
import 'package:url_launcher/url_launcher.dart';

class Link {
  final int index;
  final String url;
  final String icon;
  final String title;

  Link(this.index, this.icon, this.url, this.title);
}

class Follow extends StatelessWidget {
  final int activeIndex;
  Follow({super.key, required this.activeIndex});

  List<Link> links = [
    Link(0, "github", "https://github.com/yunweneric/", "Github"),
    Link(1, "x", "https://twitter.com/yunweneric", "X"),
    Link(2, "linkedIn", "https://www.linkedin.com/in/yunweneric", "LinkedIn"),
  ];

  Color generateColor(int activeIndex, int index) {
    if (activeIndex == index) {
      switch (activeIndex) {
        case 0:
          return NZColors.blue;
        case 1:
          return NZColors.red;
        case 2:
          return NZColors.yellow;
        default:
          return Colors.transparent;
      }
    }
    return Colors.transparent;
  }

  static Future<void> navigate(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  linkItem(Link link, BuildContext context) {
    return TextButton.icon(
      onPressed: () => navigate(link.url),
      label: Text(link.title, style: const TextStyle(color: NZColors.black)),
      icon: SvgPicture.asset("assets/icons/${link.icon}.svg"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: NZSizing.width(context) / 4,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: NZColors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...links.map((link) {
                    return linkItem(link, context);
                  })
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: NZSizing.width(context) / 4,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: NZColors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Center(child: Text("Coded by Yunwen", style: TextStyle(fontSize: 12))),
          ),
        ],
      ),
    );
  }
}
