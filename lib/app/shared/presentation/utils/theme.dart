/// Application theme configuration.
///
/// Defines light and dark theme configurations including colors, text styles,
/// and component themes for the entire application.
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/shared/presentation/utils/colors.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:google_fonts/google_fonts.dart';

/// Theme configuration class.
///
/// Provides static methods to create light and dark [ThemeData] instances
/// with consistent styling across the application.
class AppTheme {
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      color: AppColors.textBlack,
      fontWeight: FontWeight.w800,
      fontSize: 30.sp,
    ),
    displayMedium: GoogleFonts.inter(
      color: AppColors.textBlack,
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
    ),
    displaySmall: GoogleFonts.inter(
      color: AppColors.textBlack,
      fontWeight: FontWeight.w600,
      fontSize: 12.sp,
    ),
    bodyMedium: GoogleFonts.inter(
      color: AppColors.textGrey,
      fontSize: 14.sp,
      height: 1.5,
      letterSpacing: 0.1,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: GoogleFonts.inter(
      color: AppColors.textGrey,
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
    ),
    labelMedium: GoogleFonts.inter(
      color: AppColors.textGrey,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
    ),
    labelSmall: GoogleFonts.inter(
      color: AppColors.textGrey,
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      letterSpacing: 0,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      color: AppColors.textWhite,
      fontWeight: FontWeight.w800,
      fontSize: 30.sp,
    ),
    displayMedium: GoogleFonts.inter(
      color: AppColors.textWhite,
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
    ),
    displaySmall: GoogleFonts.inter(
      color: AppColors.textWhite,
      fontWeight: FontWeight.w600,
      fontSize: 12.sp,
    ),
    bodyMedium: GoogleFonts.inter(
      color: AppColors.textGrey,
      fontWeight: FontWeight.normal,
      fontSize: 14.sp,
      height: 1.5.h,
      letterSpacing: 0.1,
    ),
    bodySmall: GoogleFonts.inter(
      color: AppColors.textGrey,
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
    ),
    labelMedium: GoogleFonts.inter(
      color: AppColors.textGrey,
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
    ),
    labelSmall: GoogleFonts.inter(
      color: AppColors.textGrey,
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      letterSpacing: 0,
    ),
  );

  static InputDecorationTheme lightInputDecoration = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
    labelStyle: TextStyle(
        color: AppColors.textGrey, fontSize: 16.sp, fontWeight: FontWeight.w400),
    hintStyle: TextStyle(
        color: AppColors.textGrey, fontSize: 16.sp, fontWeight: FontWeight.w400),
    floatingLabelStyle: TextStyle(color: AppColors.textGrey, fontSize: 12.sp),
    errorStyle: TextStyle(color: AppColors.red, fontSize: 11.sp),
    border: AppSizing.mainBorder(AppColors.bgGray),
    enabledBorder: AppSizing.mainBorder(AppColors.bgGray),
    focusedBorder: AppSizing.mainFocusBorder(),
    focusedErrorBorder: AppSizing.focusedErrorBorder(),
    errorBorder: AppSizing.errorBorder(),
  );

  static InputDecorationTheme darkInputDecoration = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
    labelStyle: TextStyle(
        color: AppColors.textGrey, fontSize: 16.sp, fontWeight: FontWeight.w400),
    hintStyle: TextStyle(
        color: AppColors.textGrey, fontSize: 16.sp, fontWeight: FontWeight.w400),
    floatingLabelStyle: TextStyle(color: AppColors.textGrey, fontSize: 12.sp),
    errorStyle: TextStyle(color: AppColors.red, fontSize: 11.sp),
    border: AppSizing.mainBorder(AppColors.bgGray3),
    enabledBorder: AppSizing.mainBorder(AppColors.bgGray3),
    focusedBorder: AppSizing.mainFocusBorder(),
    errorBorder: AppSizing.errorBorder(),
    focusedErrorBorder: AppSizing.focusedErrorBorder(),
  );

  static ThemeData light() {
    return ThemeData(
      colorScheme:
          const ColorScheme.light(primary: AppColors.primary, error: AppColors.red),
      primaryColor: AppColors.primary,
      primaryColorDark: AppColors.textBlack,
      primaryColorLight: AppColors.textWhite,
      scaffoldBackgroundColor: AppColors.bg,
      cardTheme: const CardThemeData(color: AppColors.cardColor),
      highlightColor: AppColors.bgGray,
      cardColor: AppColors.cardColor,
      textTheme: lightTextTheme,
      inputDecorationTheme: lightInputDecoration,
      dividerColor: AppColors.bgGray2.withValues(alpha: 0.3),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bg,
        titleTextStyle: GoogleFonts.inter(
            color: AppColors.textBlack, fontWeight: FontWeight.w500, fontSize: 20.sp),
        elevation: 0,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
          textStyle: lightTextTheme.bodySmall,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          backgroundColor: AppColors.cardColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.cardColor,
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          textStyle: lightTextTheme.bodySmall,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.textGrey,
        // side: const BorderSide(color: AppColors.bgGray2, width: 1),
        side: const BorderSide(color: Colors.transparent, width: 1),
        selectedColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        labelStyle: TextStyle(fontSize: 12.sp, color: AppColors.textBlack),
        elevation: 0,
        pressElevation: 0,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.bgGray2),
      dialogTheme: const DialogThemeData(backgroundColor: AppColors.cardColor),
      iconTheme: IconThemeData(color: AppColors.textGrey, size: 20.w),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.bgDark,
      primaryColorDark: AppColors.bgGray,
      primaryColorLight: AppColors.textBlack,
      cardColor: AppColors.bgCardDark,
      colorScheme:
          const ColorScheme.dark(primary: AppColors.primary, error: AppColors.red),
      cardTheme: const CardThemeData(color: AppColors.bgCardDark),
      textTheme: darkTextTheme,
      dividerColor: AppColors.bgCardDark,
      highlightColor: AppColors.bgGray,
      inputDecorationTheme: darkInputDecoration,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.bgDark,
        titleTextStyle: GoogleFonts.inter(
          color: AppColors.textWhite,
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
        elevation: 20,
      ),
      iconTheme: IconThemeData(color: AppColors.textGrey, size: 20.w),
      primaryIconTheme: IconThemeData(color: AppColors.textGrey, size: 20.w),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.bgCardDark,
        side: const BorderSide(color: AppColors.bgCardDark, width: 1),
        selectedColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        labelStyle: TextStyle(fontSize: 12.sp, color: AppColors.textWhite),
        elevation: 0,
        pressElevation: 0,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.bgGray2),
      dialogTheme: const DialogThemeData(backgroundColor: AppColors.bgCardDark),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          textStyle: darkTextTheme.bodySmall,
          backgroundColor: AppColors.bgCardDark,
          iconColor: AppColors.bgGray,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          backgroundColor: AppColors.bgCardDark,
          textStyle: darkTextTheme.bodySmall,
          iconColor: AppColors.bgGray,
        ),
      ),
    );
  }
}
