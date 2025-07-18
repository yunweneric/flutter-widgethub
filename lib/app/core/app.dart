import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/language_bloc/language_bloc.dart';
import 'package:flutterui/app/shared/logic/navigation/navigation_bloc.dart';
import 'package:flutterui/app/shared/logic/sidebar/sidebar_bloc.dart';
import 'package:flutterui/app/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/theme.dart';
import 'package:flutterui/components/data/logic/component/component_bloc.dart';
import 'package:go_router/go_router.dart';

import 'app_scroll_behavior.dart';

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
            BlocProvider(create: (context) => getIt.get<ComponentBloc>()),
            BlocProvider(create: (context) => getIt.get<NavigationBloc>()),
            BlocProvider(create: (context) => getIt.get<SidebarBloc>()),
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return BlocConsumer<LanguageBloc, LanguageState>(
                listener: (context, langState) {
                  if (langState is UpdateLanguage) {
                    LangUtil.setTrans(context, langState.currentLocale);
                    print(["langState.language"]);
                    print(["langState.language", langState.currentLocale.languageCode]);
                  }
                },
                builder: (context, langState) {
                  return ScreenUtilInit(
                    designSize: Size(constraints.maxWidth, constraints.maxHeight),
                    useInheritedMediaQuery: true,
                    builder: (context, child) {
                      return MaterialApp.router(
                        routerConfig: getIt.get<GoRouter>(),
                        debugShowCheckedModeBanner: false,
                        localizationsDelegates: context.localizationDelegates,
                        supportedLocales: context.supportedLocales,
                        locale: context.locale,
                        // locale: Locale('fr', "FR"),
                        title: 'Flutter WidgetHub',
                        theme: AppTheme.light(),
                        darkTheme: AppTheme.dark(),
                        themeMode: state.themeMode,
                        scrollBehavior: AppScrollBehavior(),
                        builder: (context, child) {
                          // return SpotifyLyricScreen();
                          return child!;
                        },
                      );
                    },
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
