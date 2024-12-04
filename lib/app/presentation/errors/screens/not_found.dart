import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/app/core/app.dart';
// import 'package:flutterui/screens/routes/app_router.gr.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';

class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({super.key});

  @override
  State<NotFoundScreen> createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: AppSizing.width(context),
        height: AppSizing.height(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Text(context.tr("pageNotFound")),
            ElevatedButton(
              onPressed: () {
                // final router = context.innerRouterOf<StackRouter>(ComponentLayoutRoute.name);
                // print(router);
                // context.router.pushNamed(RouteNames.home);
              },
              child:  Text(context.tr("home")),
            ),
          ],
        ),
      ),
    );
  }
}
