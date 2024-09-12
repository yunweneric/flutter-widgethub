import 'package:flutter/material.dart';
import 'package:flutterui/shared/presentation/utils/sizing.dart';

class LoadersBlocItem extends StatefulWidget {
  const LoadersBlocItem({super.key});

  @override
  State<LoadersBlocItem> createState() => _LoaderssideBarCategoriestate();
}

class _LoaderssideBarCategoriestate extends State<LoadersBlocItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
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
