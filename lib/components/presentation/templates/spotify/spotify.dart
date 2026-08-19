import 'package:flutterui/app/shared/data/enums/component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/device_type.dart';
import 'package:flutterui/app/shared/data/enums/sub_component_category_enum.dart';
import 'package:flutterui/app/shared/data/enums/supported_platform.dart';
import 'package:flutterui/app/shared/data/models/code_component.dart';
import 'package:flutterui/app/shared/data/models/component.dart';
import 'package:flutterui/app/shared/presentation/utils/lang_util.dart';

import 'index.dart';

class SpotifyData {
  static String setup = spotifySetup;

  static Component component = Component(
    createdAt: DateTime(2025, 7, 19),
    updatedAt: DateTime(2025, 7, 19),
    id: "spotify-redesign-ui",
    codeComponents: [
      CodeComponent(code: artistScreenCode, widget: const SpotifyArtistScreen()),
      CodeComponent(code: artistScreen2, widget: const SpotifyArtistScreen2()),
      CodeComponent(code: spotifyLyricScreen, widget: const SpotifyLyricScreen()),
      CodeComponent(code: spotifyMusicPlayer, widget: const SpotifyMusicPlayer()),
      CodeComponent(code: spotifyHomepageCode, widget: const SpotifyHomepage()),
      CodeComponent(code: spotifyChooseThemeCode, widget: const SpotifyChooseTheme()),
      CodeComponent(code: spotifyOnboardCode, widget: const SpotifyOnboarding()),
      CodeComponent(code: spotifyLoginCode, widget: const SpotifyLogin()),
      CodeComponent(code: spotifyRegisterCode, widget: const SpotifyRegister()),
      CodeComponent(code: spotifySplashCode, widget: const SpotifySplashScreen()),
    ],
    description: LangUtil.trans('spotifyDescription'),
    title: LangUtil.trans('spotifyTitle'),
    setup: setup,
    category: ComponentCategoryEnum.TEMPLATES,
    subcategory: SubComponentCategoryEnum.APPS,
    supportedPlatforms: [SupportedPlatform.ANDROID, SupportedPlatform.IOS],
    responsiveDevices: [AppDeviceType.MOBILE],
  );
}
