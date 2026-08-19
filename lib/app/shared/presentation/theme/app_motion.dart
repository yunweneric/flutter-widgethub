/// Motion tokens (LingoDesk design language).
///
/// Three durations do almost all the work. The rule of thumb: the more
/// pixels move, the longer it takes — a colour swap under the pointer is
/// [fast], anything that changes size or position is [standard], and
/// content arriving on screen is [slow].
///
/// Every curve decelerates. Nothing in the app accelerates away from the
/// user, so motion always reads as settling rather than fleeing.
library;

import 'package:flutter/material.dart';

class AppMotion {
  const AppMotion._();

  /// Hover and press feedback: colour, opacity, tint.
  static const fast = Duration(milliseconds: 130);

  /// Layout changes: size, position, elevation, rotation.
  static const standard = Duration(milliseconds: 220);

  /// Entrances, progress fills, counters.
  static const slow = Duration(milliseconds: 420);

  /// Route transitions.
  static const page = Duration(milliseconds: 260);

  /// Delay between siblings in a staggered entrance.
  static const stagger = Duration(milliseconds: 45);

  /// Past this many siblings the stagger stops growing, so a long list
  /// never leaves its tail waiting seconds to appear.
  static const maxStaggerSteps = 8;

  static const curve = Curves.easeOutCubic;

  /// Sharper landing, for entrances and progress fills.
  static const entrance = Curves.easeOutQuart;

  /// Distance an entering element travels, in logical pixels.
  static const enterOffset = 10.0;

  /// How far a hovered card lifts.
  static const hoverLift = 2.0;

  /// Staggered delay for the item at [index].
  static Duration delayFor(int index) =>
      stagger * index.clamp(0, maxStaggerSteps);

  /// False when the platform asks for reduced motion. Entrances and
  /// decorative movement check this and render their end state instead;
  /// state-change feedback (hover, focus) stays, it just stops moving.
  static bool enabled(BuildContext context) =>
      !(MediaQuery.maybeDisableAnimationsOf(context) ?? false);
}
