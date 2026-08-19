/// Interactive "code ↔ preview" showcase used on the landing page.
///
/// One bordered card split into two panes: a live device preview on the
/// left (with card switcher) and the always-dark source panel on the
/// right. Panes share a fixed height so the card never grows with the
/// snippet, and the code area scrolls inside its own pane.
///
/// The app running inside the device is a small wallet: three cards, an
/// animated balance, quick actions and a per-card activity feed. Selection
/// is driven either from the pane header or from the bar inside the phone,
/// which is the point the section makes — real state, real widgets.
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

/// One line in a card's activity feed.
class _Txn {
  final AppIconData icon;
  final String labelKey;
  final String dayKey;
  final String time;
  final String amount;
  final bool incoming;

  const _Txn({
    required this.icon,
    required this.labelKey,
    required this.dayKey,
    required this.time,
    required this.amount,
    this.incoming = false,
  });
}

/// One selectable card in the wallet demo.
class _WalletCard {
  final String nameKey;
  final AppIconData icon;

  /// Drives the pane glow, the card gradient and every accented detail.
  final Color accent;

  /// Deep end of the card gradient.
  final Color accentDeep;
  final String last4;
  final double balance;
  final String delta;
  final List<_Txn> activity;

  const _WalletCard({
    required this.nameKey,
    required this.icon,
    required this.accent,
    required this.accentDeep,
    required this.last4,
    required this.balance,
    required this.delta,
    required this.activity,
  });
}

const List<_WalletCard> _cards = [
  _WalletCard(
    nameKey: 'walletCardEveryday',
    icon: AppIcons.card,
    accent: Color(0xFFE11D48),
    accentDeep: Color(0xFF7F1D3A),
    last4: '4921',
    balance: 2480.55,
    delta: '+2.4%',
    activity: [
      _Txn(
        icon: AppIcons.coffee,
        labelKey: 'walletTxnCoffee',
        dayKey: 'walletToday',
        time: '09:24',
        amount: '4.80',
      ),
      _Txn(
        icon: AppIcons.shoppingBag,
        labelKey: 'walletTxnGroceries',
        dayKey: 'walletYesterday',
        time: '18:02',
        amount: '62.10',
      ),
    ],
  ),
  _WalletCard(
    nameKey: 'walletCardTravel',
    icon: AppIcons.airplane,
    accent: Color(0xFF0D9488),
    accentDeep: Color(0xFF0B4A45),
    last4: '7364',
    balance: 1264.00,
    delta: '+1.1%',
    activity: [
      _Txn(
        icon: AppIcons.airplane,
        labelKey: 'walletTxnFlight',
        dayKey: 'walletToday',
        time: '07:40',
        amount: '318.00',
      ),
      _Txn(
        icon: AppIcons.hotel,
        labelKey: 'walletTxnHotel',
        dayKey: 'walletYesterday',
        time: '21:15',
        amount: '154.00',
      ),
    ],
  ),
  _WalletCard(
    nameKey: 'walletCardSavings',
    icon: AppIcons.coins,
    accent: Color(0xFF2563EB),
    accentDeep: Color(0xFF11255F),
    last4: '1085',
    balance: 12940.00,
    delta: '+5.8%',
    activity: [
      _Txn(
        icon: AppIcons.coins,
        labelKey: 'walletTxnInterest',
        dayKey: 'walletToday',
        time: '00:05',
        amount: '18.40',
        incoming: true,
      ),
      _Txn(
        icon: AppIcons.bank,
        labelKey: 'walletTxnDeposit',
        dayKey: 'walletYesterday',
        time: '08:00',
        amount: '500.00',
        incoming: true,
      ),
    ],
  ),
];

/// Cardholder shown on the plastic — demo data, deliberately generic.
const String _holder = 'AMARA OKAFOR';
const String _expiry = '12/28';

/// `1234.5` → `$1,234.50`, without pulling in `intl` for one label.
String _money(double value) {
  final parts = value.toStringAsFixed(2).split('.');
  final digits = parts.first;
  final buffer = StringBuffer();
  for (int i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  return '\$$buffer.${parts.last}';
}

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
          title: 'wallet_cards.dart',
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

/// Left pane: header with card switcher over a live device.
class _PreviewPane extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onSelected;

  const _PreviewPane({required this.currentIndex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final Color accent = _cards[currentIndex].accent;

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
              _CardSwitcher(
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
                          child: _WalletApp(
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

/// The three cards as swatches in the pane header — the same state the
/// phone's bottom bar drives.
class _CardSwitcher extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onSelected;

  const _CardSwitcher({required this.currentIndex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_cards.length, (i) {
        final Color accent = _cards[i].accent;
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
                        LangUtil.trans(_cards[i].nameKey).toUpperCase(),
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

/// The little wallet running inside the device frame.
class _WalletApp extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onSelected;

  const _WalletApp({required this.currentIndex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final _WalletCard card = _cards[currentIndex];

    return Scaffold(
      backgroundColor: tokens.background,
      body: SafeArea(
        bottom: false,
        // Scrolls rather than overflows when the viewer picks a shorter
        // device from the frame selector.
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
              AppSpace.xl, AppSpace.lg, AppSpace.xl, AppSpace.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const _WalletHeader(),
              const SizedBox(height: AppSpace.xl),
              AspectRatio(
                aspectRatio: 1.62,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 520),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.14, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
                  child: _PlasticCard(
                    key: ValueKey(currentIndex),
                    card: card,
                  ),
                ),
              ),
              const SizedBox(height: AppSpace.xl),
              _BalanceBlock(card: card, index: currentIndex),
              const SizedBox(height: AppSpace.xl),
              _QuickActions(accent: card.accent),
              const SizedBox(height: AppSpace.xl),
              Text(
                LangUtil.trans('walletActivity'),
                style: AppTypography.sans(
                  color: tokens.foreground,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppSpace.md),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 420),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.12),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: Column(
                  key: ValueKey(currentIndex),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < card.activity.length; i++) ...[
                      if (i > 0) const SizedBox(height: AppSpace.lg),
                      _TxnRow(txn: card.activity[i], accent: card.accent),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _WalletBar(
        currentIndex: currentIndex,
        onSelected: onSelected,
      ),
    );
  }
}

/// Greeting row: avatar, name, notification bell.
class _WalletHeader extends StatelessWidget {
  const _WalletHeader();

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tokens.brandFill,
            shape: BoxShape.circle,
            border: Border.all(color: tokens.brandFillBorder),
          ),
          child: Text(
            'AO',
            style: AppTypography.sans(
              color: tokens.onBrandFill,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: AppSpace.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LangUtil.trans('walletGreeting'),
                style: AppTypography.sans(
                  color: tokens.muted,
                  fontSize: 12,
                  height: 1.2,
                ),
              ),
              Text(
                'Amara',
                style: AppTypography.sans(
                  color: tokens.foreground,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tokens.card,
            shape: BoxShape.circle,
            border: Border.all(color: tokens.border),
          ),
          child: AppIcon(
            icon: AppIcons.notification,
            size: 17,
            color: tokens.foreground,
          ),
        ),
      ],
    );
  }
}

/// The card itself: gradient plastic with chip, masked number and holder.
class _PlasticCard extends StatelessWidget {
  final _WalletCard card;

  const _PlasticCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.xl),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [card.accent, card.accentDeep],
        ),
        boxShadow: [
          BoxShadow(
            color: card.accent.withValues(alpha: 0.34),
            blurRadius: 28,
            spreadRadius: -6,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Two soft discs give the plastic some depth.
          Positioned(
            top: -60,
            right: -30,
            child: const _Disc(size: 150, color: AppColors.textWhite),
          ),
          Positioned(
            bottom: -70,
            right: 40,
            child: const _Disc(size: 130, color: AppColors.textWhite),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpace.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LangUtil.trans(card.nameKey).toUpperCase(),
                      style: AppTypography.sans(
                        color: AppColors.textWhite.withValues(alpha: 0.85),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4,
                      ),
                    ),
                    AppIcon(
                      icon: AppIcons.contactless,
                      size: 18,
                      color: AppColors.textWhite.withValues(alpha: 0.85),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpace.lg),
                AppIcon(
                  icon: AppIcons.chip,
                  size: 26,
                  color: AppColors.textWhite.withValues(alpha: 0.9),
                ),
                const Spacer(),
                Text(
                  '••••  ••••  ••••  ${card.last4}',
                  style: AppTypography.mono(
                    color: AppColors.textWhite,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSpace.md),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        _holder,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.sans(
                          color: AppColors.textWhite.withValues(alpha: 0.9),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                    Text(
                      _expiry,
                      style: AppTypography.sans(
                        color: AppColors.textWhite.withValues(alpha: 0.75),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(width: AppSpace.md),
                    // Two overlapping rings, the way payment marks read.
                    SizedBox(
                      width: 34,
                      height: 20,
                      child: Stack(
                        children: [
                          const Positioned(left: 0, child: _Ring()),
                          const Positioned(
                              right: 0, child: _Ring(opacity: 0.55)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Faint disc used as card texture.
class _Disc extends StatelessWidget {
  final double size;
  final Color color;

  const _Disc({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.08),
      ),
    );
  }
}

/// One circle of the payment mark on the card.
class _Ring extends StatelessWidget {
  final double opacity;

  const _Ring({this.opacity = 0.85});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.textWhite.withValues(alpha: opacity * 0.35),
        border: Border.all(
          color: AppColors.textWhite.withValues(alpha: opacity),
        ),
      ),
    );
  }
}

/// Balance label, counted-up amount and the week's delta.
class _BalanceBlock extends StatelessWidget {
  final _WalletCard card;
  final int index;

  const _BalanceBlock({required this.card, required this.index});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LangUtil.trans('walletBalance'),
                style: AppTypography.sans(
                  color: tokens.muted,
                  fontSize: 12,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 2),
              // Counts up from zero every time the card changes.
              TweenAnimationBuilder<double>(
                key: ValueKey(index),
                tween: Tween<double>(begin: 0, end: card.balance),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) => Text(
                  _money(value),
                  style: AppTypography.sans(
                    color: tokens.foreground,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                    letterSpacing: -0.6,
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 420),
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.sm, vertical: AppSpace.xs),
          decoration: BoxDecoration(
            color: card.accent.withValues(alpha: 0.14),
            borderRadius: AppRadii.smAll,
          ),
          child: Text(
            card.delta,
            style: AppTypography.sans(
              color: card.accent,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}

/// Send / request / top up.
class _QuickActions extends StatelessWidget {
  final Color accent;

  const _QuickActions({required this.accent});

  @override
  Widget build(BuildContext context) {
    const actions = <(AppIconData, String)>[
      (AppIcons.send, 'walletSend'),
      (AppIcons.receive, 'walletRequest'),
      (AppIcons.add, 'walletTopUp'),
    ];

    return Row(
      children: [
        for (int i = 0; i < actions.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSpace.md),
          Expanded(
            child: _ActionTile(
              icon: actions[i].$1,
              labelKey: actions[i].$2,
              accent: accent,
            ),
          ),
        ],
      ],
    );
  }
}

/// One bordered quick-action tile.
class _ActionTile extends StatelessWidget {
  final AppIconData icon;
  final String labelKey;
  final Color accent;

  const _ActionTile({
    required this.icon,
    required this.labelKey,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.md),
      decoration: BoxDecoration(
        color: tokens.card,
        borderRadius: AppRadii.mdAll,
        border: Border.all(color: tokens.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(icon: icon, size: 19, color: accent),
          const SizedBox(height: 6),
          Text(
            LangUtil.trans(labelKey),
            style: AppTypography.sans(
              color: tokens.foreground,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

/// One line of the activity feed.
class _TxnRow extends StatelessWidget {
  final _Txn txn;
  final Color accent;

  const _TxnRow({required this.txn, required this.accent});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final Color amountColor = txn.incoming ? accent : tokens.foreground;

    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: AppRadii.mdAll,
          ),
          child: AppIcon(icon: txn.icon, size: 17, color: accent),
        ),
        const SizedBox(width: AppSpace.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                LangUtil.trans(txn.labelKey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.sans(
                  color: tokens.foreground,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.25,
                ),
              ),
              Text(
                '${LangUtil.trans(txn.dayKey)} · ${txn.time}',
                style: AppTypography.sans(
                  color: tokens.muted,
                  fontSize: 11.5,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        Text(
          '${txn.incoming ? '+' : '−'}\$${txn.amount}',
          style: AppTypography.sans(
            color: amountColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

/// The bar inside the phone — switches cards, and the whole preview with it.
class _WalletBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onSelected;

  const _WalletBar({required this.currentIndex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final Color accent = _cards[currentIndex].accent;

    return Container(
      decoration: BoxDecoration(
        color: tokens.card,
        border: Border(top: BorderSide(color: tokens.border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: List.generate(_cards.length, (i) {
            final bool active = i == currentIndex;

            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onSelected(i),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: AppSpace.md),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Active marker, sliding into place with the colour.
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 260),
                        curve: Curves.easeOut,
                        width: active ? 26 : 0,
                        height: 3,
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppIcon(
                        icon: _cards[i].icon,
                        size: 20,
                        color: active ? accent : tokens.muted,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        LangUtil.trans(_cards[i].nameKey),
                        style: AppTypography.sans(
                          color: active ? accent : tokens.muted,
                          fontSize: 11,
                          fontWeight:
                              active ? FontWeight.w700 : FontWeight.w500,
                          height: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
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

/// Snippet shown in the code pane — a trimmed version of the wallet
/// rendered in the preview.
const sampleCode = '''import 'package:flutter/material.dart';

/// Wallet cards: pick a card, the balance and feed follow.
class WalletCards extends StatefulWidget {
  const WalletCards({super.key});

  @override
  State<WalletCards> createState() => _WalletCardsState();
}

class _WalletCardsState extends State<WalletCards> {
  static const cards = [
    (Color(0xFFE11D48), 'Everyday', '4921', 2480.55, Icons.credit_card),
    (Color(0xFF0D9488), 'Travel', '7364', 1264.00, Icons.flight_takeoff),
    (Color(0xFF2563EB), 'Savings', '1085', 12940.00, Icons.savings_outlined),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final (accent, name, last4, balance, _) = cards[currentIndex];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.62,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 520),
                  switchInCurve: Curves.easeOutCubic,
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.14, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
                  child: PlasticCard(
                    key: ValueKey(currentIndex),
                    accent: accent,
                    name: name,
                    last4: last4,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Counts up from zero every time the card changes.
              TweenAnimationBuilder<double>(
                key: ValueKey(currentIndex),
                tween: Tween<double>(begin: 0, end: balance),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) => Text(
                  '\\\$\${value.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              QuickActions(accent: accent),
              const SizedBox(height: 24),
              Expanded(child: ActivityFeed(card: currentIndex, accent: accent)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) =>
            setState(() => currentIndex = index),
        destinations: [
          for (final (_, name, _, _, icon) in cards)
            NavigationDestination(icon: Icon(icon), label: name),
        ],
      ),
    );
  }
}
''';
