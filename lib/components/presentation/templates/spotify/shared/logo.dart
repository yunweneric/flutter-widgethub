import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'constants.dart';

class SpotifyLogo extends StatelessWidget {
  final double? width;
  final double? height;
  const SpotifyLogo({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(SpotifyConstants.spotifyLogo, width: width, height: height);
  }
}
