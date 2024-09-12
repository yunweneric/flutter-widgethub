import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class LeaveReviewHomeScreen extends StatefulWidget {
  const LeaveReviewHomeScreen({super.key});

  @override
  State<LeaveReviewHomeScreen> createState() => _LeaveReviewHomeScreenState();
}

class _LeaveReviewHomeScreenState extends State<LeaveReviewHomeScreen> {
  double value = 1.0;
  final pageController = PageController(initialPage: 1);
  int activeIndex = 1;

  final duration = const Duration(milliseconds: 500);
  Timer? timer;

  bool isForward = true;

  startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 3000), (tick) {
      setState(() {
        value = isForward ? value + 1 : value - 1;
        activeIndex = isForward ? activeIndex + 1 : activeIndex - 1;
        if (value == 0) isForward = true;
        if (value == 3) isForward = false;
      });
      pageController.animateToPage(activeIndex, duration: duration, curve: Curves.elasticOut);
    });
  }

  @override
  void initState() {
    pageController.addListener(listenPageChange);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        value = 2.0;
        activeIndex = 2;
      });
      pageController.animateToPage(2, duration: duration, curve: Curves.elasticOut);
    });
    // startTimer();

    super.initState();
  }

  @override
  void dispose() {
    pageController.removeListener(listenPageChange);
    pageController.dispose();
    timer?.cancel();
    super.dispose();
  }

  void listenPageChange() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: LeaveReviewAppSizing.height(context),
        width: LeaveReviewAppSizing.width(context),
        decoration: BoxDecoration(color: generateColors()),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 1000),
                  tween: Tween<double>(begin: 1, end: 0),
                  curve: Curves.easeOutBack,
                  builder: (context, doubleVal, child) {
                    return Transform.translate(
                      offset: Offset(0, doubleVal * -LeaveReviewAppSizing.height(context) / 2),
                      child: Column(
                        children: [
                          headerSection(),
                          eyesSection(),
                        ],
                      ),
                    );
                  }),
              TweenAnimationBuilder(
                duration: const Duration(milliseconds: 1000),
                tween: Tween<double>(begin: 1, end: 0),
                curve: Curves.easeOutBack,
                builder: (context, doubleVal, child) {
                  return Transform.translate(
                    offset: Offset(0, doubleVal * LeaveReviewAppSizing.height(context) / 2),
                    child: textAndSliderSection(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: ReviewColors.bgBlack.withOpacity(0.1),
                child: const Icon(Icons.close),
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: ReviewColors.bgBlack.withOpacity(0.1),
                child: const Icon(Icons.info_outline),
              ),
            ],
          ),
          LeaveReviewAppSizing.kh20(context),
          Text(
            "How was your shopping\nexperience",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          LeaveReviewAppSizing.khSpacer(LeaveReviewAppSizing.height(context) * 0.05),
        ],
      ),
    );
  }

  Widget eyesSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            eye(),
            LeaveReviewAppSizing.kw20(context),
            eye(),
          ],
        ),
        LeaveReviewAppSizing.kh20(context),
        TweenAnimationBuilder(
            key: ValueKey(activeIndex),
            tween: activeIndex == 2
                ? Tween<double>(
                    begin: 1.0,
                    end: 0.0,
                  )
                : Tween<double>(
                    begin: 0.0,
                    end: 1.0,
                  ),
            duration: const Duration(milliseconds: 500),
            builder: (context, animateValue, child) {
              return Transform.rotate(
                angle: pi * animateValue,
                // angle: value < 0.5 ? pi : pi * -value,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CustomPaint(
                    painter: ArcPainter(),
                  ),
                ),
              );
            })
      ],
    );
  }

  Widget eye() {
    return Builder(builder: (context) {
      double width = 70;
      double height = 35;
      double radius = 35;
      if (value <= 0.5) {
        width = 70;
        height = 70;
      }
      if (value > 0.5 && value < 1.2) {
        width = 70;
        height = 30;
      }
      if (value >= 1.2) {
        height = 120;
        width = 120;
        radius = 60;
      }
      return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ReviewColors.bgBlack,
          borderRadius: BorderRadius.circular(radius),
        ),
      );
    });
  }

  Widget textAndSliderSection() {
    List<String> items = ["BAD", "NOT BAD", "GOOD"];
    return Builder(
      builder: (context) {
        return Column(
          children: [
            SizedBox(
              height: LeaveReviewAppSizing.height(context) * 0.08,
              child: PageView.builder(
                  allowImplicitScrolling: false,
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  itemCount: items.length,
                  onPageChanged: (value) {
                    setState(() {
                      activeIndex = value;
                    });
                  },
                  itemBuilder: (context, i) {
                    return Center(
                      child: Text(
                        items[i],
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                              color: ReviewColors.bgBlack.withOpacity(0.3),
                            ),
                      ),
                    );
                  }),
            ),
            LeaveReviewAppSizing.khSpacer(LeaveReviewAppSizing.height(context) * 0.05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: AppSlider(
                value: value,
                onChanged: (dynamic val) {
                  setState(() {
                    value = val;
                  });

                  pageController.animateTo(
                    value * LeaveReviewAppSizing.width(context),
                    duration: const Duration(milliseconds: 1800),
                    curve: Curves.elasticOut,
                  );
                },
              ),
            ),
            LeaveReviewAppSizing.khSpacer(LeaveReviewAppSizing.height(context) * 0.1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: LeaveReviewAppSizing.width(context),
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: ReviewColors.bgBlack.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Add Note",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: ElevatedButton.icon(
                      iconAlignment: IconAlignment.end,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {},
                      label: Text(
                        "Submit",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  )
                ],
              ),
            ),
            LeaveReviewAppSizing.khSpacer(LeaveReviewAppSizing.height(context) * 0.05),
          ],
        );
      },
    );
  }

  Color generateColors() {
    if (value <= 0.5) {
      return ReviewColors.bgRed;
    } else if (value >= 0.5 && value <= 1.2) {
      return ReviewColors.bgOrange;
    } else {
      return ReviewColors.bgGreen;
    }
  }
}

class ReviewColors {
  static const textWhite = Color(0xFFFFFFFF);
  static const bgBlack = Color(0xFF161616);
  static const textBlack = Color(0xFF232323);
  static const bgWhite = Color(0xFFC0C0C0);
  static const bgRed = Color(0xFFFC7359);
  static const bgOrange = Color(0xFFDFA342);
  static const bgGreen = Color(0xFF9FBE59);
}

class LeaveReviewAppSizing {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
  static bool isMobile(BuildContext context) => width(context) < 480;
  static bool isTablet(BuildContext context) => width(context) > 480 && width(context) < 895;
  static bool isDesktop(BuildContext context) => width(context) > 895;
  static SizedBox kh10(BuildContext context) => const SizedBox(height: 10);
  static SizedBox khSpacer(double height) => SizedBox(height: height);
  static SizedBox kh20(BuildContext context) => const SizedBox(height: 20);
  static SizedBox kw20(BuildContext context) => const SizedBox(width: 20);
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ReviewColors.bgBlack
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12.0;

    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height / 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class AppSlider extends StatefulWidget {
  final double value;
  final void Function(dynamic)? onChanged;
  const AppSlider({super.key, this.onChanged, required this.value});

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  @override
  Widget build(BuildContext context) {
    return SfSliderTheme(
      data: SfSliderThemeData(
        activeLabelStyle: Theme.of(context).textTheme.displaySmall,
        inactiveLabelStyle: Theme.of(context).textTheme.displaySmall,
        labelOffset: const Offset(0.0, 30.0),
        activeTrackColor: ReviewColors.bgBlack.withOpacity(0.2),
        inactiveTrackColor: ReviewColors.bgBlack.withOpacity(0.2),
      ),
      child: SfSlider(
        min: 0.0,
        max: 2.0,
        value: widget.value,
        interval: 1,
        showDividers: true,
        showLabels: true,
        labelFormatterCallback: (dynamic actualValue, String formattedText) {
          return actualValue == 0
              ? 'Bad'
              : actualValue == 1
                  ? 'Not Bad'
                  : 'Good';
        },
        dividerShape: _DividerShape(),
        thumbShape: _SfThumbShape(animateAngle: widget.value >= 1 ? widget.value * 1 : 1),
        onChanged: (dynamic newValue) {
          if (widget.onChanged != null) widget.onChanged!(newValue);
          setState(() {
            // widget.value = newValue;
          });
        },
      ),
    );
  }
}

class _DividerShape extends SfDividerShape {
  @override
  void paint(
    PaintingContext context,
    Offset center,
    Offset? thumbCenter,
    Offset? startThumbCenter,
    Offset? endThumbCenter, {
    required RenderBox parentBox,
    required SfSliderThemeData themeData,
    SfRangeValues? currentValues,
    dynamic currentValue,
    required Paint? paint,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
  }) {
    bool isActive;

    switch (textDirection) {
      case TextDirection.ltr:
        isActive = center.dx <= thumbCenter!.dx;
        break;
      case TextDirection.rtl:
        isActive = center.dx >= thumbCenter!.dx;
        break;
    }

    context.canvas.drawCircle(
      center,
      10.0,
      Paint()
        ..isAntiAlias = true
        ..style = PaintingStyle.fill
        ..color = ReviewColors.bgBlack,
    );
  }
}

class _SfThumbShape extends SfThumbShape {
  final double animateAngle;

  _SfThumbShape({required this.animateAngle});
  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required RenderBox? child,
    required SfSliderThemeData themeData,
    SfRangeValues? currentValues,
    dynamic currentValue,
    required Paint? paint,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required SfThumb? thumb,
  }) {
    final Path path = Path();
    double radius = 10.0; // Radius of the arc
    double startAngle = pi * animateAngle; // Starting angle in radians
    double sweepAngle = 3.14; // Sweep angle in radians (half-circle)

    // Calculate the start and end points of the arc
    Offset startPoint = Offset(
      center.dx + radius * cos(startAngle),
      center.dy + radius * sin(startAngle),
    );
    Offset endPoint = Offset(
      center.dx + radius * cos(startAngle + sweepAngle),
      center.dy + radius * sin(startAngle + sweepAngle),
    );

    // Calculate control points for the Bézier curve
    double controlPointDistance = radius * (4 / 3) * tan(sweepAngle / 4);
    Offset controlPoint1 = Offset(
      startPoint.dx - controlPointDistance * sin(startAngle),
      startPoint.dy + controlPointDistance * cos(startAngle),
    );
    Offset controlPoint2 = Offset(
      endPoint.dx + controlPointDistance * sin(startAngle + sweepAngle),
      endPoint.dy - controlPointDistance * cos(startAngle + sweepAngle),
    );

    // Move to the start point
    path.moveTo(startPoint.dx, startPoint.dy);

    // Draw the arc using Bézier curves
    path.cubicTo(
      controlPoint1.dx,
      controlPoint1.dy,
      controlPoint2.dx,
      controlPoint2.dy,
      endPoint.dx,
      endPoint.dy,
    );

    // Draw the path on the canvas

    context.canvas.drawCircle(
      center,
      20,
      Paint()
        ..color = ReviewColors.bgBlack
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 2,
    );
    context.canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white.withOpacity(0.1)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 5,
    );
  }
}
