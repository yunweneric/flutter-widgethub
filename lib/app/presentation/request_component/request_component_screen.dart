/// Screen for requesting new components.
///
/// Displays a placeholder screen for users to request new components
/// to be added to the library. Currently shows a "coming soon" message.
import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/layout/app_layout.dart';

/// Screen for component requests.
///
/// Placeholder screen where users can request new components to be
/// added to the Flutter WidgetHub library.
class RequestComponentScreen extends StatefulWidget {
  /// Creates a request component screen.
  const RequestComponentScreen({super.key});

  @override
  State<RequestComponentScreen> createState() => _RequestComponentScreenState();
}

class _RequestComponentScreenState extends State<RequestComponentScreen> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      children: [
        Text(
          LangUtil.trans("comingSoon"),
          style: Theme.of(context).textTheme.displayLarge,
        )
,
        const Kh10Spacer(),
         Text(
          LangUtil.trans("requestComingSoonDescription"),
          textAlign: TextAlign.center,
        )
,
      ],
    );
  }
}
