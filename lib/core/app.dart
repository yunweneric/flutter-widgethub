import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/core/service_locators.dart';
import 'package:flutterui/screens/home/home_screen.dart';
import 'package:flutterui/shared/data/enums/theme.dart';
import 'package:flutterui/shared/logic/language/language_bloc.dart';
import 'package:flutterui/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/shared/ui/utils/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt.get<ThemeBloc>()),
            BlocProvider(create: (context) => getIt.get<LanguageBloc>()),
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return ScreenUtilInit(
                designSize: Size(constraints.maxWidth, constraints.maxHeight),
                useInheritedMediaQuery: true,
                builder: (context, child) {
                  final themeMode = state.themeMode == AppThemeMode.SYSTEM;
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter UI',
                    theme: AppTheme.light(),
                    darkTheme: AppTheme.dark(),
                    themeMode: themeMode
                        ? ThemeMode.system
                        : themeMode
                            ? ThemeMode.dark
                            : ThemeMode.light,

                    // themeMode: ThemeMode.system,

                    home: HomeScreen(),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
