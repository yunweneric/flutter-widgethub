const doctorOnboardingCode = """
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingData {
  final String title;
  final String description;
  final String image;

  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int activeIndex = 0;
  int previousIndex = 5;
  PageController controller = PageController(initialPage: 1);
  final curve = Curves.fastOutSlowIn;
  final duration = const Duration(milliseconds: 700);
  final baseURL = 'https://github.com/yunweneric/flutter-open-ui/blob/9-implement-the-ui-for-doctor-onboarding/assets/images';
  List<OnboardingData> data() => [
        OnboardingData(
          title: 'Meet Doctors Online',
          description: 'Connect with Specialized Doctors Online for Convenient and Comprehensive Medical Consultations.',
          image: 'https://github.com/yunweneric/flutter-open-ui/blob/9-implement-the-ui-for-doctor-onboarding/assets/images/doctor_0.png?raw=true',
        ),
        OnboardingData(
          title: "Connect with Specialists",
          description: "Connect with Specialized Doctors Online for Convenient and Comprehensive Medical Consultations.",
          image: 'https://github.com/yunweneric/flutter-open-ui/blob/9-implement-the-ui-for-doctor-onboarding/assets/images/doctor_1.png?raw=true',
        ),
        OnboardingData(
          title: 'Thousands of Online Specialists',
          description: ' Explore a Vast Array of Online Medical Specialists, Offering an Extensive Range of Expertise Tailored to Your Healthcare Needs.',
          image: 'https://github.com/yunweneric/flutter-open-ui/blob/9-implement-the-ui-for-doctor-onboarding/assets/images/doctor_2.png?raw=true',
        ),
        OnboardingData(
          title: 'Meet Doctors Online',
          description: 'Connect with Specialized Doctors Online for Convenient and Comprehensive Medical Consultations.',
          image: 'https://github.com/yunweneric/flutter-open-ui/blob/9-implement-the-ui-for-doctor-onboarding/assets/images/doctor_0.png?raw=true',
        ),
        OnboardingData(
          title: "Connect with Specialists",
          description: "Connect with Specialized Doctors Online for Convenient and Comprehensive Medical Consultations.",
          image: 'https://github.com/yunweneric/flutter-open-ui/blob/9-implement-the-ui-for-doctor-onboarding/assets/images/doctor_1.png?raw=true',
        ),
        OnboardingData(
          title: 'Thousands of Online Specialists',
          description: ' Explore a Vast Array of Online Medical Specialists, Offering an Extensive Range of Expertise Tailored to Your Healthcare Needs.',
          image: 'https://github.com/yunweneric/flutter-open-ui/blob/9-implement-the-ui-for-doctor-onboarding/assets/images/doctor_2.png?raw=true',
        ),
      ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // *When the post from is called, trigger the initial animation.
      //* Variables are initially declared with edge values
      reset();
    });
    super.initState();
  }

  moveToNext(int index) {
    //* If the index is the last item then move to the next screen
    if (index == data().length - 1) {
      //* Here, you will implement the routing to the next screen
    } else {
      setState(() {
        previousIndex = index;
        activeIndex = index + 1;
      });
    }
    controller.animateToPage(activeIndex, duration: duration, curve: curve);
  }

  reset() {
    setState(() {
      previousIndex = data().length - 1;
      activeIndex = 0;
    });
    controller.animateToPage(activeIndex, duration: duration, curve: curve);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: AppSizing.width(context),
            height: AppSizing.height(context) * 0.6,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TweenAnimationBuilder(
                      key: ValueKey(activeIndex),
                      curve: curve,
                      tween: Tween<double>(begin: 1.0, end: 0.0),
                      duration: duration,
                      builder: (context, value, child) {
                        return Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.01)
                            ..rotateX(value * -0.06),
                          child: Opacity(
                            opacity: 1,
                            child: GestureDetector(
                              onPanUpdate: (coord) {},
                              onVerticalDragUpdate: (_) {},
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r * value),
                                  topRight: Radius.circular(20.r * value),
                                ),
                                child: Image.network(
                                  width: AppSizing.width(context),
                                  height: AppSizing.height(context) * 0.6,
                                  data()[activeIndex].image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, i, e) {
                                    return const CircularProgressIndicator.adaptive();
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                TweenAnimationBuilder(
                  key: ValueKey(activeIndex),
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  curve: curve,
                  duration: duration,
                  builder: (context, value, child) {
                    return Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.01)
                        ..rotateX(value * 0.01),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                        child: Opacity(
                          opacity: 1 - value,
                          child: Image.asset(
                            width: AppSizing.width(context),
                            height: AppSizing.height(context) * 0.6,
                            data()[previousIndex].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppSizing.height(context) * 0.4,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppSizing.kh10Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: AppSizing.kHPercentage(context, 18),
                          child: PageView.builder(
                            itemCount: data().length,
                            scrollDirection: Axis.vertical,
                            controller: controller,
                            itemBuilder: (c, i) {
                              return AnimatedOpacity(
                                opacity: activeIndex == i ? 1 : 0,
                                duration: Duration(seconds: 5),
                                curve: curve,
                                child: Column(
                                  children: [
                                    AppSizing.kh20Spacer(),
                                    Text(
                                      data()[activeIndex].title,
                                      style: Theme.of(context).textTheme.displaySmall,
                                      textAlign: TextAlign.center,
                                    ),
                                    AppSizing.kh20Spacer(),
                                    Text(
                                      data()[activeIndex].description,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                    AppSizing.kh20Spacer(),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        AppButton(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          title: activeIndex >= data().length - 1 ? 'Get Started' : "Next",
                          onPressed: () => moveToNext(activeIndex),
                          borderRadius: 30.r,
                        ),
                        AppSizing.kh20Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(data().length, (i) => i).map((index) {
                              return InkWell(
                                highlightColor: Theme.of(context).scaffoldBackgroundColor,
                                onTap: () => moveToNext(index),
                                child: AnimatedContainer(
                                  width: activeIndex == index ? 30.w : 10.w,
                                  height: activeIndex == index ? 8.w : 10.w,
                                  margin: EdgeInsets.only(right: 5.w),
                                  decoration: BoxDecoration(
                                    color: activeIndex == index ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(activeIndex == index ? 8.r : 30.r),
                                  ),
                                  duration: const Duration(milliseconds: 500),
                                ),
                              );
                            })
                          ],
                        ),
                        AppSizing.kh20Spacer(),
                        InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: reset,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
                            child: const Text("Reset"),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
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
  static double kHPercentage(BuildContext context, double value) => (height(context) * value) / 100;
  static double kWPercentage(BuildContext context, double value) => (width(context) * value) / 100;
  static BorderRadius radiusMd = BorderRadius.circular(10.r);
  static BorderRadius radiusSm = BorderRadius.circular(5.r);

  static EdgeInsets kMainPadding(BuildContext context) => EdgeInsets.symmetric(
        // horizontal: isMobile(context) ? 20.w : 30.w,
        horizontal: isMobile(context) ? 20.w : 30.w,
      );

  static EdgeInsets kpadding(double width, double height) => EdgeInsets.symmetric(horizontal: width.w, vertical: height.h);

  static Widget kh20Spacer() => SizedBox(height: 20.h);
  static Widget kh10Spacer() => SizedBox(height: 10.h);

  static Widget khSpacer(double height) => SizedBox(height: height);

  static Widget kwSpacer(double width) => SizedBox(width: width);

  static bool isXMobile(context) => width(context) < 380;
  static bool isMobile(context) => width(context) < 789;
  static bool isTablet(context) => width(context) > 789 && width(context) < 992;
  static bool isDesktop(context) => width(context) > 992;
}

class AppButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final Color? bgColor;
  final Color? textColor;
  final Color? disabledBgColor;
  final TextStyle? textStyle;
  final Widget? icon;
  final double? width;
  final double? height;
  final double? borderRadius;
  final bool isDisabled;
  final bool isElevated;
  final BorderSide? side;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    required this.title,
    required this.onPressed,
    this.bgColor,
    this.borderRadius,
    this.textColor,
    this.disabledBgColor,
    this.textStyle,
    this.icon,
    this.side,
    this.width,
    this.height,
    this.padding,
    this.isDisabled = false,
    this.isElevated = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: isElevated ? null : 0,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
        disabledBackgroundColor: disabledBgColor ?? bgColor?.withOpacity(.5),
        backgroundColor: bgColor ?? theme.colorScheme.primary,
        surfaceTintColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 16.r), side: side ?? BorderSide.none),
        shadowColor: AppColors.TEXTBLACK.withOpacity(.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 8),
          ],
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: textStyle ??
                  theme.textTheme.bodyMedium!.copyWith(
                    color: textColor ?? AppColors.TEXTWHITE,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppColors {
  // Text colors
  static const Color TEXTBLACK = Color(0xFF030303);
  static const Color TEXTWHITE = Color(0XFFFFFFFF);
  static const Color RED = Color(0xFFFF3F3F);
}
""";
