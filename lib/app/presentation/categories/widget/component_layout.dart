//// import 'package:flutter/material.dart';
library;
// import 'package:fwh/components/data/logic/component/component_bloc.dart';
// import 'package:fwh/core/service_locators.dart';
// import 'package:fwh/shared/ui/utils/sizing.dart';
// import 'package:fwh/shared/ui/widgets/layout/nav_bar.dart';
// import 'package:fwh/shared/ui/widgets/layout/side_bar.dart';

// @RoutePage()
// class ComponentLayoutScreen extends StatefulWidget {
//   final List<Widget>? widgets;
//   const ComponentLayoutScreen({super.key, this.widgets});

//   @override
//   State<ComponentLayoutScreen> createState() => _AppLayoutState();
// }

// class _AppLayoutState extends State<ComponentLayoutScreen> {
//   final duration = const Duration(seconds: 1);

//   final componentBloc = getIt.get<ComponentBloc>();
//   @override
//   void initState() {
//     componentBloc.add(GetAllComponentsEvent());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return Container(
//             alignment: Alignment.center,
//             height: AppSizing.height(context),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Center(child: NavBar(isHomeScreenLayout: false, onTap: () {})),
//                 Expanded(
//                   child: Container(
//                     // margin: EdgeInsets.symmetric(horizontal: AppSizing.kWPercentage(context, 2.5)),
//                     child: Row(
//                       children: [
//                         AnimatedContainer(
//                           duration: duration,
//                           decoration: BoxDecoration(
//                             border: Border(right: BorderSide(color: Theme.of(context).dividerColor)),
//                           ),
//                           width: AppSizing.isMobile(context) ? 0 : AppSizing.width(context) * 0.2,
//                           child: const SideBar(),
//                         ),
//                         const Expanded(child: AutoRouter()),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fwh/components/data/logic/component/component_bloc.dart';
import 'package:fwh/app/core/service_locators.dart';
import 'package:fwh/app/shared/presentation/utils/sizing.dart';
import 'package:fwh/app/shared/presentation/widgets/layout/app_layout.dart';
import 'package:fwh/app/shared/presentation/widgets/layout/side_bar.dart';

// @RoutePage()
class ComponentLayoutScreen extends StatefulWidget {
  final Widget child;
  const ComponentLayoutScreen({super.key, required this.child});

  @override
  State<ComponentLayoutScreen> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<ComponentLayoutScreen> {
  final duration = const Duration(seconds: 1);

  final componentBloc = getIt.get<ComponentBloc>();
  @override
  void initState() {
    componentBloc.add(GetAllComponentsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      hideFooter: true,
      isHomeScreenLayout: false,
      children: [
        SizedBox(
          width: AppSizing.width(context),
          height: AppSizing.height(context),
          child: Row(
            children: [
              AnimatedContainer(
                duration: duration,
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Theme.of(context).dividerColor)),
                ),
                width: AppSizing.isMobile(context) ? 0 : AppSizing.width(context) * 0.2,
                child: const SideBar(),
              ),
              Expanded(child: widget.child),
            ],
          ),
        ),
      ],
    );
  }
}
