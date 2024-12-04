import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/core/app.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/components/presentation/templates/basuu/shared/basuu_icons.dart';
import 'package:flutterui/components/presentation/templates/basuu/widgets/basuu_animated_child.dart';
import 'package:flutterui/components/presentation/templates/basuu/widgets/basuu_animated_screen.dart';
import 'package:flutterui/components/presentation/templates/basuu/widgets/basuu_app_icon.dart';

class BasuuLanguage {
  final String icon;
  final String name;

  BasuuLanguage({required this.icon, required this.name});
}

class BasuuChooseLanguageScreen extends StatefulWidget {
  const BasuuChooseLanguageScreen({super.key});

  @override
  State<BasuuChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<BasuuChooseLanguageScreen> {
  List<BasuuLanguage> languages = [
    BasuuLanguage(icon: BasuuIcons.flag_en, name: "english".tr()),
    BasuuLanguage(icon: BasuuIcons.flag_es, name: "spanish".tr()),
    BasuuLanguage(icon: BasuuIcons.flag_fr, name: "french".tr()),
    BasuuLanguage(icon: BasuuIcons.flag_ru, name: "russian".tr()),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BasuuAnimatedScreen(
        builder: (context, animated, animation) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: AppSizing.kMainPadding(context),
                child: Column(
                  children: [
                    AppSizing.khSpacer(kToolbarHeight / 2),
                    BasuuAnimatedChild(
                      offset: -1,
                      animation: animation,
                      child: ListTile(
                        splashColor: theme.scaffoldBackgroundColor,
                        onTap: () => Navigator.pop(context, true),
                        titleAlignment: ListTileTitleAlignment.top,
                        contentPadding: EdgeInsets.zero,
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: const BasuuIcon(icon: BasuuIcons.arrow_back, size: 20),
                        ),
                        title: Text(
                         context.tr( "whatLanguageYouWantStudy"),
                          style: theme.textTheme.displayLarge,
                        ),
                      ),
                    ),
                    AppSizing.kh20Spacer(),
                    BasuuAnimatedChild(
                      offset: 1,
                      animation: animation,
                      child: Column(
                        children: [
                          ...languages.map((language) {
                            return Material(
                              color: Colors.transparent,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  // onTap: () => AppRouter.navigate(context, const BasuuChooseCategoryScreen()),
                                  onTap: () {},
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: theme.highlightColor),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                                  leading: BasuuIcon(icon: language.icon),
                                  title: Text(language.name),
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
