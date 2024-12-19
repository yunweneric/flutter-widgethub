import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterui/app/shared/logic/language/language_bloc.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';

class LanguageButton extends StatefulWidget {
 const LanguageButton({ super.key });

  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}
final  languages = [
  "en",
  "fr"
];
class _LanguageButtonState extends State<LanguageButton> {



_handleChangeLanguage(String? val) {
context.read<LanguageBloc>().add(UpdateLanguageEvent(val!));

}
  String dropdownValue = 'en';
@override
void initState() {
  super.initState();
 dropdownValue =  context.locale.languageCode;
}
  @override
  Widget build(BuildContext context){
    return BlocConsumer<LanguageBloc, LanguageState>(
      listener: (context, state) async{
        if(state is LanguageUpdated){
          await LangUtil.setTrans(context, state.language);
        await WidgetsBinding.instance.performReassemble();

          dropdownValue = state.language;
        }
      },

      builder:(context, state) => SizedBox(

      width: 50,
        child: DropdownButton(
          value: dropdownValue,
          icon: const SizedBox(),
          items: languages.map((lang) => DropdownMenuItem(value: lang,child: SvgPicture.asset('assets/icons/$lang.svg', height: 25, width: 25,),)).toList(), elevation: 16, underline: const SizedBox(),  onChanged: _handleChangeLanguage),
      )
    );
  }
}
