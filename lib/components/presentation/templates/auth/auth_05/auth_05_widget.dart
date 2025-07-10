import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Auth05Theme {
  static const Color background = Color(0xFF0D0D1B);
  static const Color card = Colors.white;
  static const Color primaryButton = Color(0xFF2563EB);
  static const Color accent = Color(0xFF6C7AFA);
  static const Color dividerColor = Color(0xFFE5E7EB);
  static const Color inputBorder = Color(0xFFE5E7EB);
  static const Color inputHint = Color(0xFFB0B3C7);
  static const Color textDark = Color(0xFF181C2E);
  static const Color textLight = Colors.white;
  static const Color textGray = Color(0xFFB0B3C7);
  static const Color link = Color(0xFF6C7AFA);

  static const TextStyle logo = TextStyle(
    color: primaryButton,
    fontWeight: FontWeight.bold,
    fontSize: 32,
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
  static const TextStyle linkStyle = TextStyle(
    color: link,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  static const TextStyle forgotStyle = TextStyle(
    color: textGray,
    fontWeight: FontWeight.w500,
    fontSize: 15,
    decoration: TextDecoration.underline,
  );
}

class Auth05Widget extends StatefulWidget {
  const Auth05Widget({Key? key}) : super(key: key);

  @override
  State<Auth05Widget> createState() => _Auth05WidgetState();
}

class _Auth05WidgetState extends State<Auth05Widget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Auth05Theme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const _Auth05Header(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _Auth05InputCard(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    obscurePassword: _obscurePassword,
                    onTogglePassword: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Forgot Your Password ?',
                      style: Auth05Theme.forgotStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _Auth05LoginButton(onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Auth05Header extends StatelessWidget {
  const _Auth05Header();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top: 0, left: 0, right: 0, child: AppIcons.grid()),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Auth05Theme.background.withOpacity(0.2),
                Auth05Theme.background.withOpacity(0.8),
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 32),
          child: SafeArea(
            child: Column(
              children: [
                AppIcons.logo(width: 48, height: 48),
                const SizedBox(height: 32),
                const Text('Sign in to your', style: Auth05Theme.title, textAlign: TextAlign.center),
                const Text('Account', style: Auth05Theme.title, textAlign: TextAlign.center),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? ", style: Auth05Theme.subtitle),
                    GestureDetector(
                      onTap: () {},
                      child: const Text('Sign Up', style: Auth05Theme.linkStyle),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Auth05InputCard extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePassword;
  const _Auth05InputCard({
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Auth05Theme.card,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          _Auth05InputField(
            controller: emailController,
            hintText: 'Loisbecket@gmail.com',
            icon: const Icon(Icons.email_outlined, color: Auth05Theme.inputHint),
            obscureText: false,
          ),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          _Auth05InputField(
            controller: passwordController,
            hintText: '********',
            icon: const Icon(Icons.lock_outline, color: Auth05Theme.inputHint),
            obscureText: obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Auth05Theme.inputHint,
              ),
              onPressed: onTogglePassword,
            ),
          ),
        ],
      ),
    );
  }
}

class _Auth05InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget icon;
  final Widget? suffixIcon;
  const _Auth05InputField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: Auth05Theme.input,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Auth05Theme.inputHintStyle,
        border: InputBorder.none,
        prefixIcon: icon,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
        filled: true,
        fillColor: Colors.transparent,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }
}

class _Auth05LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _Auth05LoginButton({required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Auth05Theme.primaryButton,
          elevation: 0,
        ),
        child: const Text('Log In', style: Auth05Theme.button),
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
