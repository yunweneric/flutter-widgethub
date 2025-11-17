import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingData {
  final String title;
  final String description;

  OnBoardingData({required this.title, required this.description});
}

/// Online onboarding screen with page-based introduction flow.
///
/// API Reference:
/// - No public properties (uses internal state)
///
/// Usage:
/// ```dart
/// OnlineOnboarding()
/// ```
class OnlineOnboarding extends StatefulWidget {
  const OnlineOnboarding({super.key});

  @override
  State<OnlineOnboarding> createState() => _OnlineOnboardingState();
}

class _OnlineOnboardingState extends State<OnlineOnboarding> {
  final PageController _controller = PageController();
  int activeIndex = 0;

  List<OnBoardingData> data = [
    OnBoardingData(
      title: "Welcome to Stuff",
      description: "I provide essential stuff for your ui designs every tuesday!",
    ),
    OnBoardingData(
      title: "Design Template uploads Every Tuesday!",
      description: "Make sure to take a look my uplab profile every tuesday",
    ),
    OnBoardingData(
      title: "Download now!",
      description: "You can follow me if you wantand comment on any to get some freebies",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const baseUrl = "https://raw.githubusercontent.com/yunweneric/flutter-open-ui/refs/heads/onboarding_ui_ch_2/assets/images";

    return Scaffold(
      body: Column(
        children: [
          AppSizing.khSpacer(context, 0.2),
          SizedBox(
            height: AppSizing.height(context) * 0.8,
            width: AppSizing.width(context),
            child: PageView.builder(
              itemCount: data.length,
              controller: _controller,
              onPageChanged: (page) {
                setState(() {
                  activeIndex = page;
                });
              },
              itemBuilder: (c, i) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      AnimatedRotation(
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 500),
                        turns: activeIndex == i
                            ? 0.0
                            : activeIndex > i
                                ? -0.1
                                : 0.1,
                        child: SvgPicture.network(
                          "$baseUrl/onboarding_${i + 1}.svg",
                          height: AppSizing.height(context) * 0.5,
                        ),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 1500),
                        opacity: activeIndex == i ? 1 : 0,
                        child: AnimatedScale(
                          alignment: Alignment.topCenter,
                          duration: const Duration(milliseconds: 500),
                          scale: activeIndex == i ? 1 : 0,
                          child: Column(
                            children: [
                              Text(
                                data[i].title,
                                style: Theme.of(context).textTheme.displayMedium,
                                textAlign: TextAlign.center,
                              ),
                              AppSizing.k20(context),
                              Text(
                                data[i].description,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          AppSizing.k20(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    _controller.animateToPage(
                      3,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(data.length, (i) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          margin: const EdgeInsets.only(right: 10),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: i == activeIndex ? Colors.black : Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      })
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _controller.animateToPage(
                      activeIndex + 1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AppSizing {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static SizedBox k20(BuildContext context) => SizedBox(height: height(context) * 0.02);
  static SizedBox khSpacer(BuildContext context, double factor) => SizedBox(height: width(context) * factor);
}
