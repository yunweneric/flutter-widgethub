/// Fullscreen component stage.
///
/// The docs preview canvas is boxed in with the rest of the page, which is
/// fine for a phone-sized widget and useless for anything designed for a
/// wide viewport. This route hands the whole window to a single component
/// and lets the reader swap the simulated viewport underneath it, so a
/// desktop layout can be judged at desktop size.
library;

import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/logic/device_frame/device_frame_bloc.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/theme/app_motion.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/chip.dart';

/// Simulated viewport width per device, in logical pixels, for the
/// unframed stage. With the frame on, the simulated size comes from the
/// device itself instead.
///
/// Desktop is deliberately absent: it means "whatever the window is",
/// which is the entire point of going fullscreen.
const Map<AppDeviceType, double> _stageWidths = {
  AppDeviceType.MOBILE: 420,
  AppDeviceType.TABLET: 834,
};

/// Full-window preview of a single component.
class FullscreenPreview extends StatefulWidget {
  final Component component;

  /// Which viewport the stage opens on.
  final AppDeviceType initialDevice;

  const FullscreenPreview({
    super.key,
    required this.component,
    this.initialDevice = AppDeviceType.DESKTOP,
  });

  /// Pushes the stage over the whole app, above any shell chrome.
  static Future<void> open(
    BuildContext context, {
    required Component component,
    AppDeviceType initialDevice = AppDeviceType.DESKTOP,
  }) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      PageRouteBuilder<void>(
        opaque: true,
        barrierDismissible: false,
        transitionDuration: AppMotion.page,
        reverseTransitionDuration: AppMotion.standard,
        pageBuilder: (_, __, ___) => FullscreenPreview(
          component: component,
          initialDevice: initialDevice,
        ),
        transitionsBuilder: (context, animation, _, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: AppMotion.entrance,
            reverseCurve: Curves.easeIn,
          );
          return FadeTransition(
            opacity: curved,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.98, end: 1).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  State<FullscreenPreview> createState() => _FullscreenPreviewState();
}

class _FullscreenPreviewState extends State<FullscreenPreview> {
  late AppDeviceType _device = widget.initialDevice;

  /// Whether the simulated viewport wears its device's bezels. On by
  /// default — a phone layout reads as a phone — but a reader comparing
  /// pixel work wants the chrome gone, hence the toggle.
  bool _framed = true;

  /// Rebuilt on every device switch so the component starts from a clean
  /// state instead of animating its old layout into the new viewport.
  int _stageGeneration = 0;

  void _close() {
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
  }

  void _select(AppDeviceType device) {
    if (device == _device) return;
    setState(() {
      _device = device;
      _stageGeneration++;
    });
  }

  /// Framing changes the simulated size, so the component restarts here
  /// too rather than reflowing mid-animation.
  void _toggleFrame() {
    setState(() {
      _framed = !_framed;
      _stageGeneration++;
    });
  }

  /// The handset or tablet whose bezels the stage wears.
  ///
  /// The device picked in the nav wins when its form factor matches the
  /// stage; otherwise the stage falls back to a stock device, so choosing
  /// a laptop in the picker cannot put a MacBook around a phone layout.
  DeviceInfo _frameDevice() {
    final selected = getIt.get<DeviceFrameBloc>().state.selectedDeviceInfo;
    final DeviceType type = selected.identifier.type;

    switch (_device) {
      case AppDeviceType.MOBILE:
        return type == DeviceType.phone ? selected : Devices.ios.iPhone13;
      case AppDeviceType.TABLET:
        return type == DeviceType.tablet ? selected : Devices.ios.iPad;
      case AppDeviceType.DESKTOP:
        return selected;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Material(
      color: tokens.background,
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): _close,
        },
        child: Focus(
          autofocus: true,
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Desktop means "the window", so there is no device to
              // frame and nothing for the toggle to do.
              final bool canFrame = _device != AppDeviceType.DESKTOP;
              final DeviceInfo? frame =
                  canFrame && _framed ? _frameDevice() : null;

              // Framed, the device dictates the simulated viewport; bare,
              // the stage widths do.
              final Size stage =
                  frame?.screenSize ?? _stageSize(constraints.biggest);

              return Stack(
                children: [
                  Positioned.fill(
                    child: Center(
                      child: _Stage(
                        key: ValueKey(_stageGeneration),
                        size: stage,
                        fullBleed: _device == AppDeviceType.DESKTOP,
                        frame: frame,
                        available: Size(
                          constraints.maxWidth,
                          (constraints.maxHeight - _controlsClearance)
                              .clamp(0, constraints.maxHeight),
                        ),
                        child: widget.component.codeComponents.first.widget,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: AppSpace.xl,
                    child: Center(
                      child: _StageControls(
                        component: widget.component,
                        device: _device,
                        stage: stage,
                        frame: frame,
                        canFrame: canFrame,
                        onDeviceSelected: _select,
                        onFrameToggled: _toggleFrame,
                        onClose: _close,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// The viewport handed to the component. Anything wider than the window
  /// is clamped, and the framed viewports leave room for the control bar.
  Size _stageSize(Size available) {
    final double? target = _stageWidths[_device];
    if (target == null) return available;
    return Size(
      target.clamp(0, available.width),
      (available.height - _controlsClearance).clamp(0, available.height),
    );
  }
}

/// Vertical room kept clear around a framed stage so the floating control
/// bar sits below the viewport instead of on top of it.
const double _controlsClearance = AppSpace.huge * 2;

/// The component under a simulated viewport.
///
/// The [MediaQuery] override is what makes the simulation real: the
/// component's own breakpoint checks read this size, not the window's, so
/// a mobile stage renders the mobile layout on a 27" monitor.
class _Stage extends StatelessWidget {
  final Size size;
  final bool fullBleed;

  /// Device whose bezels wrap the stage; null renders it bare.
  final DeviceInfo? frame;

  /// Room the stage has to fill, used to scale the bezels down to fit.
  final Size available;

  final Widget child;

  const _Stage({
    super.key,
    required this.size,
    required this.fullBleed,
    required this.frame,
    required this.available,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    final DeviceInfo? frame = this.frame;
    if (frame != null) {
      // DeviceFrame renders at the device's own size and fits itself to
      // whatever box it is handed, and applies the screen's MediaQuery
      // and platform theme on the way in.
      return SizedBox.fromSize(
        size: available,
        child: DeviceFrame(
          device: frame,
          screen: ColoredBox(color: tokens.background, child: child),
        ),
      );
    }

    final Widget stage = MediaQuery(
      data: MediaQuery.of(context).copyWith(size: size),
      child: SizedBox.fromSize(size: size, child: child),
    );

    if (fullBleed) return stage;

    return AnimatedContainer(
      duration: AppMotion.standard,
      curve: AppMotion.curve,
      decoration: BoxDecoration(
        color: tokens.background,
        borderRadius: AppRadii.lgAll,
        border: Border.all(color: tokens.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: stage,
    );
  }
}

/// Floating control bar: viewport switcher, frame toggle, live stage
/// size, exit.
class _StageControls extends StatelessWidget {
  final Component component;
  final AppDeviceType device;
  final Size stage;

  /// Device currently being simulated with bezels, if any.
  final DeviceInfo? frame;

  /// Whether the current viewport has bezels to offer at all.
  final bool canFrame;

  final void Function(AppDeviceType) onDeviceSelected;
  final VoidCallback onFrameToggled;
  final VoidCallback onClose;

  const _StageControls({
    required this.component,
    required this.device,
    required this.stage,
    required this.frame,
    required this.canFrame,
    required this.onDeviceSelected,
    required this.onFrameToggled,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    // On a narrow window the bar drops to glyphs only, so it never grows
    // wider than the stage it is meant to sit under.
    final bool compact = AppSizing.isMobile(context);

    // Desktop is always offered here even when the component does not list
    // it: filling the window is the reason the reader opened the stage.
    final List<AppDeviceType> devices = {
      ...component.responsiveDevices,
      AppDeviceType.DESKTOP,
    }.toList()
      ..sort((a, b) => a.index.compareTo(b.index));

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.sm,
        vertical: AppSpace.xs,
      ),
      decoration: BoxDecoration(
        color: tokens.card,
        borderRadius: AppRadii.lgAll,
        border: Border.all(color: tokens.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: tokens.isDark ? 0.45 : 0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...devices.map(
            (platform) => Padding(
              padding: const EdgeInsets.only(right: AppSpace.xs),
              child: AppChip(
                active: device == platform,
                icon: platform.generateIcon(),
                title: compact
                    ? null
                    : LangUtil.trans(platform.describe().toLowerCase()),
                onTap: () => onDeviceSelected(platform),
              ),
            ),
          ),
          if (canFrame)
            AppChip(
              active: frame != null,
              icon: AppIcons.frame,
              title: compact ? null : LangUtil.trans("deviceFrame"),
              onTap: onFrameToggled,
            ),
          Container(
            width: 1,
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: AppSpace.sm),
            color: tokens.border,
          ),
          if (!compact) ...[
            Text(
              frame == null
                  ? '${stage.width.round()} × ${stage.height.round()}'
                  : '${frame!.name} · '
                      '${stage.width.round()} × ${stage.height.round()}',
              style: AppTypography.mono(
                color: tokens.mutedForeground,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: AppSpace.sm),
          ],
          AppChip(
            icon: AppIcons.fullscreenExit,
            title: compact ? null : LangUtil.trans("exitFullscreen"),
            onTap: onClose,
          ),
        ],
      ),
    );
  }
}

/// Toolbar affordance that opens [FullscreenPreview].
class FullscreenPreviewButton extends StatelessWidget {
  final Component component;

  /// Overrides the viewport the stage opens on; defaults to the widest one
  /// the component declares.
  final AppDeviceType? initialDevice;

  const FullscreenPreviewButton({
    super.key,
    required this.component,
    this.initialDevice,
  });

  /// The stage opens as wide as the component was built for: full window
  /// for anything that claims desktop, and the largest declared viewport
  /// otherwise, so a phone-only layout is not stretched across a monitor
  /// the moment it opens.
  AppDeviceType get _widestDeclared {
    final devices = component.responsiveDevices;
    if (devices.isEmpty || devices.contains(AppDeviceType.DESKTOP)) {
      return AppDeviceType.DESKTOP;
    }
    return devices.reduce((a, b) => a.index >= b.index ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: LangUtil.trans("fullscreenHint"),
      waitDuration: const Duration(milliseconds: 400),
      child: AppChip(
        icon: AppIcons.fullscreen,
        onTap: () => FullscreenPreview.open(
          context,
          component: component,
          initialDevice: initialDevice ?? _widestDeclared,
        ),
      ),
    );
  }
}
