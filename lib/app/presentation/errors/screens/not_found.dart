import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
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
             Text(LangUtil.trans("pageNotFound")),
            ElevatedButton(
              onPressed: () {
                // final router = context.innerRouterOf<StackRouter>(ComponentLayoutRoute.name);
                // print(router);
                // context.router.pushNamed(RouteNames.home);
              },
              child:  Text(LangUtil.trans("home")),
            ),
          ],
        ),
      ),
    );
  }
}
