import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Auth03Theme {
  // Colors
  static const Color backgroundStart = Color.fromARGB(255, 0, 0, 0);
  static const Color backgroundEnd = Color(0xFF23273E);
  static const Color card = Colors.white;
  static const Color primaryButton = Color(0xFF2563EB);
  static const Color accent = Color(0xFF6C7AFA);
  static const Color dividerColor = Color(0xFFE5E7EB);
  static const Color inputBorder = Color(0xFFE5E7EB);
  static const Color inputHint = Color(0xFFB0B3C7);
  static const Color textDark = Color(0xFF181C2E);
  static const Color textLight = Colors.white;
  static const Color textGray = Color(0xFF6B7280);
  static const Color checkboxActive = Color(0xFF2563EB);
  static const Color googleRed = Color(0xFFEA4335);
  static const Color facebookBlue = Color(0xFF1877F3);

  // Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [backgroundStart, backgroundEnd],
    // begin: Alignment.topCenter,
    // end: Alignment.bottomCenter,
  );

  // Text Styles
  static const TextStyle logo = TextStyle(
    color: textLight,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  static const TextStyle title = TextStyle(
    color: textLight,
    fontWeight: FontWeight.bold,
    fontSize: 32,
    height: 1.1,
  );
  static const TextStyle subtitle = TextStyle(
    color: Colors.white70,
    fontSize: 14,
  );
  static const TextStyle link = TextStyle(
    color: accent,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  static const TextStyle label = TextStyle(
    fontWeight: FontWeight.w500,
    color: textDark,
  );
  static const TextStyle input = TextStyle(
    color: textDark,
    fontSize: 16,
  );
  static const TextStyle inputHintStyle = TextStyle(
    color: inputHint,
    fontSize: 16,
  );
  static const TextStyle button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textLight,
  );
  static const TextStyle divider = TextStyle(
    color: Colors.black54,
    fontSize: 14,
  );
  static const TextStyle terms = TextStyle(
    color: Colors.black54,
    fontSize: 13,
  );
  static const TextStyle termsBold = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 13,
  );
}

/// Authentication screen variant 3 with gradient background and modern design.
///
/// API Reference:
/// - No public properties (uses internal state)
///
/// Usage:
/// ```dart
/// Auth03Widget()
/// ```
class Auth03Widget extends StatefulWidget {
  const Auth03Widget({Key? key}) : super(key: key);

  @override
  State<Auth03Widget> createState() => _Auth03WidgetState();
}

class _Auth03WidgetState extends State<Auth03Widget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Auth03Theme.card,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Auth03Header(),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Auth03InputField(
                    label: 'Email',
                    controller: _emailController,
                    hintText: 'Loisbecket@gmail.com',
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  _Auth03InputField(
                    label: 'Password',
                    controller: _passwordController,
                    hintText: '********',
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Auth03Theme.inputHint,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  _Auth03RememberForgotRow(
                    rememberMe: _rememberMe,
                    onRememberMeChanged: (val) {
                      setState(() {
                        _rememberMe = val ?? false;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  _Auth03LoginButton(onPressed: () {}),
                  const SizedBox(height: 20),
                  const _Auth03DividerWithText(),
                  const SizedBox(height: 20),
                  const _Auth03SocialButtonsRow(),
                  const SizedBox(height: 32),
                  const _Auth03TermsText(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Header Section
class _Auth03Header extends StatelessWidget {
  const _Auth03Header();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: AppSizing.kwidth(context),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: const BoxDecoration(gradient: Auth03Theme.backgroundGradient),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppIcons.logo(),
                const SizedBox(height: 32),
                const Text('Sign in to your', style: Auth03Theme.title),
                const Text('Account', style: Auth03Theme.title),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text("Don't have an account? ", style: Auth03Theme.subtitle),
                    GestureDetector(
                      onTap: () {},
                      child: const Text('Sign Up', style: Auth03Theme.link),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(top: 0, child: AppIcons.grid()),
      ],
    );
  }
}

// Input Field
class _Auth03InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;

  const _Auth03InputField({
    required this.label,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Auth03Theme.label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: label == 'Email' ? TextInputType.emailAddress : TextInputType.text,
          style: Auth03Theme.input,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Auth03Theme.inputHintStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Auth03Theme.inputBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Auth03Theme.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Auth03Theme.primaryButton, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

// Remember Me and Forgot Password Row
class _Auth03RememberForgotRow extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;

  const _Auth03RememberForgotRow({
    required this.rememberMe,
    required this.onRememberMeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: rememberMe,
          onChanged: onRememberMeChanged,
          activeColor: Auth03Theme.checkboxActive,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text('Remember me', style: TextStyle(color: Auth03Theme.textGray)),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: const Text('Forgot Password ?', style: Auth03Theme.link),
        ),
      ],
    );
  }
}

// Login Button
class _Auth03LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _Auth03LoginButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Auth03Theme.primaryButton,
          elevation: 0,
        ),
        child: const Text('Log In', style: Auth03Theme.button),
      ),
    );
  }
}

// Divider with Text
class _Auth03DividerWithText extends StatelessWidget {
  const _Auth03DividerWithText();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('Or login with', style: Auth03Theme.divider),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}

// Social Buttons Row
class _Auth03SocialButtonsRow extends StatelessWidget {
  const _Auth03SocialButtonsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: AppIcons.googleLogo(),
            label: const Text('Google', style: TextStyle(color: Auth03Theme.textDark)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Auth03Theme.dividerColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: AppIcons.facebookLogo(),
            label: const Text('Facebook', style: TextStyle(color: Auth03Theme.textDark)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Auth03Theme.dividerColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

// Terms and Conditions Text
class _Auth03TermsText extends StatelessWidget {
  const _Auth03TermsText();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: Auth03Theme.terms,
          children: [
            TextSpan(text: 'By signing up, you agree to the '),
            TextSpan(
              text: 'Terms of Service',
              style: Auth03Theme.termsBold,
            ),
            TextSpan(text: ' and '),
            TextSpan(
              text: 'Data Processing Agreement',
              style: Auth03Theme.termsBold,
            ),
          ],
        ),
      ),
    );
  }
}

class AppIcons {
  /// App logo
  static Widget logo({double width = 24, double height = 24}) {
    return SvgPicture.string(
      '''<svg width="99" height="18" viewBox="0 0 99 18" fill="none" xmlns="http://www.w3.org/2000/svg">
<g clip-path="url(#clip0_20_812)">
<path d="M9.00002 18C13.9707 18 18 13.9707 18 9V2.7C18 1.98392 17.7156 1.29716 17.2092 0.790812C16.7029 0.284463 16.0161 0 15.3 0H9.45002V3.9483C9.45002 4.8492 9.50492 5.7825 9.97742 6.5493C10.3157 7.09884 10.7682 7.5692 11.3042 7.92846C11.8403 8.28772 12.4474 8.52747 13.0842 8.63145L13.2566 8.65935C13.3276 8.68364 13.3893 8.72953 13.433 8.79062C13.4767 8.8517 13.5001 8.92491 13.5001 9C13.5001 9.07509 13.4767 9.1483 13.433 9.20938C13.3893 9.27046 13.3276 9.31636 13.2566 9.34065L13.0842 9.36855C12.1537 9.52056 11.2944 9.961 10.6277 10.6277C9.96103 11.2944 9.52058 12.1537 9.36857 13.0842L9.34067 13.2565C9.31639 13.3276 9.27049 13.3893 9.20941 13.433C9.14832 13.4766 9.07511 13.5001 9.00002 13.5001C8.92493 13.5001 8.85172 13.4766 8.79064 13.433C8.72956 13.3893 8.68366 13.3276 8.65937 13.2565L8.63147 13.0842C8.52746 12.4473 8.2877 11.8403 7.92844 11.3042C7.56919 10.7682 7.09885 10.3157 6.54932 9.9774C5.78252 9.5049 4.84922 9.45 3.94832 9.45H0.0108215C0.246172 14.2114 4.18052 18 9.00002 18Z" fill="#375DFB"/>
<path d="M0 8.55005H3.9483C4.8492 8.55005 5.7825 8.49515 6.5493 8.02265C7.14871 7.65334 7.65328 7.14876 8.0226 6.54935C8.4951 5.78255 8.55 4.84925 8.55 3.94835V5.43878e-05H2.7C1.98392 5.43878e-05 1.29716 0.284518 0.790812 0.790866C0.284463 1.29721 0 1.98397 0 2.70005V8.55005Z" fill="#375DFB"/>
<path d="M95.27 5.44685C97.7859 5.44685 99 7.2041 99 9.23945V13.0622H96.3671V9.69305C96.3671 8.77055 96.0305 8.00915 95.0652 8.00915C94.1 8.00915 93.7782 8.77055 93.7782 9.69305V13.0617H91.1453V9.69305C91.1453 8.77055 90.8235 8.00915 89.8578 8.00915C88.8926 8.00915 88.556 8.77055 88.556 9.69305V13.0617H85.9235V9.239C85.9235 7.20365 87.1371 5.4464 89.6531 5.4464C91.0283 5.4464 92.0228 5.9882 92.4764 6.88145C92.9588 5.9882 94.0122 5.44685 95.27 5.44685ZM81.1922 10.719C82.0404 10.719 82.4063 9.9428 82.4063 9.01985V5.73935H85.0388V9.34205C85.0388 11.4948 83.781 13.2818 81.1922 13.2818C78.6029 13.2818 77.3451 11.4953 77.3451 9.34205V5.73935H79.9781V9.01985C79.9781 9.94235 80.3435 10.719 81.1922 10.719ZM73.4738 13.2962C71.8209 13.2962 70.7531 12.7251 70.124 11.6123L72.0257 10.5431C72.2889 11.0115 72.6836 11.246 73.3419 11.246C73.8833 11.246 74.1317 11.0556 74.1317 10.8212C74.1317 9.92795 70.2702 10.836 70.2702 7.9952C70.2702 6.6182 71.4402 5.50535 73.4297 5.50535C75.1703 5.50535 76.1211 6.3545 76.5455 7.17485L74.6438 8.25845C74.4831 7.81925 73.9854 7.55555 73.4882 7.55555C73.1079 7.55555 72.9032 7.71665 72.9032 7.93625C72.9032 8.84435 76.7646 8.0096 76.7646 10.7627C76.7646 12.3003 75.258 13.2962 73.4738 13.2962ZM64.2749 16.4304H61.6419V9.38615C61.6419 7.14515 63.324 5.51975 65.6645 5.51975C67.9464 5.51975 69.687 7.2626 69.687 9.38615C69.687 11.7293 68.1363 13.2818 65.8107 13.2818C65.2694 13.2818 64.7285 13.1207 64.2749 12.8714V16.4304ZM65.6645 10.8068C66.4983 10.8068 67.0541 10.1624 67.0541 9.40055C67.0541 8.62475 66.4983 7.99475 65.6645 7.99475C64.8306 7.99475 64.2749 8.62475 64.2749 9.401C64.2749 10.1624 64.8306 10.8068 65.6645 10.8068ZM59.0045 4.96355C58.1414 4.96355 57.425 4.2458 57.425 3.3818C57.425 2.5178 58.1414 1.80005 59.0045 1.80005C59.8676 1.80005 60.5844 2.5178 60.5844 3.3818C60.5844 4.2458 59.8676 4.96355 59.0045 4.96355ZM57.6882 5.73935H60.3212V13.0622H57.6882V5.73935ZM52.6365 13.2818C50.3546 13.2818 48.614 11.5245 48.614 9.38615C48.614 7.2626 50.3546 5.50535 52.6365 5.50535C54.9185 5.50535 56.6591 7.2626 56.6591 9.38615C56.6591 11.5245 54.9185 13.2818 52.6365 13.2818ZM52.6365 10.8068C53.4704 10.8068 54.0261 10.1624 54.0261 9.40055C54.0261 8.62475 53.4704 7.98035 52.6365 7.98035C51.8027 7.98035 51.2469 8.62475 51.2469 9.40055C51.2469 10.1624 51.8027 10.8068 52.6365 10.8068ZM43.6424 16.65C41.8289 16.65 40.5122 15.8445 39.8394 14.409L42.0188 13.2377C42.2528 13.7358 42.6915 14.2484 43.5983 14.2484C44.5496 14.2484 45.1782 13.6476 45.2516 12.5933C44.9006 12.9011 44.3444 13.1351 43.511 13.1351C41.4774 13.1351 39.839 11.5682 39.839 9.3713C39.839 7.2482 41.58 5.51975 43.862 5.51975C46.2024 5.51975 47.8845 7.1456 47.8845 9.38615V12.2859C47.8845 14.922 46.0557 16.65 43.6424 16.65ZM43.8179 10.6605C44.6076 10.6605 45.2075 10.1183 45.2075 9.3128C45.2075 8.52215 44.6081 7.99475 43.8179 7.99475C43.0425 7.99475 42.4283 8.52215 42.4283 9.31325C42.4283 10.1187 43.0425 10.6605 43.8179 10.6605ZM35.3732 13.2818C33.0912 13.2818 31.3502 11.5245 31.3502 9.38615C31.3502 7.2626 33.0912 5.50535 35.3732 5.50535C37.6547 5.50535 39.3957 7.2626 39.3957 9.38615C39.3957 11.5245 37.6551 13.2818 35.3732 13.2818ZM35.3732 10.8068C36.207 10.8068 36.7628 10.1624 36.7628 9.40055C36.7628 8.62475 36.207 7.98035 35.3732 7.98035C34.5393 7.98035 33.9836 8.62475 33.9836 9.40055C33.9836 10.1624 34.5393 10.8068 35.3732 10.8068ZM26.5559 3.17705V10.5723H30.915V13.0622H26.19C24.5228 13.0622 23.85 12.1833 23.85 10.7919V3.17705H26.5559Z" fill="#EEEEEE"/>
</g>
<defs>
<clipPath id="clip0_20_812">
<rect width="99" height="18" fill="white"/>
</clipPath>
</defs>
</svg>
''',
      width: width,
      height: height,
    );
  }

  static Widget googleLogo({double width = 24, double height = 24}) {
    return SvgPicture.string(
      '''<svg width="$width" height="$height" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg"><g clip-path="url(#clip0_17_40)"><path d="M23.9996 19.6363V28.9309H36.916C36.3488 31.9199 34.6468 34.4509 32.0941 36.1527L39.8831 42.1964C44.4213 38.0075 47.0395 31.8547 47.0395 24.5456C47.0395 22.8438 46.8868 21.2073 46.6031 19.6366L23.9996 19.6363Z" fill="#4285F4"/><path d="M10.5494 28.568L8.79263 29.9128L2.57434 34.7564C6.52342 42.589 14.6174 48 23.9991 48C30.4789 48 35.9116 45.8618 39.8826 42.1964L32.0936 36.1528C29.9554 37.5927 27.2281 38.4656 23.9991 38.4656C17.7591 38.4656 12.4575 34.2547 10.5592 28.5819L10.5494 28.568Z" fill="#34A853"/><path d="M2.57436 13.2436C0.938084 16.4726 0 20.1163 0 23.9999C0 27.8834 0.938084 31.5271 2.57436 34.7561C2.57436 34.7777 10.5599 28.5597 10.5599 28.5597C10.08 27.1197 9.79624 25.5925 9.79624 23.9996C9.79624 22.4067 10.08 20.8795 10.5599 19.4395L2.57436 13.2436Z" fill="#FBBC05"/><path d="M23.9996 9.55636C27.5342 9.55636 30.676 10.7781 33.1851 13.1345L40.0577 6.2619C35.8904 2.37833 30.4797 0 23.9996 0C14.6179 0 6.52342 5.38908 2.57434 13.2437L10.5597 19.44C12.4578 13.7672 17.7596 9.55636 23.9996 9.55636Z" fill="#EA4335"/></g><defs><clipPath id="clip0_17_40"><rect width="48" height="48" fill="white"/></clipPath></defs></svg>''',
      width: width,
      height: height,
    );
  }

  /// Facebook logo
  static Widget facebookLogo({double width = 24, double height = 24}) {
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
      width: width,
      height: height,
    );
  }

  /// Grid logo
  static Widget grid() {
    return SvgPicture.string(
      r'''<svg width="375" height="387" viewBox="0 0 375 387" fill="none" xmlns="http://www.w3.org/2000/svg">
<g clip-path="url(#clip0_23_2416)">
<g opacity="0.9">
<circle cx="316.617" cy="273.363" r="0.699952" fill="white" fill-opacity="0.5"/>
<circle cx="72.2971" cy="198.941" r="0.866106" fill="white" fill-opacity="0.3"/>
<circle cx="5.7695" cy="222.393" r="0.639683" fill="white" fill-opacity="0.6"/>
<circle cx="148.496" cy="333.745" r="0.700234" fill="white" fill-opacity="0.4"/>
<circle cx="343.985" cy="295.996" r="0.837128" fill="white" fill-opacity="0.5"/>
<circle cx="1.60862" cy="161.994" r="0.621616" fill="white" fill-opacity="0.6"/>
<circle cx="17.7882" cy="377.67" r="0.818832" fill="white" fill-opacity="0.4"/>
<circle cx="133.096" cy="93.3931" r="0.690477" fill="white" fill-opacity="0.6"/>
<circle cx="12.4038" cy="43.739" r="0.76211" fill="white" fill-opacity="0.5"/>
<circle cx="180.993" cy="285.733" r="0.637879" fill="white" fill-opacity="0.5"/>
<circle cx="259.685" cy="262.013" r="0.596974" fill="white" fill-opacity="0.3"/>
<circle cx="228.999" cy="378.729" r="0.694188" fill="white" fill-opacity="0.5"/>
<circle cx="69.168" cy="36.5704" r="0.69691" fill="white" fill-opacity="0.5"/>
<circle cx="30.1798" cy="374.67" r="0.778728" fill="white" fill-opacity="0.3"/>
<circle cx="236.885" cy="327.416" r="0.882725" fill="white" fill-opacity="0.4"/>
<circle cx="262.168" cy="95.1906" r="0.711451" fill="white" fill-opacity="0.6"/>
<circle cx="4.82303" cy="242.757" r="0.876195" fill="white" fill-opacity="0.5"/>
<circle cx="313.122" cy="386.487" r="0.756572" fill="white" fill-opacity="0.3"/>
<circle cx="122.443" cy="108.196" r="0.693902" fill="white" fill-opacity="0.3"/>
<circle cx="372.827" cy="56.672" r="0.671636" fill="white" fill-opacity="0.5"/>
<circle cx="1.12285" cy="21.8032" r="0.729233" fill="white" fill-opacity="0.4"/>
<circle cx="227.811" cy="89.2495" r="0.689881" fill="white" fill-opacity="0.5"/>
<circle cx="132.578" cy="145.562" r="0.765212" fill="white" fill-opacity="0.4"/>
<circle cx="111.963" cy="384.825" r="0.869681" fill="white" fill-opacity="0.6"/>
<circle cx="205.936" cy="71.5181" r="0.718168" fill="white" fill-opacity="0.6"/>
<circle cx="47.4151" cy="351.651" r="0.84679" fill="white" fill-opacity="0.4"/>
<circle cx="75.6115" cy="307.034" r="0.627863" fill="white" fill-opacity="0.4"/>
<circle cx="77.4745" cy="318.37" r="0.715796" fill="white" fill-opacity="0.3"/>
<circle cx="301.379" cy="247.469" r="0.852779" fill="white" fill-opacity="0.6"/>
<circle cx="158.522" cy="313.579" r="0.661517" fill="white" fill-opacity="0.3"/>
<circle cx="42.6912" cy="342.783" r="0.859218" fill="white" fill-opacity="0.6"/>
<circle cx="186.971" cy="221.267" r="0.696622" fill="white" fill-opacity="0.3"/>
<circle cx="354.043" cy="110.11" r="0.831583" fill="white" fill-opacity="0.4"/>
<circle cx="29.6136" cy="176.384" r="0.80469" fill="white" fill-opacity="0.5"/>
<circle cx="50.9692" cy="228.523" r="0.848888" fill="white" fill-opacity="0.4"/>
<circle cx="230.884" cy="322.601" r="0.803339" fill="white" fill-opacity="0.3"/>
<circle cx="35.466" cy="1.68301" r="0.735984" fill="white" fill-opacity="0.4"/>
<circle cx="358.754" cy="184.673" r="0.806592" fill="white" fill-opacity="0.4"/>
<circle cx="77.5631" cy="81.0759" r="0.804401" fill="white" fill-opacity="0.4"/>
<circle cx="307.897" cy="243.924" r="0.859109" fill="white" fill-opacity="0.5"/>
<circle cx="353.292" cy="19.9694" r="0.671462" fill="white" fill-opacity="0.6"/>
<circle cx="16.0543" cy="33.1817" r="0.859953" fill="white" fill-opacity="0.6"/>
<circle cx="109.965" cy="264.432" r="0.647362" fill="white" fill-opacity="0.3"/>
<circle cx="242.772" cy="50.9322" r="0.85128" fill="white" fill-opacity="0.6"/>
<circle cx="120.095" cy="258.578" r="0.713183" fill="white" fill-opacity="0.5"/>
<circle cx="270.557" cy="216.647" r="0.813803" fill="white" fill-opacity="0.3"/>
<circle cx="228.498" cy="385.332" r="0.785658" fill="white" fill-opacity="0.4"/>
<circle cx="348.076" cy="31.33" r="0.784446" fill="white" fill-opacity="0.3"/>
<circle cx="285.221" cy="68.5186" r="0.678364" fill="white" fill-opacity="0.4"/>
<circle cx="129.655" cy="209.532" r="0.802016" fill="white" fill-opacity="0.4"/>
<circle cx="55.6198" cy="204.757" r="0.763236" fill="white" fill-opacity="0.4"/>
<circle cx="272.369" cy="370.004" r="0.849438" fill="white" fill-opacity="0.5"/>
<circle cx="304.715" cy="378.672" r="0.636609" fill="white" fill-opacity="0.5"/>
<circle cx="244.373" cy="77.9881" r="0.676482" fill="white" fill-opacity="0.6"/>
<circle cx="160.284" cy="9.29093" r="0.648472" fill="white" fill-opacity="0.4"/>
<circle cx="247.356" cy="243.764" r="0.698949" fill="white" fill-opacity="0.6"/>
<circle cx="225.008" cy="306.068" r="0.846621" fill="white" fill-opacity="0.6"/>
<circle cx="7.61861" cy="212.402" r="0.711873" fill="white" fill-opacity="0.5"/>
<circle cx="325.601" cy="56.2131" r="0.804688" fill="white" fill-opacity="0.5"/>
<circle cx="119.592" cy="117.185" r="0.803196" fill="white" fill-opacity="0.5"/>
<circle cx="155.784" cy="50.3719" r="0.883131" fill="white" fill-opacity="0.5"/>
<circle cx="171.61" cy="93.4297" r="0.727048" fill="white" fill-opacity="0.6"/>
<circle cx="113.102" cy="246.848" r="0.82322" fill="white" fill-opacity="0.4"/>
<circle cx="102.969" cy="50.2436" r="0.754837" fill="white" fill-opacity="0.5"/>
<circle cx="163.256" cy="331.337" r="0.660223" fill="white" fill-opacity="0.5"/>
<circle cx="26.463" cy="94.5008" r="0.614002" fill="white" fill-opacity="0.4"/>
<circle cx="196.444" cy="259.746" r="0.69723" fill="white" fill-opacity="0.6"/>
<circle cx="180.561" cy="24.2402" r="0.798039" fill="white" fill-opacity="0.6"/>
<circle cx="96.5512" cy="52.7056" r="0.848304" fill="white" fill-opacity="0.5"/>
<circle cx="196.951" cy="253.741" r="0.613189" fill="white" fill-opacity="0.3"/>
<circle cx="96.4488" cy="306.56" r="0.745889" fill="white" fill-opacity="0.4"/>
<circle cx="53.8999" cy="297.162" r="0.819658" fill="white" fill-opacity="0.6"/>
<circle cx="288.733" cy="50.7188" r="0.637861" fill="white" fill-opacity="0.5"/>
<circle cx="344.967" cy="336.048" r="0.634724" fill="white" fill-opacity="0.6"/>
<circle cx="179.299" cy="57.9041" r="0.719579" fill="white" fill-opacity="0.5"/>
<circle cx="251.413" cy="292.22" r="0.613337" fill="white" fill-opacity="0.4"/>
<circle cx="266.43" cy="130.828" r="0.830232" fill="white" fill-opacity="0.4"/>
<circle cx="57.9969" cy="68.0218" r="0.773981" fill="white" fill-opacity="0.3"/>
<circle cx="77.3734" cy="2.15354" r="0.614725" fill="white" fill-opacity="0.3"/>
<circle cx="120.202" cy="69.2526" r="0.820446" fill="white" fill-opacity="0.5"/>
<circle cx="179.217" cy="323.62" r="0.638211" fill="white" fill-opacity="0.5"/>
<circle cx="196.505" cy="314.268" r="0.758062" fill="white" fill-opacity="0.4"/>
<circle cx="52.076" cy="102.946" r="0.771508" fill="white" fill-opacity="0.3"/>
<circle cx="245.023" cy="154.412" r="0.734636" fill="white" fill-opacity="0.5"/>
<circle cx="214.834" cy="327.863" r="0.737588" fill="white" fill-opacity="0.4"/>
<circle cx="125.993" cy="94.579" r="0.692114" fill="white" fill-opacity="0.5"/>
</g>
<g opacity="0.1">
<g clip-path="url(#clip1_23_2416)">
<path d="M19.9103 -84.1694V778.817" stroke="white" stroke-width="0.654481"/>
<path d="M61.7971 -84.1694V778.817" stroke="white" stroke-width="0.654481"/>
<path d="M103.684 -84.1694V778.817" stroke="white" stroke-width="0.654481"/>
<path d="M145.571 -84.1694V778.817" stroke="white" stroke-width="0.654481"/>
<path d="M187.457 -84.1694V778.817" stroke="white" stroke-width="0.654481"/>
<path d="M229.344 -84.1694V778.817" stroke="white" stroke-width="0.654481"/>
<path d="M271.231 -84.1694V778.817" stroke="white" stroke-width="0.654481"/>
<path d="M313.118 -84.1694V778.817" stroke="white" stroke-width="0.654481"/>
<path d="M355.005 -84.1694V778.817" stroke="white" stroke-width="0.654481"/>
</g>
<g clip-path="url(#clip2_23_2416)">
<path d="M-315.184 41.4908L933 41.4908" stroke="white" stroke-width="0.654481"/>
<path d="M-315.184 83.3776L933 83.3776" stroke="white" stroke-width="0.654481"/>
<path d="M-315.184 125.264L933 125.264" stroke="white" stroke-width="0.654481"/>
<path d="M-315.184 167.151L933 167.151" stroke="white" stroke-width="0.654481"/>
<path d="M-315.184 209.038L933 209.038" stroke="white" stroke-width="0.654481"/>
<path d="M-315.184 250.925L933 250.925" stroke="white" stroke-width="0.654481"/>
<path d="M-315.184 292.811L933 292.811" stroke="white" stroke-width="0.654481"/>
<path d="M-315.184 334.698L933 334.698" stroke="white" stroke-width="0.654481"/>
<path d="M-315.184 376.585L933 376.585" stroke="white" stroke-width="0.654481"/>
</g>
</g>
</g>
<defs>
<clipPath id="clip0_23_2416">
<rect width="376" height="394" fill="white" transform="translate(-1 -7)"/>
</clipPath>
<clipPath id="clip1_23_2416">
<rect width="1248.18" height="806.841" fill="white" transform="translate(-315.184 -84.1694)"/>
</clipPath>
<clipPath id="clip2_23_2416">
<rect width="1248.18" height="806.841" fill="white" transform="translate(-315.184 -84.1694)"/>
</clipPath>
</defs>
</svg>
      ''',
    );
  }
}

class AppSizing {
  static double kwidth(BuildContext context) => MediaQuery.sizeOf(context).width;
  static double kheight(BuildContext context) => MediaQuery.sizeOf(context).height;
  static Widget khSpacer(double height) => SizedBox(height: height);
  static Widget kwSpacer(double width) => SizedBox(width: width);
  static EdgeInsets kpadding(double width, double height) => EdgeInsets.symmetric(horizontal: width, vertical: height);
}
