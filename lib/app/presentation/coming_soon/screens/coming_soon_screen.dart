/// Coming soon placeholder screen.
///
/// Placeholder screen displayed for features that are not yet implemented.
import 'package:flutter/material.dart';

/// Screen displayed for features that are coming soon.
///
/// Currently shows a placeholder widget.
class ComingSoonScreen extends StatefulWidget {
  /// Creates a coming soon screen.
  const ComingSoonScreen({super.key});

  @override
  State<ComingSoonScreen> createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
