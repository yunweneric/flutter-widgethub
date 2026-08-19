import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

class AppCloneBlocItem extends StatefulWidget {
  const AppCloneBlocItem({super.key});

  @override
  State<AppCloneBlocItem> createState() => _AppClonesideBarCategoriestate();
}

class _AppClonesideBarCategoriestate extends State<AppCloneBlocItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        const List<AppIconData> icons = [
          AppIcons.google,
          AppIcons.tiktok,
          AppIcons.linkedIn,
          AppIcons.youtube,
          AppIcons.spotify,
        ];
        return Container(
          margin: EdgeInsets.only(top: AppSizing.kHPercentage(context, 22)),
          alignment: Alignment.topCenter,
          child: Wrap(
            spacing: 30,
            children: [
              ...icons.map((item) {
                return AppIcon(icon: item, size: 30);
              }),
            ],
          ),
        );
      }),
    );
  }
}
