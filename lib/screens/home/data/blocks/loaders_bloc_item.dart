import 'package:flutter/material.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';

class LoadersBlocItem extends StatefulWidget {
  const LoadersBlocItem({super.key});

  @override
  State<LoadersBlocItem> createState() => _LoadersBlocItemState();
}

class _LoadersBlocItemState extends State<LoadersBlocItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: AppSizing.width(context),
            height: AppSizing.kHPercentage(context, 50),
            child: Transform.scale(
              scale: 2.5,
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
