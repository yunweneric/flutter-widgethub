const auth01Code = r"""

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Auth01Widget extends StatefulWidget {
  const Auth01Widget({super.key});

  @override
  State<Auth01Widget> createState() => _Auth01WidgetState();
}

class _Auth01WidgetState extends State<Auth01Widget> {
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static final ThemeData _customTheme = ThemeData(
    primaryColor: const Color(0xFF2563EB),
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    dividerColor: const Color(0xFFE5E7EB),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        height: 1.1,
      ),
      displayMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        color: Color(0xFF6B7280),
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        color: Color(0xFF6B7280),
      ),
      labelLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFFE5E7EB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color(0xFF2563EB)),
      ),
      hintStyle: TextStyle(color: Color(0xFF6B7280), fontSize: 15),
      labelStyle: TextStyle(color: Color(0xFF6B7280), fontSize: 15),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF2563EB),
        foregroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: Size.fromHeight(52),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: Color(0xFFE5E7EB)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: TextStyle(fontSize: 16, color: Colors.black),
        minimumSize: Size.fromHeight(52),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Color(0xFF2563EB),
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _customTheme,
      child: Scaffold(
        backgroundColor: _customTheme.scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: AppSizing.kpadding(24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppLogoWidget(),
                  AppSizing.khSpacer(40),
                  const AuthTitle(),
                  AppSizing.khSpacer(16),
                  const AuthSubtitle(),
                  AppSizing.khSpacer(32),
                  AuthEmailField(
                    controller: _emailController,
                    theme: _customTheme,
                  ),
                  AppSizing.khSpacer(20),
                  AuthPasswordField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    onToggleObscure: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    theme: _customTheme,
                  ),
                  AppSizing.khSpacer(8),
                  const ForgotPasswordButton(),
                  AppSizing.khSpacer(8),
                  const LoginButton(),
                  AppSizing.khSpacer(20),
                  const OrDivider(),
                  AppSizing.khSpacer(20),
                  const GoogleLoginButton(),
                  AppSizing.khSpacer(12),
                  const FacebookLoginButton(),
                  AppSizing.khSpacer(32),
                  const SignUpLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- Reusable Widgets ---

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return AppIcon.appLogo();
  }
}

class AuthTitle extends StatelessWidget {
  const AuthTitle({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'Sign in to your\nAccount',
      style: theme.textTheme.displayLarge,
    );
  }
}

class AuthSubtitle extends StatelessWidget {
  const AuthSubtitle({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'Enter your email and password to log in',
      style: theme.textTheme.bodyMedium,
    );
  }
}

class AuthEmailField extends StatelessWidget {
  final TextEditingController controller;
  final ThemeData theme;
  const AuthEmailField({
    super.key,
    required this.controller,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        AppSizing.khSpacer(8),
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Loisbecket@gmail.com',
          ),
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}

class AuthPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggleObscure;
  final ThemeData theme;
  const AuthPasswordField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.onToggleObscure,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        AppSizing.khSpacer(8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: '********',
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFF6B7280),
              ),
              onPressed: onToggleObscure,
            ),
          ),
        ),
      ],
    );
  }
}

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text('Forgot Password ?'),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('Log In'),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Or', style: theme.textTheme.bodySmall),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: AppIcon.googleLogo(),
        label: const Text('Continue with Google', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}

class FacebookLoginButton extends StatelessWidget {
  const FacebookLoginButton({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: AppIcon.facebookLogo(),
        label: const Text('Continue with Facebook', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}

class SignUpLink extends StatelessWidget {
  const SignUpLink({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: theme.textTheme.bodySmall,
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Sign Up',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

// --- AppIcon remains unchanged ---

class AppIcon {
  static SvgPicture googleLogo() {
    return SvgPicture.string(
      r'''<svg width="48" height="48" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
<g clip-path="url(#clip0_17_40)">
<path d="M23.9996 19.6363V28.9309H36.916C36.3488 31.9199 34.6468 34.4509 32.0941 36.1527L39.8831 42.1964C44.4213 38.0075 47.0395 31.8547 47.0395 24.5456C47.0395 22.8438 46.8868 21.2073 46.6031 19.6366L23.9996 19.6363Z" fill="#4285F4"/>
<path d="M10.5494 28.568L8.79263 29.9128L2.57434 34.7564C6.52342 42.589 14.6174 48 23.9991 48C30.4789 48 35.9116 45.8618 39.8826 42.1964L32.0936 36.1528C29.9554 37.5927 27.2281 38.4656 23.9991 38.4656C17.7591 38.4656 12.4575 34.2547 10.5592 28.5819L10.5494 28.568Z" fill="#34A853"/>
<path d="M2.57436 13.2436C0.938084 16.4726 0 20.1163 0 23.9999C0 27.8834 0.938084 31.5271 2.57436 34.7561C2.57436 34.7777 10.5599 28.5597 10.5599 28.5597C10.08 27.1197 9.79624 25.5925 9.79624 23.9996C9.79624 22.4067 10.08 20.8795 10.5599 19.4395L2.57436 13.2436Z" fill="#FBBC05"/>
<path d="M23.9996 9.55636C27.5342 9.55636 30.676 10.7781 33.1851 13.1345L40.0577 6.2619C35.8904 2.37833 30.4797 0 23.9996 0C14.6179 0 6.52342 5.38908 2.57434 13.2437L10.5597 19.44C12.4578 13.7672 17.7596 9.55636 23.9996 9.55636Z" fill="#EA4335"/>
</g>
<defs>
<clipPath id="clip0_17_40">
<rect width="48" height="48" fill="white"/>
</clipPath>
</defs>
</svg>
    ''',
      width: 24,
      height: 24,
    );
  }

  static SvgPicture facebookLogo() {
    return SvgPicture.string(
      r'''
<svg width="48" height="48" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
<g clip-path="url(#clip0_17_24)">
<path d="M48 24C48 10.7453 37.2547 0 24 0C10.7453 0 0 10.7453 0 24C0 35.255 7.74912 44.6995 18.2026 47.2934V31.3344H13.2538V24H18.2026V20.8397C18.2026 12.671 21.8995 8.8848 29.9194 8.8848C31.44 8.8848 34.0637 9.18336 35.137 9.48096V16.129C34.5706 16.0694 33.5866 16.0397 32.3645 16.0397C28.4294 16.0397 26.9088 17.5306 26.9088 21.4061V24H34.7482L33.4013 31.3344H26.9088V47.8243C38.7926 46.3891 48.001 36.2707 48.001 24H48Z" fill="#0866FF"/>
<path d="M33.4003 31.3344L34.7472 24H26.9078V21.4061C26.9078 17.5306 28.4285 16.0397 32.3635 16.0397C33.5856 16.0397 34.5696 16.0694 35.136 16.129V9.48096C34.0627 9.1824 31.439 8.8848 29.9184 8.8848C21.8986 8.8848 18.2016 12.671 18.2016 20.8397V24H13.2528V31.3344H18.2016V47.2934C20.0582 47.7542 22.0003 48 23.999 48C24.983 48 25.9536 47.9395 26.9069 47.8243V31.3344H33.3994H33.4003Z" fill="white"/>
</g>
<defs>
<clipPath id="clip0_17_24">
<rect width="48" height="48" fill="white"/>
</clipPath>
</defs>
</svg>

    ''',
      width: 24,
      height: 24,
    );
  }

  static SvgPicture appLogo() {
    return SvgPicture.string(
      r'''
<svg width="101" height="19" viewBox="0 0 101 19" fill="none" xmlns="http://www.w3.org/2000/svg">
<g clip-path="url(#clip0_3_16680)">
<path d="M9.18184 18.3636C14.253 18.3636 18.3637 14.2529 18.3637 9.18182V2.75455C18.3637 2.02399 18.0734 1.32337 17.5569 0.806788C17.0403 0.29021 16.3397 0 15.6091 0H9.64093V4.02806C9.64093 4.94716 9.69694 5.89932 10.179 6.68161C10.5241 7.24225 10.9857 7.72211 11.5326 8.08863C12.0795 8.45514 12.6988 8.69974 13.3485 8.80582L13.5244 8.83429C13.5969 8.85906 13.6598 8.90589 13.7044 8.9682C13.7489 9.03052 13.7729 9.10521 13.7729 9.18182C13.7729 9.25842 13.7489 9.33311 13.7044 9.39543C13.6598 9.45775 13.5969 9.50457 13.5244 9.52935L13.3485 9.55781C12.3992 9.71289 11.5226 10.1622 10.8424 10.8424C10.1623 11.5226 9.71291 12.3992 9.55784 13.3485L9.52937 13.5244C9.50459 13.5968 9.45777 13.6598 9.39545 13.7043C9.33314 13.7489 9.25845 13.7728 9.18184 13.7728C9.10523 13.7728 9.03054 13.7489 8.96823 13.7043C8.90591 13.6598 8.85909 13.5968 8.83431 13.5244L8.80584 13.3485C8.69973 12.6988 8.45513 12.0795 8.08861 11.5326C7.7221 10.9857 7.24226 10.5241 6.68163 10.179C5.89934 9.69692 4.94719 9.64091 4.02809 9.64091H0.0110402C0.251145 14.4985 4.26498 18.3636 9.18184 18.3636Z" fill="#375DFB"/>
<path d="M0 8.72278H4.02806C4.94716 8.72278 5.89932 8.66677 6.68161 8.18473C7.29313 7.80795 7.80789 7.29318 8.18467 6.68166C8.66672 5.89937 8.72273 4.94722 8.72273 4.02812V5.54865e-05H2.75455C2.02399 5.54865e-05 1.32337 0.290266 0.806788 0.806843C0.29021 1.32342 0 2.02405 0 2.7546V8.72278Z" fill="#375DFB"/>
<path d="M97.1946 5.55678C99.7613 5.55678 101 7.34953 101 9.42599V13.326H98.3138V9.88876C98.3138 8.94762 97.9704 8.17084 96.9857 8.17084C96.0009 8.17084 95.6727 8.94762 95.6727 9.88876V13.3255H92.9865V9.88876C92.9865 8.94762 92.6583 8.17084 91.6731 8.17084C90.6883 8.17084 90.3449 8.94762 90.3449 9.88876V13.3255H87.6592V9.42554C87.6592 7.34907 88.8974 5.55632 91.4642 5.55632C92.8672 5.55632 93.8818 6.10906 94.3445 7.02036C94.8367 6.10906 95.9114 5.55678 97.1946 5.55678ZM82.8324 10.9355C83.6978 10.9355 84.071 10.1436 84.071 9.20196V5.85519H86.7567V9.53067C86.7567 11.727 85.4735 13.55 82.8324 13.55C80.1908 13.55 78.9076 11.7274 78.9076 9.53067V5.85519H81.5937V9.20196C81.5937 10.1431 81.9665 10.9355 82.8324 10.9355ZM74.958 13.5647C73.2718 13.5647 72.1824 12.9821 71.5406 11.8468L73.4807 10.756C73.7493 11.2339 74.1519 11.4731 74.8235 11.4731C75.3758 11.4731 75.6292 11.2789 75.6292 11.0397C75.6292 10.1284 71.6898 11.0548 71.6898 8.15661C71.6898 6.75179 72.8834 5.61646 74.913 5.61646C76.6888 5.61646 77.6589 6.48276 78.0918 7.31969L76.1517 8.42518C75.9878 7.9771 75.48 7.70808 74.9727 7.70808C74.5848 7.70808 74.3759 7.87243 74.3759 8.09647C74.3759 9.02291 78.3154 8.1713 78.3154 10.98C78.3154 12.5487 76.7783 13.5647 74.958 13.5647ZM65.5733 16.7623H62.8872V9.57566C62.8872 7.28938 64.6032 5.63115 66.991 5.63115C69.319 5.63115 71.0948 7.40921 71.0948 9.57566C71.0948 11.9661 69.5128 13.55 67.1402 13.55C66.5879 13.55 66.0361 13.3857 65.5733 13.1313V16.7623ZM66.991 11.025C67.8417 11.025 68.4086 10.3676 68.4086 9.59035C68.4086 8.79888 67.8417 8.15615 66.991 8.15615C66.1403 8.15615 65.5733 8.79888 65.5733 9.59081C65.5733 10.3676 66.1403 11.025 66.991 11.025ZM60.1964 5.06371C59.3159 5.06371 58.585 4.33146 58.585 3.45001C58.585 2.56855 59.3159 1.8363 60.1964 1.8363C61.077 1.8363 61.8083 2.56855 61.8083 3.45001C61.8083 4.33146 61.077 5.06371 60.1964 5.06371ZM58.8536 5.85519H61.5397V13.326H58.8536V5.85519ZM53.6998 13.55C51.3718 13.55 49.596 11.7573 49.596 9.57566C49.596 7.40921 51.3718 5.61646 53.6998 5.61646C56.0279 5.61646 57.8036 7.40921 57.8036 9.57566C57.8036 11.7573 56.0279 13.55 53.6998 13.55ZM53.6998 11.025C54.5505 11.025 55.1175 10.3676 55.1175 9.59035C55.1175 8.79888 54.5505 8.14146 53.6998 8.14146C52.8491 8.14146 52.2822 8.79888 52.2822 9.59035C52.2822 10.3676 52.8491 11.025 53.6998 11.025ZM44.524 16.9863C42.6738 16.9863 41.3305 16.1645 40.6442 14.7L42.8676 13.505C43.1063 14.0132 43.5539 14.5361 44.479 14.5361C45.4495 14.5361 46.0909 13.9233 46.1657 12.8476C45.8076 13.1616 45.2402 13.4003 44.3899 13.4003C42.3153 13.4003 40.6437 11.8018 40.6437 9.56051C40.6437 7.39452 42.42 5.63115 44.748 5.63115C47.1357 5.63115 48.8518 7.28984 48.8518 9.57566V12.534C48.8518 15.2234 46.9861 16.9863 44.524 16.9863ZM44.703 10.8758C45.5087 10.8758 46.1207 10.3226 46.1207 9.50083C46.1207 8.6942 45.5092 8.15615 44.703 8.15615C43.912 8.15615 43.2854 8.6942 43.2854 9.50129C43.2854 10.3231 43.912 10.8758 44.703 10.8758ZM36.0877 13.55C33.7597 13.55 31.9835 11.7573 31.9835 9.57566C31.9835 7.40921 33.7597 5.61646 36.0877 5.61646C38.4153 5.61646 40.1915 7.40921 40.1915 9.57566C40.1915 11.7573 38.4158 13.55 36.0877 13.55ZM36.0877 11.025C36.9384 11.025 37.5054 10.3676 37.5054 9.59035C37.5054 8.79888 36.9384 8.14146 36.0877 8.14146C35.237 8.14146 34.6701 8.79888 34.6701 9.59035C34.6701 10.3676 35.237 11.025 36.0877 11.025ZM27.0923 3.24112V10.7858H31.5395V13.326H26.7191C25.0181 13.326 24.3318 12.4294 24.3318 11.0099V3.24112H27.0923Z" fill="#0E1534"/>
</g>
<defs>
<clipPath id="clip0_3_16680">
<rect width="101" height="18.3636" fill="white"/>
</clipPath>
</defs>
</svg>

    ''',
      width: 24,
      height: 24,
    );
  }
}

class AppSizing {
  static Widget khSpacer(double height) => SizedBox(height: height);
  static EdgeInsets kpadding(double width, double height) => EdgeInsets.symmetric(horizontal: width, vertical: height);
}


""";
