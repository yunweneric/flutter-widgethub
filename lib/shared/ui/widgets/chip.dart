import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';

class AppChip extends StatefulWidget {
  final Widget icon;
  final String? title;
  final bool? active;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;

  const AppChip({
    super.key,
    required this.icon,
    this.title,
    this.active,
    this.padding,
    this.onTap,
  });

  @override
  State<AppChip> createState() => _AppChipState();
}

class _AppChipState extends State<AppChip> {
  @override
  initState() {
    setState(() => isActive = widget.active ?? false);
    super.initState();
  }

  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      isActive = widget.active == null ? isActive : widget.active!;
      return ElevatedButton(
        onHover: (value) {
          setState(() => isActive = !isActive);
        },
        style: ElevatedButton.styleFrom(),
        onPressed: () {
          setState(() => isActive = !isActive);
          if (widget.onTap != null) widget.onTap!();
        },
        child: Row(
          children: [
            Transform.scale(
              scale: 0.75,
              child: widget.icon,
            ),
            if (widget.title != null) AppSizing.kwSpacer(2.w),
            if (widget.title != null)
              Text(
                widget.title!,
                style: TextStyle(color: isActive ? Theme.of(context).primaryColor : Theme.of(context).highlightColor),
              ),
          ],
        ),
      );
      Chip(
        iconTheme: Theme.of(context).iconTheme,
        padding: widget.padding ?? EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.h),
        backgroundColor: isActive ? Theme.of(context).cardColor : Theme.of(context).scaffoldBackgroundColor,
        label: Row(
          children: [
            Transform.scale(
              scale: 0.75,
              child: widget.icon,
            ),
            if (widget.title != null) AppSizing.kwSpacer(2.w),
            if (widget.title != null)
              Text(
                widget.title!,
                style: TextStyle(color: isActive ? Theme.of(context).primaryColorDark : Theme.of(context).highlightColor),
              ),
          ],
        ),
      );
    });
  }
}
