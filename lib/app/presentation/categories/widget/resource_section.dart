import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

class ResourceSection extends StatelessWidget {
  final Component component;
  const ResourceSection({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    if (component.assetLink == null && component.gitHubLink == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangUtil.trans("resources"),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const KhSpacer(height: 5),
        if (component.gitHubLink != null)
          RowItem(
            onTap: () => UtilHelper.openUrl(component.gitHubLink!),
            leading: AppIcons.github,
            title: LangUtil.trans("openGithubRepository"),
          ),
        if (component.assetLink != null)
          RowItem(
            onTap: () => UtilHelper.openUrl(component.assetLink!),
            leading: AppIcons.download,
            title: LangUtil.trans("downloadAssets"),
          ),
        const Kh20Spacer(),
        const Kh10Spacer(),
      ],
    );
  }
}

class RowItem extends StatefulWidget {
  final String leading;
  final String title;
  final VoidCallback onTap;

  const RowItem({
    super.key,
    required this.leading,
    required this.title,
    required this.onTap,
  });

  @override
  State<RowItem> createState() => _RowItemState();
}

class _RowItemState extends State<RowItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Theme.of(context).scaffoldBackgroundColor,
      splashColor: Theme.of(context).scaffoldBackgroundColor,
      hoverColor: Theme.of(context).scaffoldBackgroundColor,
      onTap: widget.onTap,
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
              AppIcon(
                  icon: widget.leading,
                  color: isHovered ? Theme.of(context).primaryColor : null),
              const KwSpacer(width: 5),
              Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: isHovered ? Theme.of(context).primaryColor : null),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
