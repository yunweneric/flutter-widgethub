import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Auth02Widget extends StatefulWidget {
  const Auth02Widget({super.key});

  @override
  State<Auth02Widget> createState() => _Auth02WidgetState();
}

class _Auth02WidgetState extends State<Auth02Widget> {
  bool _obscurePassword = true;
  bool _rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static final ThemeData _customTheme = ThemeData(
    primaryColor: const Color(0xFF2563EB),
    scaffoldBackgroundColor: const Color(0xFFF7F8FA),
    cardColor: Colors.white,
    dividerColor: const Color(0xFFE5E7EB),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        height: 1.1,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        color: Color(0xFFD1D5DB),
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
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStatePropertyAll(Color(0xFF2563EB)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _customTheme,
      child: Scaffold(
        backgroundColor: _customTheme.scaffoldBackgroundColor,
        body: Stack(
          children: [
            // Blue background with grid
            const _AuthBackground(),
            // Main content
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  // Logo
                  const Center(child: _AuthLogo()),
                  const SizedBox(height: 32),
                  // Title
                  const _AuthTitle(),
                  const SizedBox(height: 12),
                  // Subtitle
                  const _AuthSubtitle(),
                  const SizedBox(height: 32),
                  // Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _AuthCard(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      obscurePassword: _obscurePassword,
                      rememberMe: _rememberMe,
                      onRememberMeChanged: (val) {
                        setState(() => _rememberMe = val ?? false);
                      },
                      onTogglePassword: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                      theme: _customTheme,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Blue background with grid
class _AuthBackground extends StatelessWidget {
  const _AuthBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizing.kheight(context) * 0.5,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF2563EB),
      ),
      child: AppIcon.grid(),
    );
  }
}

/// Main logo
class _AuthLogo extends StatelessWidget {
  const _AuthLogo();

  @override
  Widget build(BuildContext context) {
    return AppIcon.logo();
  }
}

/// Title
class _AuthTitle extends StatelessWidget {
  const _AuthTitle();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'Sign in to your\nAccount',
      textAlign: TextAlign.center,
      style: theme.textTheme.displayLarge,
    );
  }
}

/// Subtitle
class _AuthSubtitle extends StatelessWidget {
  const _AuthSubtitle();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'Enter your email and password to log in',
      textAlign: TextAlign.center,
      style: theme.textTheme.bodyMedium,
    );
  }
}

/// Card containing the login form and actions
class _AuthCard extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;
  final VoidCallback onTogglePassword;
  final ThemeData theme;

  const _AuthCard({
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.rememberMe,
    required this.onRememberMeChanged,
    required this.onTogglePassword,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _GoogleButton(),
          const SizedBox(height: 20),
          const _OrDivider(),
          const SizedBox(height: 20),
          _EmailField(controller: emailController),
          const SizedBox(height: 16),
          _PasswordField(
            controller: passwordController,
            obscureText: obscurePassword,
            onToggle: onTogglePassword,
          ),
          const SizedBox(height: 8),
          _RememberMeRow(
            rememberMe: rememberMe,
            onChanged: onRememberMeChanged,
          ),
          const SizedBox(height: 8),
          const _LoginButton(),
          const SizedBox(height: 16),
          _SignUpLink(theme: theme),
        ],
      ),
    );
  }
}

/// Google login button
class _GoogleButton extends StatelessWidget {
  const _GoogleButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: AppIcon.googleLogo(),
      label: const Text('Continue with Google', style: TextStyle(color: Colors.black)),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFFE5E7EB)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, color: Colors.black),
        minimumSize: const Size.fromHeight(48),
      ),
    );
  }
}

/// Divider with "Or login with"
class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Or login with', style: theme.textTheme.bodySmall),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

/// Email input field
class _EmailField extends StatelessWidget {
  final TextEditingController controller;
  const _EmailField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Loisbecket@gmail.com',
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

/// Password input field with toggle
class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback onToggle;

  const _PasswordField({
    required this.controller,
    required this.obscureText,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: '********',
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFF6B7280),
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}

/// Remember me and forgot password row
class _RememberMeRow extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onChanged;

  const _RememberMeRow({
    required this.rememberMe,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: rememberMe,
          onChanged: onChanged,
          visualDensity: VisualDensity.compact,
        ),
        const Text('Remember me', style: TextStyle(color: Color(0xFF6B7280))),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: const Text('Forgot Password ?'),
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
        ),
      ],
    );
  }
}

/// Login button
class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('Log In'),
      ),
    );
  }
}

/// Sign up link
class _SignUpLink extends StatelessWidget {
  final ThemeData theme;
  const _SignUpLink({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ", style: TextStyle(color: Color(0xFF6B7280))),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

/// AppIcon: All logos and icons for the template
class AppIcon {
  /// Main logo
  static Widget logo({double width = 48, double height = 48}) {
    return SvgPicture.string(
      '''<svg width="29" height="28" viewBox="0 0 29 28" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M14.5 28C22.2322 28 28.5 21.7322 28.5 14V4.2C28.5 3.08609 28.0575 2.0178 27.2699 1.23015C26.4822 0.442499 25.4139 0 24.3 0H15.2V6.1418C15.2 7.5432 15.2854 8.995 16.0204 10.1878C16.5466 11.0426 17.2505 11.7743 18.0844 12.3332C18.9182 12.892 19.8625 13.265 20.8532 13.4267L21.1213 13.4701C21.2319 13.5079 21.3278 13.5793 21.3957 13.6743C21.4637 13.7693 21.5002 13.8832 21.5002 14C21.5002 14.1168 21.4637 14.2307 21.3957 14.3257C21.3278 14.4207 21.2319 14.4921 21.1213 14.5299L20.8532 14.5733C19.4058 14.8098 18.0691 15.4949 17.032 16.532C15.9949 17.5691 15.3098 18.9057 15.0733 20.3532L15.0299 20.6213C14.9922 20.7318 14.9208 20.8278 14.8257 20.8957C14.7307 20.9636 14.6168 21.0002 14.5 21.0002C14.3832 21.0002 14.2693 20.9636 14.1743 20.8957C14.0793 20.8278 14.0079 20.7318 13.9701 20.6213L13.9267 20.3532C13.7649 19.3625 13.392 18.4182 12.8331 17.5844C12.2743 16.7505 11.5427 16.0466 10.6878 15.5204C9.49503 14.7854 8.04323 14.7 6.64183 14.7H0.516833C0.882934 22.1067 7.00303 28 14.5 28Z" fill="white"/>
<path d="M0.5 13.3001H6.6418C8.0432 13.3001 9.495 13.2147 10.6878 12.4797C11.6202 11.9052 12.4051 11.1203 12.9796 10.1879C13.7146 8.99508 13.8 7.54328 13.8 6.14188V8.46032e-05H4.7C3.58609 8.46032e-05 2.5178 0.442583 1.73015 1.23024C0.942499 2.01789 0.5 3.08618 0.5 4.20008V13.3001Z" fill="white"/>
</svg>
''',
      width: width,
      height: height,
    );
  }

  /// Google logo
  static Widget googleLogo({double width = 24, double height = 24}) {
    return SvgPicture.string(
      '''<svg width="$width" height="$height" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg"><g clip-path="url(#clip0_17_40)"><path d="M23.9996 19.6363V28.9309H36.916C36.3488 31.9199 34.6468 34.4509 32.0941 36.1527L39.8831 42.1964C44.4213 38.0075 47.0395 31.8547 47.0395 24.5456C47.0395 22.8438 46.8868 21.2073 46.6031 19.6366L23.9996 19.6363Z" fill="#4285F4"/><path d="M10.5494 28.568L8.79263 29.9128L2.57434 34.7564C6.52342 42.589 14.6174 48 23.9991 48C30.4789 48 35.9116 45.8618 39.8826 42.1964L32.0936 36.1528C29.9554 37.5927 27.2281 38.4656 23.9991 38.4656C17.7591 38.4656 12.4575 34.2547 10.5592 28.5819L10.5494 28.568Z" fill="#34A853"/><path d="M2.57436 13.2436C0.938084 16.4726 0 20.1163 0 23.9999C0 27.8834 0.938084 31.5271 2.57436 34.7561C2.57436 34.7777 10.5599 28.5597 10.5599 28.5597C10.08 27.1197 9.79624 25.5925 9.79624 23.9996C9.79624 22.4067 10.08 20.8795 10.5599 19.4395L2.57436 13.2436Z" fill="#FBBC05"/><path d="M23.9996 9.55636C27.5342 9.55636 30.676 10.7781 33.1851 13.1345L40.0577 6.2619C35.8904 2.37833 30.4797 0 23.9996 0C14.6179 0 6.52342 5.38908 2.57434 13.2437L10.5597 19.44C12.4578 13.7672 17.7596 9.55636 23.9996 9.55636Z" fill="#EA4335"/></g><defs><clipPath id="clip0_17_40"><rect width="48" height="48" fill="white"/></clipPath></defs></svg>''',
      width: width,
      height: height,
    );
  }

  /// Decorative grid background
  static Widget grid() {
    return SvgPicture.string(
      '''<svg width="375" height="387" viewBox="0 0 375 387" fill="none" xmlns="http://www.w3.org/2000/svg">
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
