import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: 32,
          color: widget.isActive ? Theme.of(context).primaryColor : Theme.of(context).dividerColor,
          width: 2.w,
        ),
        TextButton(
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
          child: Text(widget.title, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
