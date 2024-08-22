import 'package:flutter/material.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';

class ListColorTween extends Tween<List<Color>> {
  ListColorTween({super.begin, super.end});

  @override
  List<Color> lerp(double t) {
    List<Color> result = [];
    for (int i = 0; i < begin!.length; i++) {
      result.add(Color.lerp(begin![i], end![i], t)!);
    }
    return result;
  }
}

class GradientEffectsBlocItem extends StatefulWidget {
  const GradientEffectsBlocItem({super.key});

  @override
  State<GradientEffectsBlocItem> createState() => _GradientEffectssideBarCategoriestate();
}

class _GradientEffectssideBarCategoriestate extends State<GradientEffectsBlocItem> with SingleTickerProviderStateMixin {
  AnimationController? myAnimationController;

  Animation<List<Color>>? animation;

  final curve = Curves.easeInOut;
  @override
  void initState() {
    myAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10000),
    )..repeat();

    animation = TweenSequence<List<Color>>(
      <TweenSequenceItem<List<Color>>>[
        TweenSequenceItem<List<Color>>(
          tween: ListColorTween(begin: [Colors.teal, Colors.tealAccent], end: [Colors.green, Colors.greenAccent]).chain(
            CurveTween(curve: curve),
          ),
          weight: 25.0,
        ),
        TweenSequenceItem<List<Color>>(
          tween: ListColorTween(begin: [Colors.blue, Colors.blueAccent], end: [Colors.green, Colors.greenAccent]).chain(
            CurveTween(curve: curve),
          ),
          weight: 25.0,
        ),
        TweenSequenceItem<List<Color>>(
          tween: ListColorTween(begin: [Colors.red, Colors.redAccent], end: [Colors.orange, Colors.orangeAccent]).chain(
            CurveTween(curve: curve),
          ),
          weight: 25.0,
        ),
        TweenSequenceItem<List<Color>>(
          tween: ListColorTween(begin: [Colors.pink, Colors.pinkAccent], end: [Colors.amber, Colors.amberAccent]).chain(
            CurveTween(curve: curve),
          ),
          weight: 25.0,
        ),
      ],
    ).animate(myAnimationController!);

    super.initState();
  }

  @override
  void dispose() {
    myAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedBuilder(
              animation: myAnimationController!,
              builder: (context, value) {
                return Container(
                  alignment: Alignment.bottomCenter,
                  height: AppSizing.kHPercentage(context, 50),
                  width: AppSizing.width(context),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: animation!.value,
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
