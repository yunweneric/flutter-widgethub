import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterui/app/shared/presentation/utils/sizing.dart';
import 'package:flutterui/components/presentation/templates/basuu/shared/utils/basuu_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class BasuuTheme {
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      color: BasuuColors.textWhite,
      fontWeight: FontWeight.w800,
      fontSize: 28.sp,
    ),
    displayMedium: GoogleFonts.inter(
      color: BasuuColors.textWhite,
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
    ),
    displaySmall: GoogleFonts.inter(
      color: BasuuColors.textWhite,
      fontWeight: FontWeight.w600,
      fontSize: 12.sp,
    ),
    bodyMedium: GoogleFonts.inter(
      color: BasuuColors.textWhite,
      fontWeight: FontWeight.normal,
      fontSize: 14.sp,
      height: 1.5.h,
      letterSpacing: 0.1,
    ),
    bodySmall: GoogleFonts.inter(
      color: BasuuColors.textWhite,
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
    ),
    labelMedium: GoogleFonts.inter(
      color: BasuuColors.textGrey,
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
    ),
    labelSmall: GoogleFonts.inter(
      color: BasuuColors.textGrey,
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      letterSpacing: 0,
    ),
  );

  static InputDecorationTheme lightInputDecoration = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
    labelStyle: TextStyle(
        color: BasuuColors.textGrey, fontSize: 16.sp, fontWeight: FontWeight.w400),
    hintStyle: TextStyle(
        color: BasuuColors.textGrey, fontSize: 16.sp, fontWeight: FontWeight.w400),
    floatingLabelStyle: TextStyle(color: BasuuColors.textGrey, fontSize: 12.sp),
    errorStyle: TextStyle(color: BasuuColors.red, fontSize: 11.sp),
    border: AppSizing.mainBorder(BasuuColors.bgGray),
    enabledBorder: AppSizing.mainBorder(BasuuColors.bgGray),
    focusedBorder: AppSizing.mainFocusBorder(),
    focusedErrorBorder: AppSizing.focusedErrorBorder(),
    errorBorder: AppSizing.errorBorder(),
  );

  static InputDecorationTheme darkInputDecoration = InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
    labelStyle: TextStyle(
        color: BasuuColors.textGrey, fontSize: 16.sp, fontWeight: FontWeight.w400),
    hintStyle: TextStyle(
        color: BasuuColors.textGrey, fontSize: 16.sp, fontWeight: FontWeight.w400),
    floatingLabelStyle: TextStyle(color: BasuuColors.textGrey, fontSize: 12.sp),
    errorStyle: TextStyle(color: BasuuColors.red, fontSize: 11.sp),
    border: AppSizing.mainBorder(BasuuColors.bgGray3),
    enabledBorder: AppSizing.mainBorder(BasuuColors.bgGray3),
    focusedBorder: AppSizing.mainFocusBorder(),
    errorBorder: AppSizing.errorBorder(),
    focusedErrorBorder: AppSizing.focusedErrorBorder(),
  );

  static ThemeData dark() {
    return ThemeData(
      primaryColor: BasuuColors.primary,
      scaffoldBackgroundColor: BasuuColors.bgDark,
      primaryColorDark: BasuuColors.textWhite,
      primaryColorLight: BasuuColors.textBlack,
      cardColor: BasuuColors.bgCardDark,
      colorScheme:
          const ColorScheme.dark(primary: BasuuColors.primary, error: BasuuColors.red),
      cardTheme: const CardThemeData(color: BasuuColors.bgCardDark),
      textTheme: darkTextTheme,
      dividerColor: BasuuColors.bgCardDark,
      highlightColor: BasuuColors.bgGray,
      inputDecorationTheme: darkInputDecoration,
      appBarTheme: AppBarTheme(
        backgroundColor: BasuuColors.bgDark,
        surfaceTintColor: BasuuColors.bgDark,
        titleTextStyle: GoogleFonts.inter(
          color: BasuuColors.textWhite,
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
        elevation: 20,
      ),
      iconTheme: IconThemeData(color: BasuuColors.textGrey, size: 20.w),
      primaryIconTheme: IconThemeData(color: BasuuColors.textGrey, size: 20.w),
      chipTheme: ChipThemeData(
        backgroundColor: BasuuColors.bgCardDark,
        side: const BorderSide(color: BasuuColors.bgCardDark, width: 1),
        selectedColor: BasuuColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
        labelStyle: TextStyle(fontSize: 12.sp, color: BasuuColors.textWhite),
      ),
      dividerTheme: const DividerThemeData(color: BasuuColors.bgGray2),
      dialogTheme: const DialogThemeData(backgroundColor: BasuuColors.bgCardDark),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 10.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          textStyle: darkTextTheme.bodySmall,
          iconColor: BasuuColors.bgGray,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 10.w),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          backgroundColor: BasuuColors.bgCardDark,
          textStyle: darkTextTheme.bodySmall,
          iconColor: BasuuColors.bgGray,
        ),
      ),
    );
  }
}
