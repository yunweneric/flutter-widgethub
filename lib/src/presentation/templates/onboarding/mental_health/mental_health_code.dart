const mentalHealthOnboardingCode = """import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingData {
  final String title;
  final String description;

  OnBoardingData({required this.title, required this.description});
}

class MentalHealthOnboarding extends StatefulWidget {
  const MentalHealthOnboarding({super.key});

  @override
  State<MentalHealthOnboarding> createState() => _MentalHealthOnboardingState();
}

class _MentalHealthOnboardingState extends State<MentalHealthOnboarding> {
  final PageController _controller = PageController();
  int activeIndex = 0;

  List<OnBoardingData> data = [
    OnBoardingData(
      title: "Behavioral Health Service",
      description: "Transforming lives by offering hope and opportunities for recovery, wellness, and independence.",
    ),
    OnBoardingData(
      title: "Mental Health Service",
      description: "If you think that you or someone you know has a mental health problem, there are a number of ways that you can seek advice.",
    ),
    OnBoardingData(
      title: "Get Started",
      description: "Take the first step on your journey to better mental health. Get started today!",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const baseUrl = "https://raw.githubusercontent.com/yunweneric/flutter-open-ui/refs/heads/onboarding_ui_ch_3/assets/images/";
    return Scaffold(
      backgroundColor: const Color(0xff7265E2),
      body: Stack(
        children: [
          Positioned(
            top: AppSizing.height(context) * 0.0,
            right: 0,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: SvgPicture.string(
                blob_1,
                color: Colors.white.withOpacity(0.7),
                width: AppSizing.width(context),
                height: AppSizing.height(context) * 0.6,
              ),
            ),
          ),
          Positioned(
            bottom: AppSizing.height(context) * 0.0,
            right: -AppSizing.width(context) * 0.5,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: SvgPicture.string(blob_1, color: Colors.white.withOpacity(0.7)),
            ),
          ),
          Column(
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
                    return Column(
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 700),
                          opacity: activeIndex == i ? 1.0 : 0.0,
                          child: Image.network(
                            "\$baseUrl/boarding_\$i.png",
                            height: AppSizing.height(context) * 0.5,
                            width: AppSizing.width(context),
                            fit: BoxFit.cover,
                          ),
                        ),
                        AppSizing.k20(context),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: AnimatedScale(
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 700),
                            alignment: Alignment.center,
                            scale: activeIndex == i ? 1.0 : 0.0,
                            child: Column(
                              children: [
                                Text(
                                  data[i].title,
                                  style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                AppSizing.k20(context),
                                Text(
                                  data[i].description,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              AppSizing.k20(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: activeIndex == 2
                          ? SizedBox(
                              width: AppSizing.width(context) / 8,
                            )
                          : TextButton(
                              onPressed: () {
                                _controller.animateToPage(
                                  3,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.linear,
                                );
                              },
                              child: const Text(
                                "Skip",
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
                              ),
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
                              width: i == activeIndex ? 30 : 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: i == activeIndex ? Colors.white : Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _controller.animateToPage(
                          activeIndex + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      },
                      child: const CircleAvatar(radius: 25, child: Icon(Icons.chevron_right)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

final blob_1 = '''<svg width="375" height="437" viewBox="0 0 375 437" fill="none" xmlns="http://www.w3.org/2000/svg">
<g opacity="0.5" filter="url(#filter0_f_1_100)">
<path d="M366.423 201.996C292.701 224.903 254.714 186.946 206.389 297.799C158.064 408.652 -99.8316 197.344 46.3546 201.996C192.541 206.648 277.923 178.985 206.389 106.192C134.855 33.3996 440.145 179.089 366.423 201.996Z" fill="#D9D9D9"/>
</g>
<defs>
<filter id="filter0_f_1_100" x="-105" y="-21" width="590" height="458" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="53.5" result="effect1_foregroundBlur_1_100"/>
</filter>
</defs>
</svg>
''';

final blob_2 = '''
  <svg width="375" height="296" viewBox="0 0 375 296" fill="none" xmlns="http://www.w3.org/2000/svg">
<g opacity="0.5" filter="url(#filter0_f_1_99)">
<path d="M305.423 222.996C231.701 245.903 193.714 207.946 145.389 318.799C97.0635 429.652 -160.832 218.344 -14.6454 222.996C131.541 227.648 216.923 199.985 145.389 127.192C73.8549 54.3996 379.145 200.089 305.423 222.996Z" fill="#D9D9D9"/>
</g>
<defs>
<filter id="filter0_f_1_99" x="-166" y="0" width="590" height="458" filterUnits="userSpaceOnUse" color-interpolation-filters="sRGB">
<feFlood flood-opacity="0" result="BackgroundImageFix"/>
<feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
<feGaussianBlur stdDeviation="53.5" result="effect1_foregroundBlur_1_99"/>
</filter>
</defs>
</svg>

''';

class AppSizing {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static SizedBox k20(BuildContext context) => SizedBox(height: height(context) * 0.02);
  static SizedBox khSpacer(BuildContext context, double factor) => SizedBox(height: width(context) * factor);
}

""";
