import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';
import 'package:flutterui/app/shared/presentation/widgets/ui/app_kbd.dart';
import 'package:flutterui/components/presentation/export/store.dart';
import 'package:go_router/go_router.dart';

/// Search trigger in the nav bar — a ⌘K-style field that opens the
/// command-palette search dialog.
class AppSearchBar extends StatefulWidget {
  const AppSearchBar({super.key});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => showSearchModal(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: AppSizing.isTablet(context) ? 180 : 240,
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.md),
          decoration: BoxDecoration(
            color: _hovered ? tokens.active : tokens.active.withValues(alpha: 0.6),
            borderRadius: AppRadii.mdAll,
            border: Border.all(color: tokens.border),
          ),
          child: Row(
            children: [
              AppIcon(
                  icon: AppIcons.search,
                  size: 14,
                  color: tokens.mutedForeground),
              const SizedBox(width: AppSpace.sm),
              Expanded(
                child: Text(
                  LangUtil.trans("searchComponent"),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.sans(
                    color: tokens.mutedForeground,
                    fontSize: 13,
                    height: 1.0,
                  ),
                ),
              ),
              const SizedBox(width: AppSpace.sm),
              const AppKbd(label: '⌘K'),
            ],
          ),
        ),
      ),
    );
  }
}

/// Opens the command-palette search dialog.
Future<dynamic> showSearchModal(BuildContext context) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    barrierColor: Colors.black.withValues(alpha: 0.5),
    builder: (context) {
      return const SearchBar();
    },
  );
}

/// Command-palette style search dialog (shadcn `cmdk` look).
class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final FocusNode _focusNode;
  final allItems = AllComponents.widgets;
  List<Component> filteredData = [];
  String searchTerm = '';

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    filteredData = allItems;
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void filter(String title) {
    final term = title.toLowerCase().trim();
    final data = term.isEmpty
        ? allItems
        : allItems
            .where((item) =>
                LangUtil.trans(item.title).toLowerCase().contains(term) ||
                LangUtil.trans(item.description).toLowerCase().contains(term) ||
                item.category.describe().toLowerCase().contains(term))
            .toList();
    setState(() {
      searchTerm = title;
      filteredData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final double width = AppSizing.isMobile(context)
        ? AppSizing.kWPercentage(context, 92)
        : 560;

    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(
          top: AppSizing.isMobile(context) ? 80 : 120,
        ),
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: width,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: tokens.popover,
              borderRadius: AppRadii.lgAll,
              border: Border.all(color: tokens.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Input row.
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpace.lg),
                  child: Row(
                    children: [
                      AppIcon(
                        icon: AppIcons.search,
                        size: 16,
                        color: tokens.mutedForeground,
                      ),
                      const SizedBox(width: AppSpace.sm),
                      Expanded(
                        child: TextField(
                          focusNode: _focusNode,
                          onChanged: filter,
                          style: AppTypography.sans(
                            color: tokens.foreground,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: AppSpace.lg),
                            hintText: LangUtil.trans("searchComponent"),
                            hintStyle: AppTypography.sans(
                              color: tokens.mutedForeground,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: const AppKbd(label: 'esc'),
                      ),
                    ],
                  ),
                ),
                Container(height: 1, color: tokens.border),
                // Results.
                Flexible(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: AppSizing.kHPercentage(context, 45),
                    ),
                    child: filteredData.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(AppSpace.xxl),
                            child: Text.rich(
                              TextSpan(
                                text: "'$searchTerm' ",
                                style: AppTypography.sans(
                                  color: tokens.foreground,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  TextSpan(
                                    text: LangUtil.trans(
                                        'notFoundInCollections'),
                                    style: AppTypography.sans(
                                      color: tokens.mutedForeground,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(AppSpace.sm),
                            itemCount: filteredData.length,
                            itemBuilder: (context, index) {
                              final component = filteredData[index];
                              return _SearchResultRow(
                                component: component,
                                onTap: () {
                                  context.pop();
                                  final link =
                                      "/components/${component.category.link()}/${component.subcategory.link()}/${component.id}/";
                                  context.go(link);
                                },
                              );
                            },
                          ),
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

class _SearchResultRow extends StatefulWidget {
  final Component component;
  final VoidCallback onTap;

  const _SearchResultRow({required this.component, required this.onTap});

  @override
  State<_SearchResultRow> createState() => _SearchResultRowState();
}

class _SearchResultRowState extends State<_SearchResultRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.md, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered ? tokens.active : Colors.transparent,
            borderRadius: AppRadii.smAll,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LangUtil.trans(widget.component.title),
                      style: AppTypography.sans(
                        color: tokens.foreground,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      LangUtil.trans(widget.component.description),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.sans(
                        color: tokens.mutedForeground,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpace.md),
              Text(
                widget.component.category.describe(),
                style: AppTypography.sans(
                  color: tokens.mutedForeground,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
