import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/components/ui/export/component_store.dart';
import 'package:flutterui/shared/ui/utils/colors.dart';
import 'package:flutterui/shared/ui/utils/icons.dart';
import 'package:flutterui/shared/ui/utils/sizing.dart';
import 'package:flutterui/shared/ui/widgets/icon.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({super.key});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return AppSizing.isTablet(context)
        ? CircleAvatar(
            backgroundColor: Colors.transparent,
            child: TextButton(
              style: TextButton.styleFrom(fixedSize: Size(25.w, 25.w)),
              onPressed: () => showSearchModal(context),
              child: const AppIcon(icon: AppIcons.search),
            ),
          )
        : SizedBox(
            width: AppSizing.kWPercentage(context, 15),
            child: Transform.scale(
              scale: 0.8,
              child: TextField(
                readOnly: true,
                onTap: () => showSearchModal(context),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  hintText: "Search component...",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AppIcon(icon: AppIcons.search, color: Theme.of(context).highlightColor),
                  ),
                  // suffixIcon: AppIcon(icon:AppIcons.search1, size: 20.w, color: Theme.of(context).highlightColor),
                ),
              ),
            ),
          );
  }
}

showSearchModal(BuildContext context) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    barrierColor: Colors.black.withOpacity(0.8),
    builder: (context) {
      return const SearchBar();
    },
  );
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool isExpanded = false;

  final allItems = AllComponents.widgets;
  List<Component> filteredData = [];
  String? searchTerm;

  void filter(String title) {
    if (isExpanded == false) {
      setState(() => isExpanded = true);
    }

    final term = title.toLowerCase();
    final data = allItems.where((item) => item.title.toLowerCase().contains(term) || item.description.toLowerCase().contains(term)).toList();
    setState(() {
      searchTerm = title;
      filteredData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, child) {
      return Column(
        children: [
          AppSizing.khSpacer(AppSizing.kHPercentage(context, 25)),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: AppSizing.kWPercentage(
                context,
                AppSizing.isMobile(context)
                    ? 80
                    : AppSizing.isTablet(context)
                        ? 50
                        : 35,
              ),
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: Column(
                children: [
                  Material(
                    elevation: 0,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        onChanged: filter,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          hintText: "Search component...",
                          hintStyle: const TextStyle(fontSize: 14),
                          prefixIcon: Transform.scale(
                            scale: 0.4,
                            child: AppIcon(icon: AppIcons.search, color: Theme.of(context).highlightColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Builder(builder: (context) {
                    double heightFactor = 6.5;
                    if (AppSizing.isMobile(context)) heightFactor = 8;
                    if (AppSizing.isTablet(context)) heightFactor = 7;
                    return AnimatedContainer(
                      constraints: BoxConstraints(maxHeight: AppSizing.kHPercentage(context, 80)),
                      height: isExpanded ? AppSizing.kHPercentage(context, filteredData.isEmpty ? 20 : filteredData.length * heightFactor) : 0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        border: BorderDirectional(top: BorderSide(color: Theme.of(context).dividerColor)),
                      ),
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      child: Material(
                        color: Colors.transparent,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: filteredData.isEmpty
                              ? RichText(
                                  text: TextSpan(
                                    text: "'$searchTerm' ",
                                    style: DefaultTextStyle.of(context).style.copyWith(color: Theme.of(context).primaryColor),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'not found in collections',
                                        style: TextStyle(color: Theme.of(context).primaryColorDark),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: filteredData.length,
                                  itemBuilder: (context, index) {
                                    final component = filteredData[index];
                                    return ListTile(
                                      title: Text(
                                        component.title,
                                        style: Theme.of(context).textTheme.displayMedium,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            component.category.describe(),
                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).primaryColor),
                                          ),
                                          Text(
                                            component.description,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.bodySmall,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
