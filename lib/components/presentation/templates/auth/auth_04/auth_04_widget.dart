import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Auth04Theme {
  static const Color background = Colors.white;
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
  static const Color appleBlack = Color(0xFF000000);
  static const Color phoneGray = Color(0xFF6B7280);

  static const TextStyle logo = TextStyle(
    color: primaryButton,
    fontWeight: FontWeight.bold,
    fontSize: 32,
  );
  static const TextStyle title = TextStyle(
    color: textDark,
    fontWeight: FontWeight.bold,
    fontSize: 28,
  );
  static const TextStyle subtitle = TextStyle(
    color: textGray,
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle label = TextStyle(
    fontWeight: FontWeight.w500,
    color: textDark,
    fontSize: 15,
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
  static const TextStyle link = TextStyle(
    color: accent,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
}

class Auth04Widget extends StatefulWidget {
  const Auth04Widget({Key? key}) : super(key: key);

  @override
  State<Auth04Widget> createState() => _Auth04WidgetState();
}

class _Auth04WidgetState extends State<Auth04Widget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  int _selectedTab = 0; // 0 = Log In, 1 = Sign Up

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Auth04Theme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Auth04Header(),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Auth04SegmentedControl(
                      selectedIndex: _selectedTab,
                      onChanged: (i) => setState(() => _selectedTab = i),
                    ),
                    const SizedBox(height: 24),
                    _Auth04InputField(
                      label: 'Email',
                      controller: _emailController,
                      hintText: 'Loisbecket@gmail.com',
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    _Auth04InputField(
                      label: 'Password',
                      controller: _passwordController,
                      hintText: '********',
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Auth04Theme.inputHint,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    _Auth04RememberForgotRow(
                      rememberMe: _rememberMe,
                      onRememberMeChanged: (val) {
                        setState(() => _rememberMe = val ?? false);
                      },
                    ),
                    const SizedBox(height: 16),
                    _Auth04LoginButton(onPressed: () {}),
                    const SizedBox(height: 20),
                    const _Auth04DividerWithText(),
                    const SizedBox(height: 20),
                    const _Auth04SocialButtonsRow(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Auth04Header extends StatelessWidget {
  const _Auth04Header();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top: 0, left: 30, child: AppIcons.grid()),
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 30, right: 30, bottom: 0),
          child: Column(
            children: [
              AppIcons.logo(width: 48, height: 48),
              const SizedBox(height: 32),
              const Text('Get Started now', style: Auth04Theme.title, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              const Text(
                'Create an account or log in to explore about our app',
                style: Auth04Theme.subtitle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Auth04SegmentedControl extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  const _Auth04SegmentedControl({required this.selectedIndex, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _Auth04SegmentedTab(
            text: 'Log In',
            selected: selectedIndex == 0,
            onTap: () => onChanged(0),
          ),
          _Auth04SegmentedTab(
            text: 'Sign Up',
            selected: selectedIndex == 1,
            onTap: () => onChanged(1),
          ),
        ],
      ),
    );
  }
}

class _Auth04SegmentedTab extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;
  const _Auth04SegmentedTab({required this.text, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: selected ? Auth04Theme.primaryButton : Auth04Theme.textGray,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class _Auth04InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  const _Auth04InputField({
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
        Text(label, style: Auth04Theme.label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: label == 'Email' ? TextInputType.emailAddress : TextInputType.text,
          style: Auth04Theme.input,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Auth04Theme.inputHintStyle,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Auth04Theme.inputBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Auth04Theme.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Auth04Theme.primaryButton, width: 2),
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

class _Auth04RememberForgotRow extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;
  const _Auth04RememberForgotRow({required this.rememberMe, required this.onRememberMeChanged});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: rememberMe,
          onChanged: onRememberMeChanged,
          activeColor: Auth04Theme.checkboxActive,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text('Remember me', style: TextStyle(color: Auth04Theme.textGray)),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: const Text('Forgot Password ?', style: Auth04Theme.link),
        ),
      ],
    );
  }
}

class _Auth04LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _Auth04LoginButton({required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Auth04Theme.primaryButton,
          elevation: 0,
        ),
        child: const Text('Log In', style: Auth04Theme.button),
      ),
    );
  }
}

class _Auth04DividerWithText extends StatelessWidget {
  const _Auth04DividerWithText();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('Or login with', style: Auth04Theme.divider),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}

class _Auth04SocialButtonsRow extends StatelessWidget {
  const _Auth04SocialButtonsRow();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _Auth04SocialButton(icon: AppIcons.googleLogo(), onTap: () {}),
        _Auth04SocialButton(icon: AppIcons.facebookLogo(), onTap: () {}),
        _Auth04SocialButton(icon: AppIcons.appleLogo(), onTap: () {}),
        _Auth04SocialButton(icon: AppIcons.phoneLogo(), onTap: () {}),
      ],
    );
  }
}

class _Auth04SocialButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;
  const _Auth04SocialButton({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Auth04Theme.dividerColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}

class AppIcons {
  static Widget logo({double width = 48, double height = 48}) {
    return SvgPicture.string(
      '''<svg width="27" height="27" viewBox="0 0 27 27" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M13.5 27C20.9561 27 27 20.956 27 13.5V4.05C27 2.97587 26.5733 1.94574 25.8138 1.18622C25.0543 0.426695 24.0241 0 22.95 0H14.175V5.92245C14.175 7.2738 14.2574 8.67375 14.9661 9.82395C15.4735 10.6483 16.1523 11.3538 16.9563 11.8927C17.7604 12.4316 18.671 12.7912 19.6263 12.9472L19.8848 12.989C19.9914 13.0255 20.0839 13.0943 20.1495 13.1859C20.215 13.2775 20.2502 13.3874 20.2502 13.5C20.2502 13.6126 20.215 13.7225 20.1495 13.8141C20.0839 13.9057 19.9914 13.9745 19.8848 14.011L19.6263 14.0528C18.2305 14.2808 16.9416 14.9415 15.9416 15.9416C14.9415 16.9416 14.2808 18.2305 14.0528 19.6263L14.011 19.8848C13.9746 19.9914 13.9057 20.0839 13.8141 20.1494C13.7225 20.2149 13.6126 20.2502 13.5 20.2502C13.3874 20.2502 13.2776 20.2149 13.1859 20.1494C13.0943 20.0839 13.0255 19.9914 12.989 19.8848L12.9472 19.6263C12.7912 18.671 12.4315 17.7604 11.8926 16.9564C11.3538 16.1523 10.6483 15.4735 9.82397 14.9661C8.67377 14.2574 7.27382 14.175 5.92247 14.175H0.016217C0.369242 21.3172 6.27077 27 13.5 27Z" fill="#375DFB"/>
<path d="M-1.52588e-05 12.8251H5.92243C7.27378 12.8251 8.67373 12.7427 9.82393 12.034C10.723 11.48 11.4799 10.7231 12.0339 9.82403C12.7426 8.67383 12.825 7.27388 12.825 5.92253V8.15817e-05H4.04998C2.97586 8.15817e-05 1.94572 0.426777 1.1862 1.1863C0.42668 1.94582 -1.52588e-05 2.97595 -1.52588e-05 4.05008V12.8251Z" fill="#375DFB"/>
</svg>
''',
      width: width,
      height: height,
    );
  }

  static Widget googleLogo() {
    return SvgPicture.string(
      '''<svg width="24" height="24" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg"><g clip-path="url(#clip0_17_40)"><path d="M23.9996 19.6363V28.9309H36.916C36.3488 31.9199 34.6468 34.4509 32.0941 36.1527L39.8831 42.1964C44.4213 38.0075 47.0395 31.8547 47.0395 24.5456C47.0395 22.8438 46.8868 21.2073 46.6031 19.6366L23.9996 19.6363Z" fill="#4285F4"/><path d="M10.5494 28.568L8.79263 29.9128L2.57434 34.7564C6.52342 42.589 14.6174 48 23.9991 48C30.4789 48 35.9116 45.8618 39.8826 42.1964L32.0936 36.1528C29.9554 37.5927 27.2281 38.4656 23.9991 38.4656C17.7591 38.4656 12.4575 34.2547 10.5592 28.5819L10.5494 28.568Z" fill="#34A853"/><path d="M2.57436 13.2436C0.938084 16.4726 0 20.1163 0 23.9999C0 27.8834 0.938084 31.5271 2.57436 34.7561C2.57436 34.7777 10.5599 28.5597 10.5599 28.5597C10.08 27.1197 9.79624 25.5925 9.79624 23.9996C9.79624 22.4067 10.08 20.8795 10.5599 19.4395L2.57436 13.2436Z" fill="#FBBC05"/><path d="M23.9996 9.55636C27.5342 9.55636 30.676 10.7781 33.1851 13.1345L40.0577 6.2619C35.8904 2.37833 30.4797 0 23.9996 0C14.6179 0 6.52342 5.38908 2.57434 13.2437L10.5597 19.44C12.4578 13.7672 17.7596 9.55636 23.9996 9.55636Z" fill="#EA4335"/></g><defs><clipPath id="clip0_17_40"><rect width="48" height="48" fill="white"/></clipPath></defs></svg>''',
      width: 24,
      height: 24,
    );
  }

  static Widget facebookLogo() {
    return SvgPicture.string(
      '''<svg width="24" height="24" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg"><g clip-path="url(#clip0_17_24)"><path d="M48 24C48 10.7453 37.2547 0 24 0C10.7453 0 0 10.7453 0 24C0 35.255 7.74912 44.6995 18.2026 47.2934V31.3344H13.2538V24H18.2026V20.8397C18.2026 12.671 21.8995 8.8848 29.9194 8.8848C31.44 8.8848 34.0637 9.18336 35.137 9.48096V16.129C34.5706 16.0694 33.5866 16.0397 32.3645 16.0397C28.4294 16.0397 26.9088 17.5306 26.9088 21.4061V24H34.7482L33.4013 31.3344H26.9088V47.8243C38.7926 46.3891 48.001 36.2707 48.001 24H48Z" fill="#0866FF"/><path d="M33.4003 31.3344L34.7472 24H26.9078V21.4061C26.9078 17.5306 28.4285 16.0397 32.3635 16.0397C33.5856 16.0397 34.5696 16.0694 35.136 16.129V9.48096C34.0627 9.1824 31.439 8.8848 29.9184 8.8848C21.8986 8.8848 18.2016 12.671 18.2016 20.8397V24H13.2528V31.3344H18.2016V47.2934C20.0582 47.7542 22.0003 48 23.999 48C24.983 48 25.9536 47.9395 26.9069 47.8243V31.3344H33.3994H33.4003Z" fill="white"/></g><defs><clipPath id="clip0_17_24"><rect width="48" height="48" fill="white"/></clipPath></defs></svg>''',
      width: 24,
      height: 24,
    );
  }

  static Widget appleLogo() {
    return SvgPicture.string(
      '''<svg width="19" height="18" viewBox="0 0 19 18" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M12.714 0C12.7559 0 12.7978 0 12.842 0C12.9448 1.2694 12.4603 2.21789 11.8714 2.90476C11.2936 3.58688 10.5024 4.24845 9.22273 4.14807C9.13737 2.89685 9.62268 2.01871 10.2107 1.33342C10.7561 0.69477 11.756 0.126466 12.714 0Z" fill="black"/>
<path d="M16.5878 13.2125C16.5878 13.2251 16.5878 13.2362 16.5878 13.248C16.2281 14.3372 15.7152 15.2707 15.0892 16.137C14.5177 16.9234 13.8174 17.9818 12.567 17.9818C11.4865 17.9818 10.7688 17.287 9.66141 17.2681C8.49002 17.2491 7.84584 17.849 6.77484 18C6.65232 18 6.52981 18 6.40967 18C5.62321 17.8862 4.98851 17.2633 4.52612 16.7021C3.16266 15.0438 2.10905 12.9018 1.91302 10.1607C1.91302 9.89196 1.91302 9.62401 1.91302 9.35527C1.99602 7.39347 2.94925 5.79843 4.21628 5.02541C4.88497 4.61439 5.80421 4.26424 6.82779 4.42074C7.26647 4.48872 7.71463 4.6389 8.10747 4.78749C8.47975 4.93056 8.9453 5.18428 9.38635 5.17084C9.68512 5.16215 9.98232 5.00644 10.2835 4.89657C11.1656 4.57804 12.0303 4.21287 13.17 4.38438C14.5398 4.59147 15.512 5.20009 16.1127 6.13909C14.954 6.87655 14.0379 7.98786 14.1944 9.88564C14.3335 11.6095 15.3358 12.6181 16.5878 13.2125Z" fill="black"/>
</svg>
''',
      width: 24,
      height: 24,
    );
  }

  static Widget phoneLogo() {
    return SvgPicture.string(
      '''<svg width="11" height="16" viewBox="0 0 11 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M5 2H6.5M5.75 11.75V11.7575M1.25 2.75C1.25 2.35218 1.40804 1.97064 1.68934 1.68934C1.97064 1.40804 2.35218 1.25 2.75 1.25H8.75C9.14782 1.25 9.52936 1.40804 9.81066 1.68934C10.092 1.97064 10.25 2.35218 10.25 2.75V13.25C10.25 13.6478 10.092 14.0294 9.81066 14.3107C9.52936 14.592 9.14782 14.75 8.75 14.75H2.75C2.35218 14.75 1.97064 14.592 1.68934 14.3107C1.40804 14.0294 1.25 13.6478 1.25 13.25V2.75Z" stroke="#04070E" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
</svg>

''',
    );
  }

  static Widget grid() {
    return SvgPicture.string(
      '''<svg width="356" height="230" viewBox="0 0 356 230" fill="none" xmlns="http://www.w3.org/2000/svg">
<g clip-path="url(#clip0_23_2414)">
<rect x="92.9917" y="-11.1736" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="144.18" y="-11.1736" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="195.369" y="-11.1736" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="246.557" y="-11.1736" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="297.746" y="-11.1736" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="348.934" y="-11.1736" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="92.9917" y="40.0151" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="144.18" y="40.015" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="195.369" y="40.015" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="246.557" y="40.015" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="297.746" y="40.015" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="348.934" y="40.015" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="92.9917" y="91.2037" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="144.18" y="91.2037" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="195.369" y="91.2037" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="246.557" y="91.2037" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="297.746" y="91.2037" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="348.934" y="91.2037" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="92.9917" y="142.392" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="144.18" y="142.392" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="195.369" y="142.392" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="246.557" y="142.392" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="297.746" y="142.392" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="348.934" y="142.392" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="92.9917" y="193.58" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="144.18" y="193.58" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="195.369" y="193.58" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="246.557" y="193.58" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="297.746" y="193.58" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<rect x="348.934" y="193.58" width="51.1885" height="51.1885" rx="5.64839" stroke="#F0F0F0" stroke-width="0.529536"/>
<path d="M297.746 -58.1255V-16.8217C297.746 -13.7021 300.275 -11.1733 303.394 -11.1733H343.286C346.405 -11.1733 348.934 -8.64441 348.934 -5.52489V34.3668C348.934 37.4864 351.463 40.0152 354.583 40.0152H394.474C397.594 40.0152 400.123 42.5441 400.123 45.6636V85.5553C400.123 88.6749 402.652 91.2037 405.771 91.2037H445.663C448.782 91.2037 451.311 93.7326 451.311 96.8521V136.744C451.311 139.863 453.84 142.392 456.96 142.392H498.264M246.557 -58.1255V-16.8217C246.557 -13.7021 249.086 -11.1733 252.206 -11.1733H292.097C295.217 -11.1733 297.746 -8.64441 297.746 -5.52489V34.3668C297.746 37.4864 300.275 40.0152 303.394 40.0152H343.286C346.405 40.0152 348.934 42.5441 348.934 45.6636V85.5553C348.934 88.6749 346.405 91.2037 343.286 91.2037H303.394C300.275 91.2037 297.746 88.6749 297.746 85.5553V44.9576L297.696 44.6239C297.317 42.0656 295.146 40.1553 292.56 40.1056L287.861 40.0152H252.206C249.086 40.0152 246.557 42.5441 246.557 45.6636V85.5553C246.557 88.6749 249.086 91.2037 252.206 91.2037H292.45L293.791 91.2931C296.017 91.4415 297.746 93.2898 297.746 95.52V99.8528M297.746 95.44V136.744C297.746 139.863 300.275 142.392 303.394 142.392H343.286C346.405 142.392 348.934 144.921 348.934 148.041V187.932C348.934 191.052 351.463 193.581 354.583 193.581H394.474C397.594 193.581 400.123 196.11 400.123 199.229V239.121C400.123 242.24 402.652 244.769 405.771 244.769H445.663C448.782 244.769 451.311 247.298 451.311 250.418V290.309C451.311 293.429 453.84 295.958 456.96 295.958H498.264" stroke="url(#paint0_linear_23_2414)" stroke-opacity="0.8" stroke-width="0.529536"/>
<rect x="92.9917" y="258.226" width="287.009" height="153.566" transform="rotate(-90 92.9917 258.226)" fill="url(#paint1_linear_23_2414)"/>
<rect x="380" y="296" width="287.009" height="153.566" transform="rotate(-180 380 296)" fill="url(#paint2_linear_23_2414)"/>
<ellipse cx="293.509" cy="-63.3787" rx="190.986" ry="162.744" fill="url(#paint3_radial_23_2414)"/>
</g>
<defs>
<linearGradient id="paint0_linear_23_2414" x1="246.557" y1="-58.1255" x2="492.615" y2="246.358" gradientUnits="userSpaceOnUse">
<stop offset="0.0819437" stop-color="#F7F7F7"/>
<stop offset="0.208333" stop-color="#12C2E9"/>
<stop offset="0.526042" stop-color="#C471ED"/>
<stop offset="0.9375" stop-color="#F64F59"/>
</linearGradient>
<linearGradient id="paint1_linear_23_2414" x1="236.496" y1="258.226" x2="236.496" y2="411.792" gradientUnits="userSpaceOnUse">
<stop stop-color="white"/>
<stop offset="1" stop-color="white" stop-opacity="0"/>
</linearGradient>
<linearGradient id="paint2_linear_23_2414" x1="523.505" y1="296" x2="523.505" y2="449.566" gradientUnits="userSpaceOnUse">
<stop stop-color="white"/>
<stop offset="0.713542" stop-color="white" stop-opacity="0.7"/>
<stop offset="1" stop-color="white" stop-opacity="0"/>
</linearGradient>
<radialGradient id="paint3_radial_23_2414" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(293.509 -63.3787) rotate(90) scale(162.744 190.986)">
<stop stop-color="white"/>
<stop offset="1" stop-color="white" stop-opacity="0"/>
</radialGradient>
<clipPath id="clip0_23_2414">
<rect width="375" height="257" fill="white" transform="translate(0 -27)"/>
</clipPath>
</defs>
</svg>
''',
    );
  }
}
