import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'constants.dart';

class SpotifyLogo extends StatelessWidget {
  const SpotifyLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(SpotifyConstants.spotifyLogo);
  }
}
