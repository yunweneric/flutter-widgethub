const nikeZoomerCode = '''import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class NikeZoomerTemplate extends StatefulWidget {
  const NikeZoomerTemplate({super.key});

  @override
  State<NikeZoomerTemplate> createState() => _NikeZoomerTemplateState();
}

class _NikeZoomerTemplateState extends State<NikeZoomerTemplate> with SingleTickerProviderStateMixin {
  int activeIndex = 5;
  final duration = const Duration(milliseconds: 1400);
  AnimationController? _controller;
  Animation<double>? _widthAnimation;
  Animation<double>? _textTranslationAnimation;
  Animation<double>? _widthReduceAnimation;
  Animation<double>? _shoeRotationAnimation;
  Animation<double>? _textRotationAnimation;
  bool hasReversed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    Timer(const Duration(seconds: 1), () {
      setAnimatedValues(5, context);
      _toggleAnimation(5);
    });
  }

  curve(ctrl) => CurvedAnimation(parent: ctrl, curve: Curves.bounceOut);

  setAnimatedValues(int index, BuildContext? context) {
    if (context != null) {
      _widthAnimation = Tween<double>(
        begin: NZSizing.isMobile(context) ? NZSizing.height(context) / 3 : NZSizing.width(context) / 3,
        end: NZSizing.isMobile(context) ? NZSizing.height(context) : NZSizing.width(context),
      ).animate(curve(_controller!));

      _textTranslationAnimation = Tween<double>(
        begin: NZSizing.isMobile(context) ? 0.8 : 1.9,
        end: NZSizing.isMobile(context) ? 1.9 : 2.5,
      ).animate(curve(_controller!));

      _widthReduceAnimation = Tween<double>(
        begin: NZSizing.isMobile(context) ? NZSizing.height(context) / 3 : NZSizing.width(context) / 3,
        end: 0,
      ).animate(curve(_controller!));

      _shoeRotationAnimation = Tween<double>(
        begin: -0.7,
        end: -0.0,
      ).animate(curve(_controller!));

      _textRotationAnimation = Tween<double>(
        begin: 0.0,
        end: pi * -0.5,
      ).animate(curve(_controller!));
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _toggleAnimation(int index) async {
    if (index == activeIndex) {
      if (hasReversed) {
        _controller?.forward();
        setState(() => hasReversed = !hasReversed);
      } else {
        _controller?.reverse();
        setState(() => hasReversed = !hasReversed);
      }
    } else {
      _controller?.forward();
    }
    setState(() => activeIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Wrap(
              children: [
                ...[0, 1, 2].map((index) {
                  return AnimatedBuilder(
                    animation: _controller!,
                    builder: (context, _) {
                      return nikeSlide(context, index);
                    },
                  );
                })
              ],
            ),
          ),
          if (NZSizing.isDesktop(context))
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Follow(activeIndex: activeIndex),
            ),
          if (NZSizing.isDesktop(context))
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: NavBar(),
            ),
        ],
      ),
    );
  }

  Widget nikeSlide(BuildContext context, int index) {
    return Builder(builder: (context) {
      final width = NZSizing.isMobile(context)
          ? NZSizing.width(context)
          : index == activeIndex
              ? _widthAnimation?.value ?? NZSizing.width(context) / 3
              : _widthReduceAnimation?.value ?? NZSizing.width(context) / 3;
      final height = NZSizing.isMobile(context)
          ? index == activeIndex
              ? _widthAnimation?.value ?? NZSizing.height(context) / 3
              : _widthReduceAnimation?.value ?? NZSizing.height(context) / 3
          : NZSizing.height(context);

      return AnimatedContainer(
        duration: duration,
        curve: Curves.bounceOut,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: index == 0
              ? NZColors.blue
              : index == 1
                  ? NZColors.red
                  : NZColors.yellow,
        ),
        width: width,
        height: height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..scale(index == activeIndex ? _textTranslationAnimation?.value ?? 1.8 : 1.0)
                    ..rotateZ(index == activeIndex ? _textRotationAnimation?.value ?? 0.0 : 0.0),
                  child: Text(
                    index == 0
                        ? "BLUE"
                        : index == 1
                            ? "RED"
                            : "YELLOW",
                    style: GoogleFonts.poppins(
                      fontSize: 90,
                      fontWeight: FontWeight.w900,
                      color: NZColors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: () => _toggleAnimation(index),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateZ(index == activeIndex ? _shoeRotationAnimation?.value ?? -0.7 : -0.7)
                    ..scale(1.0),
                  child: Image.asset("assets/images/nike_\$index.png"),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

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
      throw Exception('Could not launch \$url');
    }
  }

  linkItem(Link link, BuildContext context) {
    return TextButton.icon(
      onPressed: () => navigate(link.url),
      label: Text(link.title, style: const TextStyle(color: NZColors.black)),
      icon: SvgPicture.asset("assets/icons/\${link.icon}.svg"),
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
                  child: SvgPicture.asset("assets/icons/\$item.svg", width: 30, height: 30),
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}

class NZSizing {
  static double width(context) => MediaQuery.of(context).size.width;
  static double height(context) => MediaQuery.of(context).size.height;
  static bool isMobile(context) => width(context) <= 889;
  static bool isDesktop(context) => width(context) > 889;
}

class NZColors {
  static const blue = Color(0XFF4A64ED);
  static const red = Color(0xFFFF5A5A);
  static const yellow = Color(0xFFFFCE6D);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xff000000);
}

''';
