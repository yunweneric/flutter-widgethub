/// The application's icon catalogue.
///
/// Every glyph in the app chrome comes from [Hugeicons](https://hugeicons.com)
/// (stroke-rounded set) so the whole UI shares one stroke weight, corner
/// radius and optical size. The constants below are semantic names — call
/// sites ask for `AppIcons.search`, never for a specific Hugeicons symbol —
/// which keeps a swap of the underlying glyph a one-line change here.
///
/// Render them with `AppIcon`, which inherits its colour from the surrounding
/// [IconTheme] the way Flutter's own `Icon` does.
library;

import 'package:hugeicons/hugeicons.dart';

/// The shape Hugeicons hands back for a single glyph.
///
/// Aliased so widgets can declare `AppIconData` fields without leaking the
/// package's raw `List<List<dynamic>>` representation into every signature.
typedef AppIconData = List<List<dynamic>>;

/// Semantic icon constants used throughout the application.
class AppIcons {
  const AppIcons._();

  // ---------------------------------------------------------------------
  // Navigation & chrome
  // ---------------------------------------------------------------------
  static const AppIconData menu = HugeIcons.strokeRoundedMenu01;
  static const AppIconData search = HugeIcons.strokeRoundedSearch01;
  static const AppIconData close = HugeIcons.strokeRoundedCancel01;
  static const AppIconData back = HugeIcons.strokeRoundedArrowLeft02;
  static const AppIconData next = HugeIcons.strokeRoundedArrowRight02;
  static const AppIconData chevronLeft = HugeIcons.strokeRoundedArrowLeft01;
  static const AppIconData chevronRight = HugeIcons.strokeRoundedArrowRight01;
  static const AppIconData chevronDown = HugeIcons.strokeRoundedArrowDown01;
  static const AppIconData arrowForward = HugeIcons.strokeRoundedArrowRight02;
  static const AppIconData arrowUpRight = HugeIcons.strokeRoundedArrowUpRight01;

  // ---------------------------------------------------------------------
  // Status
  // ---------------------------------------------------------------------
  static const AppIconData check = HugeIcons.strokeRoundedTick02;
  static const AppIconData checkCircle =
      HugeIcons.strokeRoundedCheckmarkCircle02;
  static const AppIconData star = HugeIcons.strokeRoundedStar;
  static const AppIconData flash = HugeIcons.strokeRoundedFlash;
  static const AppIconData notification = HugeIcons.strokeRoundedNotification01;

  // ---------------------------------------------------------------------
  // Docs & code surfaces
  // ---------------------------------------------------------------------
  static const AppIconData code = HugeIcons.strokeRoundedSourceCode;

  /// Preview tab in the component viewer.
  static const AppIconData preview = HugeIcons.strokeRoundedLayout01;
  static const AppIconData clipboard = HugeIcons.strokeRoundedCopy01;
  static const AppIconData link = HugeIcons.strokeRoundedLink02;
  static const AppIconData download = HugeIcons.strokeRoundedDownload04;
  static const AppIconData fullscreen = HugeIcons.strokeRoundedFullScreen;
  static const AppIconData fullscreenExit =
      HugeIcons.strokeRoundedMinimizeScreen;

  // ---------------------------------------------------------------------
  // Component catalogue
  // ---------------------------------------------------------------------
  static const AppIconData blocks = HugeIcons.strokeRoundedGridView;
  static const AppIconData templates = HugeIcons.strokeRoundedDashboardSquare01;
  static const AppIconData diamond = HugeIcons.strokeRoundedDiamond01;
  static const AppIconData card = HugeIcons.strokeRoundedCreditCard;
  static const AppIconData cart = HugeIcons.strokeRoundedShoppingCart01;
  static const AppIconData home = HugeIcons.strokeRoundedHome01;
  static const AppIconData unlocked = HugeIcons.strokeRoundedSquareUnlock01;
  static const AppIconData verified = HugeIcons.strokeRoundedCheckmarkBadge01;
  static const AppIconData touch = HugeIcons.strokeRoundedTouch01;

  // ---------------------------------------------------------------------
  // Money & commerce
  // ---------------------------------------------------------------------
  static const AppIconData send = HugeIcons.strokeRoundedSent;
  static const AppIconData receive = HugeIcons.strokeRoundedDownload04;
  static const AppIconData add = HugeIcons.strokeRoundedAdd01;
  static const AppIconData chip = HugeIcons.strokeRoundedChip;
  static const AppIconData contactless = HugeIcons.strokeRoundedNfc;
  static const AppIconData coffee = HugeIcons.strokeRoundedCoffee02;
  static const AppIconData shoppingBag = HugeIcons.strokeRoundedShoppingBag01;
  static const AppIconData airplane = HugeIcons.strokeRoundedAirplaneTakeOff01;
  static const AppIconData hotel = HugeIcons.strokeRoundedHotel01;
  static const AppIconData coins = HugeIcons.strokeRoundedCoins01;
  static const AppIconData bank = HugeIcons.strokeRoundedBank;

  // ---------------------------------------------------------------------
  // Devices & platforms
  // ---------------------------------------------------------------------
  static const AppIconData mobile = HugeIcons.strokeRoundedSmartPhone01;
  static const AppIconData tablet = HugeIcons.strokeRoundedTablet01;
  static const AppIconData frame = HugeIcons.strokeRoundedDeviceAccess;
  static const AppIconData desktop = HugeIcons.strokeRoundedComputer;
  static const AppIconData web = HugeIcons.strokeRoundedGlobal;
  static const AppIconData android = HugeIcons.strokeRoundedAndroid;
  static const AppIconData apple = HugeIcons.strokeRoundedApple;

  /// Hugeicons ships no Linux mark in the free set; a terminal reads as the
  /// closest neutral stand-in.
  static const AppIconData linux = HugeIcons.strokeRoundedComputerTerminal01;

  // ---------------------------------------------------------------------
  // Theme & locale
  // ---------------------------------------------------------------------
  static const AppIconData sun = HugeIcons.strokeRoundedSun03;
  static const AppIconData moon = HugeIcons.strokeRoundedMoon02;

  // ---------------------------------------------------------------------
  // Social
  // ---------------------------------------------------------------------
  static const AppIconData github = HugeIcons.strokeRoundedGithub;
  static const AppIconData x = HugeIcons.strokeRoundedNewTwitter;
  static const AppIconData linkedIn = HugeIcons.strokeRoundedLinkedin02;
  static const AppIconData tiktok = HugeIcons.strokeRoundedTiktok;
  static const AppIconData youtube = HugeIcons.strokeRoundedYoutube;
  static const AppIconData facebook = HugeIcons.strokeRoundedFacebook01;
  static const AppIconData google = HugeIcons.strokeRoundedGoogle;
  static const AppIconData spotify = HugeIcons.strokeRoundedSpotify;
  static const AppIconData telegram = HugeIcons.strokeRoundedTelegram;
}
