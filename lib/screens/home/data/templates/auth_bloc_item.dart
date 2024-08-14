import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';

class AuthBlocItem extends StatefulWidget {
  const AuthBlocItem({super.key});

  @override
  State<AuthBlocItem> createState() => _AuthBlocItemState();
}

class _AuthBlocItemState extends State<AuthBlocItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        List<String> icons = [
          "assets/icons/google.svg",
          "assets/icons/tiktok.svg",
          "assets/icons/linkedin.svg",
          "assets/icons/youtube.svg",
          "assets/icons/spotify.svg",
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
                    AppSizing.kh20Spacer(),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: "Password",
                      ),
                    ),
                    AppSizing.kh20Spacer(),
                    ElevatedButton.icon(
                      iconAlignment: IconAlignment.end,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        fixedSize: Size.fromWidth(AppSizing.width(context)),
                      ),
                      onPressed: () {},
                      label: const Text("Login"),
                      icon: const Icon(Icons.arrow_forward_rounded),
                    ),
                  ],
                ),
              ),
              AppSizing.kh20Spacer(),
              AppSizing.kh10Spacer(),
              const Text("Or login with social"),
              AppSizing.kh10Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...icons.map((item) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipOval(child: SvgPicture.asset(item, width: 30)),
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
