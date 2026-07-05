import 'package:fisimate/app/routes/app_pages.dart';
import 'package:fisimate/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  SystemChrome.setPreferredOrientations([
    .portraitUp,
    .portraitDown,
  ]).then((_) => runApp(const FisimateApp()));
}

class FisimateApp extends StatelessWidget {
  const FisimateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Fisimate : Portal Siswa",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        visualDensity: .comfortable,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: CustomColor.blueColor,
          selectionColor: CustomColor.blueColor.withValues(alpha: 0.5),
          selectionHandleColor: CustomColor.blueColor,
        ),
      ),
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(
            textScaler: .linear(1),
          ),
          child: child!,
        );
      },
    );
  }
}
