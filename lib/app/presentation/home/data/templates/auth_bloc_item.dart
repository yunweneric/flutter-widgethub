import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

class AuthBlocItem extends StatefulWidget {
  const AuthBlocItem({super.key});

  @override
  State<AuthBlocItem> createState() => _AuthsideBarCategoriestate();
}

class _AuthsideBarCategoriestate extends State<AuthBlocItem> {
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
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        hintText: "Email",
                      ),
                    ),
                    const Kh20Spacer(),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    const Kh20Spacer(),
                    ElevatedButton.icon(
                      iconAlignment: IconAlignment.end,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        fixedSize: Size.fromWidth(AppSizing.width(context)),
                      ),
                      onPressed: () {},
                      label: const Text("Login"),
                      icon: const AppIcon(icon: AppIcons.arrowForward),
                    ),
                  ],
                ),
              ),
              const Kh20Spacer(),
              const Kh10Spacer(),
              const Text("Or login with social"),
              const Kh10Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...icons.map((item) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppIcon(icon: item, size: 30),
                    );
                  })
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
