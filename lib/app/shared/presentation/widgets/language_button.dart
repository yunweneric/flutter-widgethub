import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/language_bloc/language_bloc.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';

class LanguageButton extends StatefulWidget {
  const LanguageButton({super.key});

  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}

List<Locale> languages = [
  const Locale("en", "US"),
  const Locale("fr", "FR"),
];

class _LanguageButtonState extends State<LanguageButton> {
  Locale dropdownValue = const Locale("en", "US");
  final languageBloc = getIt.get<LanguageBloc>();

  void handleChangeLanguage(Locale? locale) {
    if (locale == null) return;
    languageBloc.add(UpdateAppLanguageEvent(context: context, newLocale: locale));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageBloc, LanguageState>(
      listener: (context, state) async {
        dropdownValue = state.currentLocale;
      },

      builder: (context, state) => Transform.scale(
        scale: 0.8,
        child: DropdownMenu(
          enableSearch: false,
          width: 100.w,
          enableFilter: false,
          hintText: dropdownValue.languageCode.toUpperCase(),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10.r))),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10.r))),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10.r))),
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            fillColor: Theme.of(context).cardColor,
          ),
          initialSelection: dropdownValue,
          onSelected: handleChangeLanguage,
          dropdownMenuEntries: languages
              .map((lang) => DropdownMenuEntry(
                    value: lang,
                    label: lang.languageCode.toUpperCase(),
                    labelWidget: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/${lang.languageCode}.svg',
                          width: 20.w,
                          fit: BoxFit.cover,
                        ),
                        AppSizing.kwSpacer(5.w),
                        Text(lang.languageCode.toUpperCase()),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
      // builder: (context, state) => IconDropdownButton(
      //   btnWidthFraction: 220.w,
      //   button: Container(
      //     width: 50.w,
      //     child: Stack(
      //       children: [
      //         SvgPicture.asset(
      //           'assets/icons/${dropdownValue.languageCode}.svg',
      //           width: 10.w,
      //           height: 15.w,
      //         ),
      //         Positioned(
      //           child: Text(
      //             dropdownValue.languageCode.toUpperCase(),
      //             style: Theme.of(context).textTheme.bodyMedium,
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      //   builder: (lang) {
      //     return Row(
      //       children: [
      //         SvgPicture.asset(
      //           'assets/icons/${lang.languageCode}.svg',
      //           width: 20.w,
      //           fit: BoxFit.cover,
      //         ),
      //         AppSizing.kwSpacer(5.w),
      //         Text(
      //           lang.languageCode.toUpperCase(),
      //           style: Theme.of(context).textTheme.bodyMedium,
      //         ),
      //       ],
      //     );
      //   },
      //   items: languages,
      //   onChanged: handleChangeLanguage,
      // ),
    );
  }
}
