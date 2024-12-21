import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';

class SideBarItem extends StatefulWidget {
  final String title;
  final bool isActive;
  final String? link;
  final void Function()? onPressed;
  const SideBarItem({super.key, required this.title, this.onPressed, this.link, required this.isActive});

  @override
  State<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends State<SideBarItem> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        border: BorderDirectional(
          start: BorderSide(
            width: 2.w,
            color: widget.isActive ? Theme.of(context).primaryColor : Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5.r),
              bottomRight: Radius.circular(5.r),
            ),
          ),
          alignment: Alignment.centerLeft,
        ),
        onPressed: widget.onPressed,
        child: Builder(builder: (context) {
          final name = LangUtil.trans("SubComponentCategoryEnum.${widget.title}");
          final formatted = name[0].toUpperCase() + name.split("_").join(" ").substring(1).toLowerCase();
          return Text(
            formatted,
            style: Theme.of(context).textTheme.bodyMedium,
          );
        }),
      ),
    );
  }
}
