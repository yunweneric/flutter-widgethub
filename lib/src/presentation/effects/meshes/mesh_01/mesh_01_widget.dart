import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/utils/images.dart';
import 'package:mesh/mesh.dart';

OMeshRect meshRect(double dt) => OMeshRect(
      width: 3,
      height: 4,
      fallbackColor: const Color(0xff1f0081),
      backgroundColor: const Color(0xff1f0081),
      vertices: [
        (0.0, 0.0).v,
        (0.68, -0.0).v.bezier(
              south: (0.63, 0.35).v,
            ),
        (1.0, 0.0).v, // Row 1
        (-0.0, 0.33).v,
        (0.59, 0.43).v.lerpTo((0.40, -0.2).v, dt).bezier(
              east: (0.65, 0.42).v,
              south: (0.56, 0.55).v,
              west: (0.47, 0.42).v,
            ),
        (1.0, 0.33).v, // Row 2
        (-0.01, 0.59).v.bezier(
              east: (0.15, 0.55).v,
            ),
        (0.36, 0.6).v.bezier(
              east: (0.53, 0.78).v,
              west: (0.15, 0.72).v,
            ),
        (1.0, 0.67).v, // Row 3
        (0.0, 1.0).v,
        (0.5, 1.0).v.lerpTo((1.0, 1.2).v, dt).bezier(
              north: (0.41, 0.75).v,
              east: (0.59, 1.0).v,
            ),
        (1.0, 1.0).v, // Row 4
      ],
      colors: const [
        Color(0xff1f0081), Color(0xff1f0081), Color(0xfff802ec), // Row 1
        Color(0xff1f0081), Color(0xff1f0081), Color(0xfff802ec), // Row 2
        Color(0xff1f0081), Color(0xff1f0081), Color(0xfff802ec), // Row 3
        Color(0xfff802ec), Color(0xff1f0081), Color(0xfff802ec), // Row 4
      ],
    );

class MeshGradient01 extends StatefulWidget {
  const MeshGradient01({super.key});

  @override
  State<MeshGradient01> createState() => _MeshGradient01State();
}

class _MeshGradient01State extends State<MeshGradient01> with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(vsync: this)
    ..duration = const Duration(seconds: 5)
    ..forward()
    ..addListener(() {
      if (controller.value == 1.0) {
        controller.animateTo(0, curve: Curves.easeInOutQuint);
      }
      if (controller.value == 0.0) {
        controller.animateTo(1, curve: Curves.easeInOutCubic);
      }
    });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final dt = controller.value;

            return OMeshGradient(mesh: meshRect(dt));
          },
        ),
        Positioned(
          child: Image.asset(
            AppImages.rice,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            fit: BoxFit.cover,
            color: Colors.white.withOpacity(0.3),
          ),
        ),
      ],
    );
  }
}
