import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

Widget resourcesSection(Component component, BuildContext context) {
  if (component.assetLink == null && component.gitHubLink == null) return const SizedBox.shrink();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        context.tr("resources"),
        style: Theme.of(context).textTheme.displayMedium,
      ),
      AppSizing.khSpacer(5),
      if (component.gitHubLink != null)
        rowItem(
          onTap: () => UtilHelper.openUrl(component.gitHubLink!),
          leading: AppIcons.github,
          title: context.tr("openGithubRepositor"),
        ),
      if (component.assetLink != null)
        rowItem(
          onTap: () => UtilHelper.openUrl(component.assetLink!),
          leading: AppIcons.download,
          title: context.tr("downloadAssets"),
        ),
      AppSizing.kh20Spacer(),
      AppSizing.kh10Spacer(),
    ],
  );
}

Widget rowItem({required String leading, required String title, required VoidCallback onTap}) {
  bool isHovered = false;
  return StatefulBuilder(builder: (context, setState) {
    return InkWell(
      highlightColor: Theme.of(context).scaffoldBackgroundColor,
      splashColor: Theme.of(context).scaffoldBackgroundColor,
      hoverColor: Theme.of(context).scaffoldBackgroundColor,
      onTap: onTap,
      onHover: (val) {
        setState(() => isHovered = val);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: AnimatedScale(
          alignment: Alignment.centerLeft,
          duration: const Duration(milliseconds: 300),
          scale: isHovered ? 1.05 : 1.0,
          child: Row(
            children: [
              AppIcon(icon: leading, color: isHovered ? Theme.of(context).primaryColor : null),
              AppSizing.kwSpacer(5),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: isHovered ? Theme.of(context).primaryColor : null),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  });
}
