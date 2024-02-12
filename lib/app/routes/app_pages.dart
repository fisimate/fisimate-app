import 'package:get/get.dart';

import '../modules/bank_materi/bindings/bank_materi_binding.dart';
import '../modules/bank_materi/views/bank_materi_view.dart';
import '../modules/bank_rumus/bindings/bank_rumus_binding.dart';
import '../modules/bank_rumus/views/bank_rumus_view.dart';
import '../modules/bank_soal/bindings/bank_soal_binding.dart';
import '../modules/bank_soal/views/bank_soal_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login/views/login_with_google_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/home/bindings/home_binding.dart';
import '../modules/main/home/views/home_view.dart';
import '../modules/main/views/main_view.dart';
import '../modules/module_viewer/bindings/module_viewer_binding.dart';
import '../modules/module_viewer/views/module_viewer_view.dart';
import '../modules/onboard/bindings/onboard_binding.dart';
import '../modules/onboard/views/onboard_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARD,
      page: () => const OnboardView(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.BANK_MATERI,
      page: () => const BankMateriView(),
      binding: BankMateriBinding(),
    ),
    GetPage(
      name: _Paths.BANK_SOAL,
      page: () => const BankSoalView(),
      binding: BankSoalBinding(),
    ),
    GetPage(
      name: _Paths.MODULE_VIEWER,
      page: () => const ModuleViewerView(),
      binding: ModuleViewerBinding(),
    ),
    GetPage(
      name: _Paths.GOOGLE_LOGIN,
      page: () => const LoginWithGoogleView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.BANK_RUMUS,
      page: () => const BankRumusView(),
      binding: BankRumusBinding(),
    ),
  ];
}
