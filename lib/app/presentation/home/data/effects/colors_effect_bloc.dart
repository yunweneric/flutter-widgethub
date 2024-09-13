import 'package:flutter/material.dart';
import 'package:fwh/app/shared/presentation/utils/sizing.dart';

class ColorsEffectBloc extends StatefulWidget {
  const ColorsEffectBloc({super.key});

  @override
  State<ColorsEffectBloc> createState() => _ColorsEffectBlocState();
}

class _ColorsEffectBlocState extends State<ColorsEffectBloc> with SingleTickerProviderStateMixin {
  AnimationController? myAnimationController;

  Animation<Color>? animation;

  final curve = Curves.easeInOut;
  @override
  void initState() {
    myAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 10000),
    )..repeat();

    animation = TweenSequence<Color>(
      <TweenSequenceItem<Color>>[
        TweenSequenceItem<Color>(
          tween: Tween<Color>(begin: Colors.teal.shade500, end: Colors.red.shade500).chain(
            CurveTween(curve: curve),
          ),
          weight: 25.0,
        ),
        TweenSequenceItem<Color>(
          tween: Tween<Color>(begin: Colors.teal.shade500, end: Colors.red.shade500).chain(
            CurveTween(curve: curve),
          ),
          weight: 25.0,
        ),
        TweenSequenceItem<Color>(
          tween: Tween<Color>(begin: Colors.blue.shade500, end: Colors.yellow.shade500).chain(
            CurveTween(curve: curve),
          ),
          weight: 25.0,
        ),
        TweenSequenceItem<Color>(
          tween: Tween<Color>(begin: Colors.orange.shade500, end: Colors.amber.shade500).chain(
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
      body: SafeArea(
        child: AnimatedBuilder(
            animation: myAnimationController!,
            builder: (context, child) {
              return SizedBox(
                height: AppSizing.kHPercentage(context, 30),
                child: Center(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(animation!.value, BlendMode.srcATop),
                    child: Image.asset(
                      "assets/images/flutter_light.png",
                      width: AppSizing.kWPercentage(context, 50),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
