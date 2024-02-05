import 'package:flutter/widgets.dart';

// const Color primaryColor = Color(0xff21396B);
// const Color secondaryColor = Color(0xffEB8A3A);
// const Color primaryLightColor = Color(0xff375898);
// const Color secondaryLightColor = Color(0xffF6C849);

// const SystemUiOverlayStyle statusbarColor = SystemUiOverlayStyle(
//   statusBarColor: primaryColor,
//   statusBarIconBrightness: Brightness.light,
// );

abstract class CustomColor {
  static Color errorColor = const Color(0xffE21D12);
  static Color successColor = const Color(0xff158444);

  static Color purpleColor = const Color(0xFFC193D5);
  static Color blueColor = const Color(0xff072DF4);
  static Color lightBlueColor = const Color(0xff00C0FF);
  static Color darkGreenColor = const Color(0xff00B232);
  static Color greenColor = const Color(0xff60E000);
  static Color orangeColor = const Color(0xffF4BB00);
  static Color yellowColor = const Color(0xffFFE769);
  static Color whiteColor = const Color(0xffFFFFFF);
  static Color blackColor = const Color(0xFF18191A);
  static Color greyColor = const Color(0xFFBCBACD);
  static Color darkGreyColor = const Color(0xFFB5B5B5);
  static Color backgroundColor = const Color(0xFFf2f2f2);

  // Colors for Bottom Navigation Bar
  static Color activeColor = const Color(0xff072DF4);
  static Color inActiveColor = const Color(0xFF6E7191);

  // Colors on Home
  static Color bankMateri = const Color(0xffFB9055);
  static Color bankSoal = const Color(0xffF4BB00);
  static LinearGradient gradientOutline = const LinearGradient(
    colors: [
      Color(0xff60E000),
      Color(0xfffff500),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static Color dividerColor = const Color.fromRGBO(239, 239, 239, 100);
  static Color onLoadingColor = const Color(0xFFd9d9d9);
}
