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
  static Color pinkColor = const Color(0xFFFC4F72);
  static Color blueColor = const Color(0xff072DF4);
  static Color seaBlueColor = const Color(0xFFC9F2FF);
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
  static Color leaderboard = const Color(0xff00B232);
  static Color bankRumus = const Color(0xff0075ff);
  static LinearGradient gradientOutline = const LinearGradient(
    colors: [
      Color(0xff60E000),
      Color(0xfffff500),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static List<BoxShadow> customBoxShadow = [
    const BoxShadow(
      color: Color.fromARGB(6, 0, 0, 0),
      blurRadius: 0,
      spreadRadius: 1,
      offset: Offset(0, 0),
    ),
    const BoxShadow(
      color: Color.fromARGB(6, 0, 0, 0),
      blurRadius: 1,
      spreadRadius: -0.5,
      offset: Offset(0, 1),
    ),
    const BoxShadow(
      color: Color.fromARGB(6, 0, 0, 0),
      blurRadius: 3,
      spreadRadius: -1.5,
      offset: Offset(0, 3),
    ),
    const BoxShadow(
      color: Color.fromARGB(6, 0, 0, 0),
      blurRadius: 6,
      spreadRadius: -3,
      offset: Offset(0, 6),
    ),
    const BoxShadow(
      color: Color.fromARGB(6, 0, 0, 0),
      blurRadius: 12,
      spreadRadius: -6,
      offset: Offset(0, 12),
    ),
    const BoxShadow(
      color: Color.fromARGB(6, 0, 0, 0),
      blurRadius: 24,
      spreadRadius: -12,
      offset: Offset(0, 24),
    ),
  ];

  static Color dividerColor = const Color.fromRGBO(239, 239, 239, 100);
  static Color onLoadingColor = const Color(0xFFd9d9d9);
}
