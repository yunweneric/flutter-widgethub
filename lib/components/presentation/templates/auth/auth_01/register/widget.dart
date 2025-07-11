import 'package:flutter/material.dart';
import 'package:flutterui/components/presentation/templates/auth/auth_01/shared/shared.dart';

class Auth01RegisterWidget extends StatefulWidget {
  const Auth01RegisterWidget({super.key});

  @override
  State<Auth01RegisterWidget> createState() => _Auth01RegisterWidgetState();
}

class _Auth01RegisterWidgetState extends State<Auth01RegisterWidget> {
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
                  const AuthTitle(title: 'Sign up to your\nAccount'),
                  AppSizing.khSpacer(16),
                  const AuthSubtitle(title: 'Enter your email and password to sign up'),
                  AppSizing.khSpacer(32),
                  Auth01TextField(
                    label: "Full Names",
                    placeholder: "John Doe",
                    controller: _emailController,
                    theme: _customTheme,
                  ),
                  AppSizing.khSpacer(20),
                  Auth01TextField(
                    label: "Email",
                    placeholder: "mail@mail.com",
                    controller: _emailController,
                    theme: _customTheme,
                  ),
                  AppSizing.khSpacer(20),
                  Auth01PasswordField(
                    label: "Password",
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
                  Auth01PasswordField(
                    label: "Confirm Password",
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
                  const Auth01Button(title: "Register"),
                  AppSizing.khSpacer(20),
                  const OrDivider(),
                  AppSizing.khSpacer(20),
                  const Auth01GoogleButton(),
                  AppSizing.khSpacer(12),
                  const Auth01FacebookButton(),
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
