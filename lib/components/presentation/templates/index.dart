// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutterui/components/data/logic/component/component_bloc.dart';
// import 'package:flutterui/app/core/service_locators.dart';
// import 'package:flutterui/app/presentation/categories/widget/category_card.dart';
// // import 'package:flutterui/screens/routes/app_router.dart';
// import 'package:flutterui/app/shared/logic/navigation/navigation_bloc.dart';
// import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
// import 'package:flutterui/app/shared/presentation/widgets/layout/main_content.dart';

// // @RoutePage()
// class ComponentTemplatesScreen extends StatefulWidget {
//   const ComponentTemplatesScreen({super.key});

//   @override
//   State<ComponentTemplatesScreen> createState() => _ComponentTemplatesScreenState();
// }

// class _ComponentTemplatesScreenState extends State<ComponentTemplatesScreen> {
//   final navigationBloc = getIt.get<NavigationBloc>();
//   // final autoRoute = getIt.get<AppRouter>();
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ComponentBloc, ComponentState>(
//       builder: (context, state) {
//         return MainContent(
//           children: [
//             Wrap(
//               alignment: WrapAlignment.spaceBetween,
//               runAlignment: WrapAlignment.spaceBetween,
//               crossAxisAlignment: WrapCrossAlignment.center,
//               spacing: AppSizing.isTablet(context) ? AppSizing.kWPercentage(context, 2) : AppSizing.kWPercentage(context, 5),
//               runSpacing: AppSizing.kWPercentage(context, 5),
//               children: [
//                 ...state.allComponents.map(
//                   (item) {
//                     return CategoryCard(component: item);
//                   },
//                 )
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
