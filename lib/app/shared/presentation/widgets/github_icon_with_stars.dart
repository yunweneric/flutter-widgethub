import 'package:flutter/material.dart';
import 'package:flutterui/app/shared/data/services/github_service.dart';
import 'package:flutterui/app/shared/presentation/theme/app_tokens.dart';
import 'package:flutterui/app/shared/presentation/theme/app_typography.dart';
import 'package:flutterui/app/shared/presentation/utils/icons.dart';
import 'package:flutterui/app/shared/presentation/utils/util.dart';
import 'package:flutterui/app/shared/presentation/widgets/app_icon_button.dart';
import 'package:flutterui/app/shared/presentation/widgets/icon.dart';

/// Link to the repository, with its star count read inline.
///
/// The count used to be a filled badge pinned over the mark, which covered
/// the logo and shouted louder than the control itself. It now sits beside
/// the mark behind a star glyph, so the pill reads as one label.
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
    final tokens = context.tokens;
    final bool hasCount = !_isLoading && _starCount != null;

    return AppIconButton(
      tooltip: '${widget.owner}/${widget.repo}',
      onPressed: () => UtilHelper.openUrl(widget.url),
      // Square while the count is still in flight, so the pill does not
      // jump the rest of the row sideways when it lands.
      width: hasCount ? null : AppActionSurface.size,
      padding:
          hasCount ? const EdgeInsets.symmetric(horizontal: AppSpace.sm) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(
            icon: AppIcons.github,
            size: widget.iconSize ?? 16,
            color: widget.iconColor,
          ),
          if (hasCount) ...[
            const SizedBox(width: AppSpace.sm),
            Container(width: 1, height: 14, color: tokens.border),
            const SizedBox(width: AppSpace.sm),
            AppIcon(icon: AppIcons.star, size: 13, color: tokens.accent),
            const SizedBox(width: 3),
            Text(
              _formatStarCount(_starCount!),
              style: AppTypography.sans(
                color: tokens.foreground,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
