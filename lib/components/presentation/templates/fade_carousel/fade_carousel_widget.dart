import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FadeCarouselTemplate extends StatefulWidget {
  const FadeCarouselTemplate({super.key});

  @override
  State<FadeCarouselTemplate> createState() => _FadeCarouselTemplateState();
}

class _FadeCarouselTemplateState extends State<FadeCarouselTemplate> {
  int activeIndex = 2;
  final duration = const Duration(milliseconds: 700);
  final controller = PageController(viewportFraction: 0.8, initialPage: 2);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: 6,
            onPageChanged: (page) {
              controller.animateToPage(
                page,
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutExpo,
              );
              setState(() {
                activeIndex = page;
              });
            },
            itemBuilder: (c, i) {
              return AppCard(index: i, activeIndex: activeIndex);
            },
          ),
          Positioned(
            top: FCSizing.height(context) * 0.7,
            left: 0,
            right: 0,
            child: Transform.rotate(
              angle: pi * -0.03,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [0, 1, 2, 3, 4, 5].map((item) {
                  return AnimatedContainer(
                    height: 12,
                    width: 12,
                    duration: duration,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: activeIndex == item ? Colors.grey : Colors.grey.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final int index;
  final int activeIndex;
  const AppCard({super.key, required this.index, required this.activeIndex});
  final duration = const Duration(milliseconds: 700);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        duration: duration,
        opacity: activeIndex == index ? 1 : 0,
        child: AnimatedContainer(
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateZ(activeIndex == index
                ? -0.1
                : activeIndex > index
                    ? -0.2
                    : 0.2)
            ..scale(activeIndex == index ? 1.0 : 0.5),
          duration: const Duration(milliseconds: 400),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              children: [
                Image.network(
                  height: FCSizing.height(context) * 0.3,
                  width: FCSizing.height(context) * 0.3,
                  // 'assets/images/city_${index}.jpg',
                  'https://raw.githubusercontent.com/yunweneric/flutter-open-ui/fade_caarousel/assets/images/city_$index.jpg',
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  right: 20,
                  top: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(Icons.favorite),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FCSizing {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static bool isMobile(BuildContext context) => width(context) < 480;
  static bool isTablet(BuildContext context) => width(context) > 480 && width(context) < 895;
  static bool isDesktop(BuildContext context) => width(context) > 895;
  static SizedBox k20(BuildContext context) => SizedBox(height: height(context) * 0.02);
  static SizedBox k10(BuildContext context) => SizedBox(height: height(context) * 0.01);
  static SizedBox kwSpacer(BuildContext context, double factor) => SizedBox(width: width(context) * factor);
}
