import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';

class SupportPlatformSection extends StatelessWidget {
  final Component component;
  const SupportPlatformSection({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangUtil.trans("supportOn"),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        AppSizing.kh10Spacer(),
        Row(
          children: [
            ...component.supportedPlatforms.map((item) {
              bool hasHovered = false;
              return StatefulBuilder(builder: (context, setState) {
                return InkWell(
                  highlightColor: Theme.of(context).scaffoldBackgroundColor,
                  splashColor: Theme.of(context).scaffoldBackgroundColor,
                  hoverColor: Theme.of(context).scaffoldBackgroundColor,
                  onTap: () {},
                  onHover: (val) {
                    setState(() => hasHovered = val);
                  },
                  child: AnimatedScale(
                    scale: hasHovered ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: AppSizing.radiusMd(),
                      ),
                      child: SvgPicture.string(
                        item.icon(),
                        color: Theme.of(context).primaryColorDark,
                        width: 20.w,
                        height: 20.w,
                      ),
                    ),
                  ),
                );
              });
            })
          ],
        ),
        AppSizing.kh20Spacer(),
        AppSizing.kh10Spacer(),
      ],
    );
  }
}
