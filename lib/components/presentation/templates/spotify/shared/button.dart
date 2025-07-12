import 'package:flutter/material.dart';

class SpotifyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final TextStyle? textStyle;

  const SpotifyButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.width,
    this.height,
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle ?? Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
        ),
      ),
    );
  }
}
