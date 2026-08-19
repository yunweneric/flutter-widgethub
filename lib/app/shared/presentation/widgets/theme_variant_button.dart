import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/theme/theme_bloc.dart';
import 'package:flutterui/app/shared/presentation/theme/app_motion.dart';
import 'package:flutterui/app/shared/presentation/theme/app_palette.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_icon_button.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

/// The single theme control: one popover for brightness mode
/// (light / dark / system) and the six palette variants.
class ThemeControlButton extends StatefulWidget {
  const ThemeControlButton({super.key});

  @override
  State<ThemeControlButton> createState() => _ThemeControlButtonState();
}

class _ThemeControlButtonState extends State<ThemeControlButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final themeBloc = getIt.get<ThemeBloc>();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final tokens = context.tokens;
        return PopupMenuButton<AppThemeVariant>(
          tooltip: '',
          offset: const Offset(0, 48),
          onSelected: (variant) =>
              themeBloc.add(ChangeThemeVariant(variant: variant)),
          itemBuilder: (context) => [
            // Brightness modes — interactive row, does not close the menu.
            PopupMenuItem<AppThemeVariant>(
              enabled: false,
              height: 48,
              child: BlocBuilder<ThemeBloc, ThemeState>(
                bloc: themeBloc,
                builder: (context, state) {
                  return Row(
                    children: [
                      _ModeButton(
                        icon: AppIcons.sun,
                        label: LangUtil.trans("light"),
                        isActive: state.themeMode == ThemeMode.light,
                        tokens: tokens,
                        onTap: () => themeBloc
                            .add(ChangeTheme(themeMode: ThemeMode.light)),
                      ),
                      const SizedBox(width: AppSpace.xs),
                      _ModeButton(
                        icon: AppIcons.moon,
                        label: LangUtil.trans("dark"),
                        isActive: state.themeMode == ThemeMode.dark,
                        tokens: tokens,
                        onTap: () => themeBloc
                            .add(ChangeTheme(themeMode: ThemeMode.dark)),
                      ),
                      const SizedBox(width: AppSpace.xs),
                      _ModeButton(
                        icon: AppIcons.desktop,
                        label: LangUtil.trans("system"),
                        isActive: state.themeMode == ThemeMode.system,
                        tokens: tokens,
                        onTap: () => themeBloc
                            .add(ChangeTheme(themeMode: ThemeMode.system)),
                      ),
                    ],
                  );
                },
              ),
            ),
            const PopupMenuDivider(),
            ...AppThemeVariant.values.map(
              (variant) => PopupMenuItem<AppThemeVariant>(
                value: variant,
                height: 52,
                child: _VariantRow(
                  variant: variant,
                  isDark: isDark,
                  selected: variant == state.variant,
                  tokens: tokens,
                ),
              ),
            ),
          ],
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: AnimatedContainer(
              duration: AppMotion.fast,
              curve: Curves.easeOut,
              width: AppActionSurface.size,
              height: AppActionSurface.size,
              alignment: Alignment.center,
              decoration:
                  AppActionSurface.decoration(tokens, hovered: _hovered),
              // Mode glyph carries the control; the active variant is told
              // by a brand dot ringed in the surface colour, rather than a
              // flat swatch with a bubble hanging off the corner.
              child: SizedBox(
                width: 22,
                height: 22,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: AppIcon(
                        icon: isDark ? AppIcons.moon : AppIcons.sun,
                        size: 16,
                        color: AppActionSurface.foreground(tokens,
                            hovered: _hovered),
                      ),
                    ),
                    Positioned(
                      right: -1,
                      bottom: -1,
                      child: _Swatch(
                        color: tokens.brand,
                        size: 9,
                        ring: AppActionSurface.fill(tokens, hovered: _hovered),
                        ringWidth: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ModeButton extends StatefulWidget {
  final AppIconData icon;
  final String label;
  final bool isActive;
  final AppTokens tokens;
  final VoidCallback onTap;

  const _ModeButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.tokens,
    required this.onTap,
  });

  @override
  State<_ModeButton> createState() => _ModeButtonState();
}

class _ModeButtonState extends State<_ModeButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final t = widget.tokens;
    final Color fg = widget.isActive ? t.onBrandFill : t.muted;
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: AppMotion.fast,
            padding: const EdgeInsets.symmetric(vertical: 7),
            decoration: BoxDecoration(
              color: widget.isActive
                  ? t.brandFill
                  : _hovered
                      ? t.active
                      : Colors.transparent,
              borderRadius: AppRadii.smAll,
              border: Border.all(
                color: widget.isActive ? t.brandFillBorder : Colors.transparent,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(icon: widget.icon, size: 13, color: fg),
                const SizedBox(height: 2),
                Text(
                  widget.label,
                  style: AppTypography.sans(
                    color: fg,
                    fontSize: 10,
                    fontWeight:
                        widget.isActive ? FontWeight.w700 : FontWeight.w600,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VariantRow extends StatelessWidget {
  final AppThemeVariant variant;
  final bool isDark;
  final bool selected;
  final AppTokens tokens;

  const _VariantRow({
    required this.variant,
    required this.isDark,
    required this.selected,
    required this.tokens,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = AppPalettes.of(variant).scheme(isDark);
    return Row(
      children: [
        _Swatch(color: scheme.brand, size: 18, ring: tokens.border),
        const SizedBox(width: AppSpace.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                variant.label,
                style: AppTypography.sans(
                  color: tokens.foreground,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              Text(
                variant.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.sans(
                  color: tokens.muted,
                  fontSize: 11,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        if (selected) ...[
          const SizedBox(width: AppSpace.sm),
          AppIcon(icon: AppIcons.check, size: 14, color: tokens.accent),
        ],
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  final Color color;
  final double size;
  final Color ring;
  final double ringWidth;

  const _Swatch({
    required this.color,
    required this.size,
    required this.ring,
    this.ringWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: ring, width: ringWidth),
      ),
    );
  }
}
