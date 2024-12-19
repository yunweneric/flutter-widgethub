import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/app_layout.dart';

class RequestComponentScreen extends StatefulWidget {
  const RequestComponentScreen({super.key});

  @override
  State<RequestComponentScreen> createState() => _RequestComponentScreenState();
}

class _RequestComponentScreenState extends State<RequestComponentScreen> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      children: [
        Text(
          LangUtil.trans("comingSoon"),
          style: Theme.of(context).textTheme.displayLarge,
        )
,
        AppSizing.kh10Spacer(),
         Text(
          LangUtil.trans("requestComingSoonDescription"),
          textAlign: TextAlign.center,
        )
,
      ],
    );
  }
}
