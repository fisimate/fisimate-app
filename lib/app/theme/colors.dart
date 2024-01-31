import 'package:flutter/services.dart';

// const Color primaryColor = Color(0xff21396B);
// const Color secondaryColor = Color(0xffEB8A3A);
// const Color primaryLightColor = Color(0xff375898);
// const Color secondaryLightColor = Color(0xffF6C849);

// const SystemUiOverlayStyle statusbarColor = SystemUiOverlayStyle(
//   statusBarColor: primaryColor,
//   statusBarIconBrightness: Brightness.light,
// );

abstract class CustomColor {
  Color errorColor = const Color(0xffE21D12);
  Color successColor = const Color(0xff158444);

  Color blueColor = const Color(0xff072DF4);
  Color lightBlueColor = const Color(0xff00C0FF);
  Color greenColor = const Color(0xff60E000);
  Color orangeColor = const Color(0xffFFD80A);
  Color yellowColor = const Color(0xffFFE769);
  Color whiteColor = const Color(0xffFFFFFF);
  Color blackColor = const Color(0xFF18191A);
  Color greyColor = const Color(0xFFBCBACD);
  Color darkGreyColor = const Color(0xFFB5B5B5);
  Color backgroundColor = const Color(0xFFf2f2f2);
  Color likeColor = const Color.fromARGB(255, 238, 238, 238);

  Color dividerColor = const Color.fromRGBO(239, 239, 239, 100);
  Color onLoadingColor = const Color(0xFFd9d9d9);
}
