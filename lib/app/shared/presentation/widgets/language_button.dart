import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterui/app/shared/logic/language/language_bloc.dart';
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
  @override
  void initState() {
    // dropdownValue = context.locale.languageCode;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    dropdownValue = context.locale;
    super.didChangeDependencies();
  }

  void handleChangeLanguage(Locale? locale) {
    if (locale == null) return;
    context.read<LanguageBloc>().add(UpdateLanguageEvent(locale));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageBloc, LanguageState>(
      listener: (context, state) async {
        if (state is LanguageUpdated) {
          dropdownValue = state.locale;
        }
      },
      builder: (context, state) => Transform.scale(
        scale: 0.8,
        child: DropdownMenu(
          width: 100.w,
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
    );
  }
}
