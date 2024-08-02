import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/screens/home/home_screen.dart';
import 'package:flutterui/shared/utils/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ScreenUtilInit(
        designSize: Size(constraints.maxWidth, constraints.maxHeight),
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter UI',
            theme: AppTheme.dark(),
            darkTheme: AppTheme.dark(),
            home: HomeScreen(),
          );
        },
      );
    });
  }
}
