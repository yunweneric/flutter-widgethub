const meshGradient02 = """import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/utils/images.dart';
import 'package:mesh/mesh.dart';

OMeshRect grad2(double dt) => OMeshRect(
      width: 4,
      height: 3,
      fallbackColor: const Color(0xFFE5FDFF),
      backgroundColor: null,
      vertices: [
        (0.0, 0.0).v,
        (0.33, 0.0).v,
        (0.67, 0.0).v.bezier(
              south: (0.67, 0.04).v,
            ),
        (1.0, 0.0).v.bezier(
              south: (1.0, 0.09).v,
              west: (0.91, 0.0).v,
            ), // Row 1
        (0.0, 0.5).v,
        (0.32, 0.53).v.lerpTo((0.2, 0.8).v, dt),
        (0.65, 0.44).v.bezier(
              north: (0.66, 0.18).v.lerpTo((1.0, 0.0).v, dt),
            ),
        (1.0, 0.5).v.bezier(
              west: (0.99, 0.49).v.lerpTo((1.2, 1.0).v, dt),
            ), // Row 2
        (0.0, 1.0).v, (0.33, 1.0).v, (0.67, 1.0).v, (1.0, 1.0).v, // Row 3
      ],
      colors: const [
        Color(0xffe5fdff), Color(0xffe5fdff), Color(0xff80ceff), Color(0xff80ceff), // Row 1
        Color(0xffffe7bf), Color.fromARGB(255, 23, 159, 227), Color(0xffffca56), Color(0xff80ceff), // Row 2
        Color(0xffede6f3), Color(0xffede6f3), Color(0xffffca56), Color(0xffffca56), // Row 3
      ],
    );

class MeshGradient02 extends StatefulWidget {
  const MeshGradient02({super.key});

  @override
  State<MeshGradient02> createState() => _MeshGradient02State();
}

class _MeshGradient02State extends State<MeshGradient02> with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(vsync: this)
    ..duration = const Duration(seconds: 2)
    ..forward()
    ..addListener(() {
      if (controller.value == 1.0) {
        controller.animateTo(0, curve: Curves.linearToEaseOut);
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

            return OMeshGradient(mesh: grad2(dt));
          },
        ),
        Positioned(
          child: Image.asset(
            AppImages.rice,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            fit: BoxFit.cover,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}


""";
