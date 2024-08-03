import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:icons_flutter/icons_flutter.dart';

class DetailedFooter extends StatefulWidget {
  const DetailedFooter({super.key});

  @override
  State<DetailedFooter> createState() => _DetailedFooterState();
}

class _DetailedFooterState extends State<DetailedFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSizing.kpadding(0, 30.h),
      width: AppSizing.width(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Build with 💙 by yunwen"),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {},
                label: AppSizing.isMobile(context)
                    ? SizedBox.shrink()
                    : Text(
                        "LinkedIn",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                icon: Icon(
                  AntDesign.linkedin_square,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                label: AppSizing.isMobile(context)
                    ? SizedBox.shrink()
                    : Text(
                        "Twitter",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                icon: Icon(
                  AntDesign.twitter,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                label: AppSizing.isMobile(context)
                    ? SizedBox.shrink()
                    : Text(
                        "Github",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                icon: Icon(
                  AntDesign.github,
                  color: Theme.of(context).primaryColorDark,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
