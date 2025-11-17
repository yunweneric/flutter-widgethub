import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../shared/logo.dart';
import '../shared/button.dart';
import '../shared/theme.dart';

/// Spotify registration screen with sign-up form and social authentication.
///
/// API Reference:
/// - No public properties
///
/// Usage:
/// ```dart
/// SpotifyRegister()
/// ```
class SpotifyRegister extends StatelessWidget {
  const SpotifyRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SpotifyTheme.dark,
      child: Builder(builder: (context) {
        final theme = Theme.of(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: theme.cardColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 24),
                          onPressed: () {},
                          splashRadius: 24,
                        ),
                        const Spacer(),
                        const SpotifyLogo(width: 120, height: 40),
                        const Spacer(flex: 2),
                      ],
                    ),
                    const SizedBox(height: 38),
                    Text(
                      'Register',
                      style: theme.textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('If You Need Any Support'),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Click Here',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const _SpotifyInput(
                      hintText: 'Enter Username',
                      obscureText: false,
                    ),
                    const SizedBox(height: 15),
                    _SpotifyInput(
                      hintText: 'Enter Email',
                      obscureText: false,
                      onSuffixTap: () {},
                    ),
                    const SizedBox(height: 15),
                    _SpotifyInput(
                      hintText: 'Enter Password',
                      obscureText: true,
                      onSuffixTap: () {},
                    ),

                    const SizedBox(height: 32),
                    SpotifyButton(
                      text: 'Create Account',
                      onPressed: () {},
                    ),

                    // 'Or' divider section
                    const SizedBox(height: 38),
                    Row(
                      children: [
                        const _OrDivider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Or', style: theme.textTheme.bodyMedium),
                        ),
                        const _OrDivider(),
                      ],
                    ),
                    const SizedBox(height: 38),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SpotifySocialButton(
                          asset: RegisterIcons.googleIcon,
                          onTap: () {},
                        ),
                        const SizedBox(width: 32),
                        _SpotifySocialButton(
                          asset: RegisterIcons.appleIcon,
                          onTap: () {},
                          color: theme.primaryColorLight,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already Have An Account?',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Sign In',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF444444),
              Color(0xFF222222),
              Color(0xFF444444),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
  }
}

class _SpotifyInput extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final VoidCallback? onSuffixTap;
  const _SpotifyInput({required this.hintText, this.obscureText = false, this.onSuffixTap});

  @override
  State<_SpotifyInput> createState() => _SpotifyInputState();
}

class _SpotifyInputState extends State<_SpotifyInput> {
  bool _obscure = false;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscure,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => _obscure = !_obscure),
              )
            : null,
      ),
    );
  }
}

class _SpotifySocialButton extends StatelessWidget {
  final String asset;
  final VoidCallback? onTap;
  final Color? color;
  const _SpotifySocialButton({required this.asset, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.string(
        asset,
        fit: BoxFit.contain,
        width: 32,
        height: 32,
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
    );
  }
}

class RegisterIcons {
  static String googleIcon =
      '''<svg width="48" height="48" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
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


''';
  static String appleIcon =
      '''<svg width="48" height="48" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
<g clip-path="url(#clip0_17_53)">
<path d="M43.5839 37.4071C42.858 39.0841 41.9988 40.6277 41.0033 42.047C39.6463 43.9817 38.5352 45.3209 37.6789 46.0646C36.3516 47.2853 34.9294 47.9105 33.4065 47.946C32.3132 47.946 30.9947 47.6349 29.4599 47.0039C27.9201 46.3757 26.5051 46.0646 25.2112 46.0646C23.8542 46.0646 22.3988 46.3757 20.8421 47.0039C19.2831 47.6349 18.0271 47.9638 17.0668 47.9964C15.6064 48.0586 14.1508 47.4157 12.6978 46.0646C11.7704 45.2558 10.6105 43.8691 9.22087 41.9047C7.72995 39.807 6.50422 37.3745 5.54395 34.6013C4.51554 31.6058 4 28.7051 4 25.8969C4 22.6801 4.69509 19.9057 6.08734 17.5807C7.18153 15.7132 8.63718 14.2401 10.4591 13.1586C12.2809 12.0772 14.2495 11.5261 16.3694 11.4908C17.5293 11.4908 19.0505 11.8497 20.9408 12.5548C22.8258 13.2623 24.0361 13.6212 24.5667 13.6212C24.9635 13.6212 26.308 13.2016 28.5874 12.3652C30.7428 11.5895 32.562 11.2683 34.0524 11.3948C38.0908 11.7208 41.1247 13.3127 43.1425 16.1808C39.5307 18.3692 37.7441 21.4342 37.7797 25.3663C37.8123 28.429 38.9233 30.9777 41.107 33.0013C42.0966 33.9405 43.2017 34.6664 44.4313 35.182C44.1646 35.9553 43.8832 36.696 43.5839 37.4071ZM34.322 0.960792C34.322 3.36134 33.445 5.60273 31.6969 7.67733C29.5873 10.1436 27.0357 11.5688 24.2687 11.3439C24.2334 11.0559 24.213 10.7528 24.213 10.4343C24.213 8.12976 25.2162 5.66346 26.9978 3.64693C27.8872 2.62593 29.0185 1.77697 30.3903 1.09975C31.7591 0.432629 33.0539 0.0636968 34.2716 0.000518799C34.3072 0.321435 34.322 0.642371 34.322 0.960761V0.960792Z" fill="black"/>
</g>
<defs>
<clipPath id="clip0_17_53">
<rect width="48" height="48" fill="white"/>
</clipPath>
</defs>
</svg>

''';
}
