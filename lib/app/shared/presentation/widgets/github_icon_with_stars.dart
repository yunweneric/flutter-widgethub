import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/shared/data/services/github_service.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

/// Widget that displays a GitHub icon with a badge showing the repository star count.
class GitHubIconWithStars extends StatefulWidget {
  final String owner;
  final String repo;
  final String url;
  final double? iconSize;
  final Color? iconColor;

  const GitHubIconWithStars({
    super.key,
    required this.owner,
    required this.repo,
    required this.url,
    this.iconSize,
    this.iconColor,
  });

  @override
  State<GitHubIconWithStars> createState() => _GitHubIconWithStarsState();
}

class _GitHubIconWithStarsState extends State<GitHubIconWithStars> {
  int? _starCount;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchStarCount();
  }

  Future<void> _fetchStarCount() async {
    final count = await GitHubService.getStarCount(widget.owner, widget.repo);
    if (mounted) {
      setState(() {
        _starCount = count;
        _isLoading = false;
      });
    }
  }

  String _formatStarCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => UtilHelper.openUrl(widget.url),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: Theme.of(context).cardColor,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AppIcon(
            icon: AppIcons.github,
            size: widget.iconSize,
            color: widget.iconColor,
          ),
          if (!_isLoading && _starCount != null)
            Positioned(
              right: -6.w,
              top: -6.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 1.5,
                  ),
                ),
                constraints: BoxConstraints(
                  minWidth: 16.w,
                  minHeight: 12.h,
                ),
                child: Center(
                  child: Text(
                    _formatStarCount(_starCount!),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
