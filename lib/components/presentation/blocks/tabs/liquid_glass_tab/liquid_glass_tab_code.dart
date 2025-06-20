const liquidGlassTabCode = """
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TileItem {
  final String title;
  final String icon;
  final Color color;

  TileItem({required this.title, required this.icon, required this.color});
}

class LiquidGlassTab extends StatefulWidget {
  const LiquidGlassTab({super.key});

  @override
  State<LiquidGlassTab> createState() => _LiquidGlassTabState();
}

class _LiquidGlassTabState extends State<LiquidGlassTab> {
  int activeIndex = 0;

  double textWidth = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage("https://images.unsplash.com/photo-1454391304352-2bf4678b1a7a?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
          // color: Colors.red,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizing.width(context) * 0.04),
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: AppSizing.width(context) * 0.02, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: AnimatedAlign(
                      curve: Curves.decelerate,
                      duration: const Duration(milliseconds: 300),
                      alignment: activeIndex == 0
                          ? Alignment.centerLeft
                          : activeIndex == 1
                              ? Alignment.topCenter
                              : Alignment.centerRight,
                      child: Container(
                        width: textWidth,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...items.map(
                        (item) {
                          final index = items.indexOf(item);
                          return LayoutBuilder(builder: (context, c) {
                            final textPainter = TextPainter(
                              text: TextSpan(
                                text: item.title,
                                style: const TextStyle(color: Colors.white),
                              ),
                              maxLines: 1,
                              textDirection: TextDirection.ltr,
                            )..layout();
                            final width = textPainter.size.width + AppSizing.width(context) * 0.12;
                            textWidth = width;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              width: textWidth,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () => setState(() {
                                  activeIndex = index;
                                  textWidth = width;
                                }),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: TweenAnimationBuilder<double>(
                                      key: ValueKey(activeIndex),
                                      duration: const Duration(milliseconds: 500),
                                      tween: Tween(begin: activeIndex == index ? 4.0 : 0.0, end: 0),
                                      builder: (context, value, child) {
                                        return ImageFiltered(
                                          imageFilter: ImageFilter.blur(sigmaX: value, sigmaY: value, tileMode: TileMode.decal),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.string(item.icon, height: 20, color: Colors.white),
                                              SizedBox(width: AppSizing.width(context) * 0.02),
                                              Text(
                                                item.title,
                                                softWrap: true,
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const user = '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
    xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_403_2799)">
        <path d="M12 11.9999C13.1867 11.9999 14.3467 11.648 15.3334 10.9888C16.3201 10.3295 17.0892 9.3924 17.5433 8.29604C17.9974 7.19969 18.1162 5.99329 17.8847 4.8294C17.6532 3.66551 17.0818 2.59642 16.2426 1.7573C15.4035 0.918186 14.3344 0.346741 13.1705 0.11523C12.0067 -0.116281 10.8003 0.00253868 9.7039 0.456664C8.60754 0.91079 7.67047 1.67983 7.01118 2.66652C6.35189 3.65321 6 4.81325 6 5.99994C6.00159 7.59075 6.63424 9.11595 7.75911 10.2408C8.88399 11.3657 10.4092 11.9984 12 11.9999ZM12 1.99994C12.7911 1.99994 13.5645 2.23454 14.2223 2.67406C14.8801 3.11359 15.3928 3.7383 15.6955 4.46921C15.9983 5.20011 16.0775 6.00438 15.9231 6.7803C15.7688 7.55623 15.3878 8.26896 14.8284 8.82837C14.269 9.38778 13.5563 9.76874 12.7804 9.92308C12.0044 10.0774 11.2002 9.99821 10.4693 9.69546C9.73836 9.39271 9.11365 8.88002 8.67412 8.22222C8.2346 7.56443 8 6.79107 8 5.99994C8 4.93908 8.42143 3.92166 9.17157 3.17151C9.92172 2.42137 10.9391 1.99994 12 1.99994Z" fill="#374957"/>
        <path d="M12 14.0006C9.61386 14.0033 7.32622 14.9523 5.63896 16.6396C3.95171 18.3268 3.00265 20.6145 3 23.0006C3 23.2658 3.10536 23.5202 3.29289 23.7077C3.48043 23.8953 3.73478 24.0006 4 24.0006C4.26522 24.0006 4.51957 23.8953 4.70711 23.7077C4.89464 23.5202 5 23.2658 5 23.0006C5 21.1441 5.7375 19.3636 7.05025 18.0509C8.36301 16.7381 10.1435 16.0006 12 16.0006C13.8565 16.0006 15.637 16.7381 16.9497 18.0509C18.2625 19.3636 19 21.1441 19 23.0006C19 23.2658 19.1054 23.5202 19.2929 23.7077C19.4804 23.8953 19.7348 24.0006 20 24.0006C20.2652 24.0006 20.5196 23.8953 20.7071 23.7077C20.8946 23.5202 21 23.2658 21 23.0006C20.9974 20.6145 20.0483 18.3268 18.361 16.6396C16.6738 14.9523 14.3861 14.0033 12 14.0006Z" fill="#374957"/>
    </g>
    <defs>
        <clipPath id="clip0_403_2799">
            <rect width="24" height="24" fill="white"/>
        </clipPath>
    </defs>
</svg>
    ''';

const chat = '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
    xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_403_3286)">
        <path d="M23.1189 0.882014C22.7604 0.519141 22.3144 0.254869 21.8239 0.11473C21.3334 -0.0254085 20.8151 -0.0366769 20.3189 0.0820139L4.31895 3.45201C3.39753 3.57838 2.52968 3.95949 1.81315 4.55243C1.09662 5.14536 0.559862 5.92657 0.263324 6.80808C-0.033214 7.68959 -0.0777536 8.63638 0.134721 9.54183C0.347196 10.4473 0.808246 11.2754 1.46595 11.933L3.18395 13.65C3.27693 13.743 3.35067 13.8534 3.40095 13.9748C3.45123 14.0963 3.47705 14.2265 3.47695 14.358V17.526C3.47916 17.9714 3.5817 18.4107 3.77695 18.811L3.76895 18.818L3.79495 18.844C4.08796 19.4331 4.56653 19.9096 5.15695 20.2L5.18295 20.226L5.18995 20.218C5.59031 20.4133 6.02952 20.5158 6.47495 20.518H9.64295C9.908 20.5178 10.1623 20.6228 10.3499 20.81L12.0669 22.527C12.5275 22.9926 13.0756 23.3625 13.6797 23.6153C14.2839 23.8681 14.9321 23.9989 15.5869 24C16.1327 23.9993 16.6747 23.9102 17.1919 23.736C18.0654 23.4492 18.8413 22.924 19.4322 22.2197C20.023 21.5154 20.4053 20.66 20.5359 19.75L23.9109 3.71501C24.0358 3.21465 24.0284 2.69043 23.8896 2.19378C23.7507 1.69712 23.4852 1.24508 23.1189 0.882014ZM4.59995 12.238L2.88095 10.521C2.48067 10.1304 2.20012 9.63366 2.07224 9.08917C1.94435 8.54468 1.97443 7.97501 2.15895 7.44701C2.33784 6.90534 2.66855 6.42644 3.11175 6.06728C3.55494 5.70811 4.09196 5.4838 4.65895 5.42101L20.4999 2.08601L5.47495 17.113V14.358C5.47646 13.9644 5.39991 13.5743 5.24972 13.2104C5.09953 12.8465 4.87868 12.516 4.59995 12.238ZM18.5709 19.408C18.4942 19.9604 18.265 20.4804 17.909 20.9097C17.5531 21.339 17.0846 21.6606 16.5561 21.8384C16.0275 22.0162 15.4599 22.0431 14.9169 21.9163C14.3739 21.7894 13.877 21.5136 13.4819 21.12L11.7619 19.4C11.4843 19.1209 11.1541 18.8995 10.7904 18.7488C10.4267 18.5981 10.0367 18.521 9.64295 18.522H6.88795L21.9149 3.50001L18.5709 19.408Z" fill="#374957"/>
    </g>
    <defs>
        <clipPath id="clip0_403_3286">
            <rect width="24" height="24" fill="white"/>
        </clipPath>
    </defs>
</svg>
    ''';

const cart = '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
    xmlns="http://www.w3.org/2000/svg">
    <g clip-path="url(#clip0_403_3492)">
        <path d="M24 3H4.242L4.2 2.649C4.11405 1.91942 3.76338 1.24673 3.21449 0.758478C2.6656 0.270223 1.95663 0.000341793 1.222 0L0 0V2H1.222C1.46693 2.00003 1.70334 2.08996 1.88637 2.25272C2.06941 2.41547 2.18634 2.63975 2.215 2.883L3.8 16.351C3.88595 17.0806 4.23662 17.7533 4.78551 18.2415C5.3344 18.7298 6.04337 18.9997 6.778 19H20V17H6.778C6.53291 16.9999 6.29638 16.9099 6.11333 16.7469C5.93027 16.5839 5.81343 16.3594 5.785 16.116L5.654 15H21.836L24 3ZM20.164 13H5.419L4.478 5H21.607L20.164 13Z" fill="#374957"/>
        <path d="M7.00012 24.0006C8.10469 24.0006 9.00011 23.1052 9.00011 22.0006C9.00011 20.896 8.10469 20.0006 7.00012 20.0006C5.89555 20.0006 5.00012 20.896 5.00012 22.0006C5.00012 23.1052 5.89555 24.0006 7.00012 24.0006Z" fill="#374957"/>
        <path d="M17 24.0006C18.1046 24.0006 19 23.1052 19 22.0006C19 20.896 18.1046 20.0006 17 20.0006C15.8954 20.0006 15 20.896 15 22.0006C15 23.1052 15.8954 24.0006 17 24.0006Z" fill="#374957"/>
    </g>
    <defs>
        <clipPath id="clip0_403_3492">
            <rect width="24" height="24" fill="white"/>
        </clipPath>
    </defs>
</svg>
    ''';

List<TileItem> items = [
  TileItem(title: "Primary", icon: user, color: Colors.blue),
  TileItem(title: "Transactions", icon: cart, color: Colors.green),
  TileItem(title: "Updates", icon: chat, color: Colors.deepPurple),
];

class AppSizing {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
}
""";
