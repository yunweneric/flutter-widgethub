/// Interactive "code ↔ preview" showcase used on the landing page.
///
/// One bordered card split into two panes: a live device preview on the
/// left (with accent switcher) and the always-dark source panel on the
/// right. Panes share a fixed height so the card never grows with the
/// snippet, and the code area scrolls inside its own pane.
library;

import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/colors.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/code_highlight.dart';
import 'package:flutterui/app/shared/presentation/widgets/device_frame.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

/// One selectable accent in the demo.
class _Accent {
  final Color color;
  final String labelKey;
  final AppIconData icon;

  const _Accent(this.color, this.labelKey, this.icon);
}

const List<_Accent> _accents = [
  _Accent(Color(0xFFE11D48), 'red', AppIcons.home),
  _Accent(Color(0xFF0D9488), 'teal', AppIcons.notification),
  _Accent(Color(0xFF2563EB), 'blue', AppIcons.verified),
];

class DeviceInteractive extends StatefulWidget {
  const DeviceInteractive({super.key});

  @override
  State<DeviceInteractive> createState() => _DeviceInteractiveState();
}

class _DeviceInteractiveState extends State<DeviceInteractive> {
  int currentIndex = 0;

  void _select(int index) => setState(() => currentIndex = index);

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final bool isMobile = AppSizing.isMobile(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Stack the panes once the row would squeeze either side.
        final bool stacked = constraints.maxWidth < 900;
        final double previewHeight = stacked ? (isMobile ? 420 : 460) : 540;
        final double codeHeight = stacked ? 380 : previewHeight;

        final Widget preview = _PreviewPane(
          currentIndex: currentIndex,
          onSelected: _select,
        );

        final Widget code = CodeHighlight(
          code: sampleCode,
          title: 'device_interactive.dart',
          fontSize: isMobile ? 11 : 12.5,
          borderRadius: BorderRadius.zero,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: tokens.card,
                borderRadius: AppRadii.lgAll,
                border: Border.all(color: tokens.border),
              ),
              child: stacked
                  ? Column(
                      children: [
                        SizedBox(height: previewHeight, child: preview),
                        SizedBox(height: codeHeight, child: code),
                      ],
                    )
                  : SizedBox(
                      height: previewHeight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(flex: 5, child: preview),
                          Expanded(flex: 6, child: code),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: AppSpace.md),
            Row(
              children: [
                AppIcon(icon: AppIcons.touch, size: 14, color: tokens.muted),
                const SizedBox(width: AppSpace.sm),
                Flexible(
                  child: Text(
                    LangUtil.trans("integrationHint"),
                    style: context.text.muted,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// Left pane: header with accent switcher over a live device.
class _PreviewPane extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onSelected;

  const _PreviewPane({required this.currentIndex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final Color accent = _accents[currentIndex].color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pane header — mirrors the code pane's filename bar.
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.symmetric(horizontal: AppSpace.lg, vertical: 10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: tokens.border)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LangUtil.trans("preview").toUpperCase(),
                style: context.text.overline,
              ),
              _AccentSwitcher(
                currentIndex: currentIndex,
                onSelected: onSelected,
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Dotted graph-paper backdrop.
              CustomPaint(painter: _DotGridPainter(color: tokens.border)),
              // Accent glow that follows the selection.
              IgnorePointer(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOut,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, 0.6),
                      radius: 0.9,
                      colors: [
                        accent.withValues(alpha: 0.22),
                        accent.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              // The device, standing on the floor of the pane.
              ClipRect(
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSpace.xl),
                  child: Transform.translate(
                    offset: const Offset(0, 24),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 320,
                        height: 660,
                        child: AppDeviceFrame(
                          child: _DemoApp(
                            currentIndex: currentIndex,
                            onSelected: onSelected,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Three accent swatches in the pane header — the same state the phone's
/// bottom bar drives.
class _AccentSwitcher extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onSelected;

  const _AccentSwitcher({required this.currentIndex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_accents.length, (i) {
        final Color accent = _accents[i].color;
        final bool active = i == currentIndex;

        return Padding(
          padding: const EdgeInsets.only(left: AppSpace.sm),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => onSelected(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpace.sm, vertical: 5),
                decoration: BoxDecoration(
                  color: active
                      ? accent.withValues(alpha: 0.14)
                      : Colors.transparent,
                  borderRadius: AppRadii.smAll,
                  border: Border.all(
                    color:
                        active ? accent.withValues(alpha: 0.5) : tokens.border,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    if (!AppSizing.isMobile(context)) ...[
                      const SizedBox(width: 6),
                      Text(
                        LangUtil.trans(_accents[i].labelKey),
                        style: AppTypography.sans(
                          color: active ? tokens.foreground : tokens.muted,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                          height: 1.0,
                        ),
                      ),
                    ],
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

/// The little app running inside the device frame.
class _DemoApp extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onSelected;

  const _DemoApp({required this.currentIndex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final Color accent = _accents[currentIndex].color;
    final Color surface = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: surface,
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        color: accent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              key: ValueKey(currentIndex),
              tween: Tween<double>(begin: 1, end: 0),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOutBack,
              builder: (context, value, child) {
                return Opacity(
                  opacity: (1 - value).clamp(0.0, 1.0),
                  child: Transform.translate(
                    offset: Offset(0, -value * 120),
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg),
                child: FittedBox(
                  child: Text(
                    LangUtil.trans(_accents[currentIndex].labelKey),
                    style: const TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -2,
                      color: AppColors.textWhite,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpace.huge),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: surface,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedItemColor: accent,
        currentIndex: currentIndex,
        onTap: onSelected,
        items: [
          for (final item in _accents)
            BottomNavigationBarItem(
              icon: AppIcon(icon: item.icon),
              label: LangUtil.trans(item.labelKey),
            ),
        ],
      ),
    );
  }
}

/// Faint dot grid behind the device.
class _DotGridPainter extends CustomPainter {
  final Color color;

  const _DotGridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    const double gap = 18;
    final paint = Paint()..color = color;
    for (double y = gap; y < size.height; y += gap) {
      for (double x = gap; x < size.width; x += gap) {
        canvas.drawCircle(Offset(x, y), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotGridPainter oldDelegate) => oldDelegate.color != color;
}

/// Snippet shown in the code pane — a trimmed version of the widget
/// rendered in the preview.
const sampleCode = '''import 'package:flutter/material.dart';

/// Accent switcher demo: tap the bottom bar, the screen follows.
class DeviceInteractive extends StatefulWidget {
  const DeviceInteractive({super.key});

  @override
  State<DeviceInteractive> createState() => _DeviceInteractiveState();
}

class _DeviceInteractiveState extends State<DeviceInteractive> {
  static const accents = [
    (Color(0xFFE11D48), 'RED', Icons.home_rounded),
    (Color(0xFF0D9488), 'TEAL', Icons.notifications_rounded),
    (Color(0xFF2563EB), 'BLUE', Icons.verified_user_rounded),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final (color, label, _) = accents[currentIndex];

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        color: color,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TweenAnimationBuilder<double>(
              key: ValueKey(currentIndex),
              tween: Tween<double>(begin: 1, end: 0),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOutBack,
              builder: (context, value, child) => Opacity(
                opacity: 1 - value,
                child: Transform.translate(
                  offset: Offset(0, -value * 120),
                  child: child,
                ),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: color,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          for (final (_, label, icon) in accents)
            BottomNavigationBarItem(icon: Icon(icon), label: label),
        ],
      ),
    );
  }
}
''';
