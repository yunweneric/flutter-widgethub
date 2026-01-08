import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterui/app/core/service_locators.dart';
import 'package:flutterui/app/shared/logic/language_bloc/language_bloc.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';

class LanguageButton extends StatefulWidget {
  const LanguageButton({super.key});

  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}

List<Locale> languages = [
  const Locale("en", "US"),
  const Locale("fr", "FR"),
];

class _LanguageButtonState extends State<LanguageButton> {
  final languageBloc = getIt.get<LanguageBloc>();
  final GlobalKey _buttonKey = GlobalKey();
  bool _isDropdownOpen = false;
  OverlayEntry? _overlayEntry;

  void handleChangeLanguage(Locale locale) {
    // Update the locale in easy_localization
    context.setLocale(locale);
    // Update the bloc state
    languageBloc.add(UpdateAppLanguageEvent(newLocale: locale));
    _closeDropdown();
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    final RenderBox? renderBox =
        _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => BlocBuilder<LanguageBloc, LanguageState>(
        bloc: languageBloc,
        builder: (context, state) => _LanguageDropdownOverlay(
          position: offset,
          buttonSize: size,
          selectedLocale: state.currentLocale,
          languages: languages,
          onLanguageSelected: handleChangeLanguage,
          onDismiss: _closeDropdown,
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isDropdownOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isDropdownOpen = false;
    });
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      bloc: languageBloc,
      builder: (context, state) {
        return GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            key: _buttonKey,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: AppSizing.radiusSm(),
              border: Border.all(
                color: _isDropdownOpen
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).dividerColor,
                width: _isDropdownOpen ? 1.5 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/${state.currentLocale.languageCode}.svg',
                  width: 18.w,
                  height: 18.w,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 6.w),
                Text(
                  state.currentLocale.languageCode.toUpperCase(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  _isDropdownOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 16.w,
                  color: Theme.of(context).iconTheme.color,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Custom dropdown overlay for language selection.
class _LanguageDropdownOverlay extends StatelessWidget {
  final Offset position;
  final Size buttonSize;
  final Locale selectedLocale;
  final List<Locale> languages;
  final void Function(Locale) onLanguageSelected;
  final VoidCallback onDismiss;

  const _LanguageDropdownOverlay({
    required this.position,
    required this.buttonSize,
    required this.selectedLocale,
    required this.languages,
    required this.onLanguageSelected,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onDismiss,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Positioned(
            left: position.dx,
            top: position.dy + buttonSize.height + 4,
            child: Container(
              constraints: BoxConstraints(
                minWidth: buttonSize.width,
                maxHeight: 200.h,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: AppSizing.radiusSm(),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: AppSizing.radiusSm(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: languages.map((locale) {
                    final isSelected = locale.languageCode == selectedLocale.languageCode;
                    return _LanguageItem(
                      locale: locale,
                      isSelected: isSelected,
                      onTap: () {
                        onLanguageSelected(locale);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual language item in the dropdown.
class _LanguageItem extends StatelessWidget {
  final Locale locale;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageItem({
    required this.locale,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/${locale.languageCode}.svg',
              width: 20.w,
              height: 20.w,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10.w),
            Text(
              locale.languageCode.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.bodySmall?.color,
                  ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check,
                size: 16.w,
                color: Theme.of(context).primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
