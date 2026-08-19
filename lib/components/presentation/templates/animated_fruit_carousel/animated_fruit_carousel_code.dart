const animatedFruitCarouselCode = '''import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Base URL for the fruit, can and card artwork used by this template.
const _kFruitAssetBase =
    'https://raw.githubusercontent.com/yunweneric/flutter-open-ui/animated_fruit_carousel/assets/images';

/// An animated fruit carousel with an elastic flavour switch.
///
/// Picking a flavour from the bottom selector re-runs a single elastic
/// animation that drives four things at once: the radial background gradient
/// morphs to the new palette, the flavour name slides in horizontally, the
/// fruit backdrop slides in vertically and the can spins into place. The slide
/// direction follows the direction of travel through the flavour list.
///
/// API Reference:
/// - No public properties (uses internal state)
///
/// Usage:
/// ```dart
/// AnimatedFruitCarouselTemplate()
/// ```
class AnimatedFruitCarouselTemplate extends StatefulWidget {
  const AnimatedFruitCarouselTemplate({super.key});

  @override
  State<AnimatedFruitCarouselTemplate> createState() =>
      _AnimatedFruitCarouselTemplateState();
}

class _AnimatedFruitCarouselTemplateState
    extends State<AnimatedFruitCarouselTemplate>
    with SingleTickerProviderStateMixin {
  static const _duration = Duration(milliseconds: 1600);

  static const _flavours = <_Flavour>[
    _Flavour(
      index: 0,
      title: 'Strawberry',
      color: Color(0xFFFF3D6C),
      light: Color(0xFFFFCCD9),
    ),
    _Flavour(
      index: 1,
      title: 'Orange',
      color: Color(0xFFFFA31E),
      light: Color(0xFFFFE4C1),
    ),
    _Flavour(
      index: 2,
      title: 'Apple',
      color: Color(0xFF7FD925),
      light: Color(0xFFE0FFC1),
    ),
  ];

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _duration,
  );

  /// Runs from 1 (fully off-stage) to 0 (settled) on an elastic curve.
  late final Animation<double> _slide = Tween<double>(begin: 1, end: 0).animate(
    CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
  );

  int _activeIndex = 0;

  /// `1` when moving forward through the flavours, `-1` when moving back.
  double _direction = 1;

  @override
  void initState() {
    super.initState();
    // Play the intro so the first flavour drops in instead of popping in.
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _select(int index) {
    if (index == _activeIndex) return;
    setState(() {
      _direction = index > _activeIndex ? 1 : -1;
      _activeIndex = index;
    });
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final flavour = _flavours[_activeIndex];

    return Scaffold(
      backgroundColor: flavour.color,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          final isCompact = width < 600;

          return Stack(
            fit: StackFit.expand,
            children: [
              AnimatedContainer(
                duration: _duration,
                curve: Curves.easeOutCubic,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.6,
                    colors: [flavour.light, flavour.color],
                  ),
                ),
              ),
              Center(
                child: AnimatedBuilder(
                  animation: _slide,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_direction * width * _slide.value, 0),
                      child: child,
                    );
                  },
                  child: SizedBox(
                    width: width * 0.92,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        flavour.title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.3,
                          fontWeight: FontWeight.w900,
                          height: 1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _slide,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _direction * height * _slide.value),
                    child: child,
                  );
                },
                child: Image.network(
                  '\$_kFruitAssetBase/fruit_\$_activeIndex.png',
                  key: ValueKey('fruit_\$_activeIndex'),
                  fit: BoxFit.cover,
                  height: height,
                  width: width,
                ),
              ),
              Center(
                child: AnimatedBuilder(
                  animation: _slide,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _direction * 0.4 * math.pi * _slide.value,
                      child: child,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: height * 0.08),
                    child: Image.network(
                      '\$_kFruitAssetBase/can_\$_activeIndex.png',
                      key: ValueKey('can_\$_activeIndex'),
                      height: height * 0.55,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    _FruitNavBar(isCompact: isCompact),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(bottom: height * 0.03),
                      child: _FlavourSelector(
                        flavours: _flavours,
                        activeIndex: _activeIndex,
                        width: isCompact ? width * 0.6 : width * 0.3,
                        height: height * 0.14,
                        onSelected: _select,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// A single selectable flavour with its background palette.
class _Flavour {
  final int index;
  final String title;
  final Color color;
  final Color light;

  const _Flavour({
    required this.index,
    required this.title,
    required this.color,
    required this.light,
  });
}

/// Top bar with the brand mark and, on wider layouts, the nav links.
class _FruitNavBar extends StatelessWidget {
  final bool isCompact;

  const _FruitNavBar({required this.isCompact});

  static const _items = ['Home', 'Shop', 'Contact'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Fruits',
            style: GoogleFonts.lobster(
              textStyle: const TextStyle(fontSize: 28, color: Colors.white),
            ),
          ),
          if (!isCompact)
            Row(
              children: _items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          Row(
            children: [
              const Icon(Icons.local_drink_outlined, color: Colors.white),
              if (!isCompact) ...[
                const SizedBox(width: 8),
                const Text(
                  'Choose Your Favorite Drink',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// Bordered row of flavour cards used to drive the carousel.
class _FlavourSelector extends StatelessWidget {
  final List<_Flavour> flavours;
  final int activeIndex;
  final double width;
  final double height;
  final ValueChanged<int> onSelected;

  const _FlavourSelector({
    required this.flavours,
    required this.activeIndex,
    required this.width,
    required this.height,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final borderWidth = width / 100;

    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: borderWidth),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Row(
            children: flavours
                .map(
                  (flavour) => Expanded(
                    child: _FlavourCard(
                      flavour: flavour,
                      isActive: flavour.index == activeIndex,
                      isFirst: flavour.index == 0,
                      isLast: flavour.index == flavours.length - 1,
                      borderWidth: borderWidth,
                      onTap: () => onSelected(flavour.index),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

/// One flavour card, which grows slightly while hovered or selected.
class _FlavourCard extends StatefulWidget {
  final _Flavour flavour;
  final bool isActive;
  final bool isFirst;
  final bool isLast;
  final double borderWidth;
  final VoidCallback onTap;

  const _FlavourCard({
    required this.flavour,
    required this.isActive,
    required this.isFirst,
    required this.isLast,
    required this.borderWidth,
    required this.onTap,
  });

  @override
  State<_FlavourCard> createState() => _FlavourCardState();
}

class _FlavourCardState extends State<_FlavourCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: widget.flavour.color,
            border: BorderDirectional(
              start: widget.isFirst
                  ? BorderSide.none
                  : BorderSide(color: Colors.white, width: widget.borderWidth),
              end: widget.isLast
                  ? BorderSide.none
                  : BorderSide(color: Colors.white, width: widget.borderWidth),
            ),
          ),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 150),
            scale: _isHovered || widget.isActive ? 0.85 : 0.72,
            child: Image.network(
              '\$_kFruitAssetBase/card_\${widget.flavour.index}.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}''';
