import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const FisimateApp());
  });
}
class FisimateApp extends StatelessWidget {
  const FisimateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Fisimate",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        visualDensity: VisualDensity.comfortable,
      ),
    );
  }
}
