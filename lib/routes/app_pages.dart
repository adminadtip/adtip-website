import 'package:adtip_web_3/modules/ad_model/ad_model.dart';
import 'package:adtip_web_3/modules/ad_model/bindings/ad_models_binding.dart';
import 'package:adtip_web_3/modules/authentication/bindings/landingBinding.dart';
import 'package:adtip_web_3/modules/authentication/pages/landing_page.dart';
import 'package:get/get.dart';
import '../modules/authentication/bindings/login_bindings.dart';
import '../modules/authentication/pages/login_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
        name: _Paths.LANDING,
        page: () => const LandingPage(),
        binding: LandingBinding()),
    GetPage(
        name: _Paths.AdModels,
        page: () => AdModelScreen(),
        binding: AdModelsBindings()),
    GetPage(
        name: _Paths.AdModels,
        page: () => AdModelScreen(),
        binding: AdModelsBindings()),
    // GetPage(
    //   name: _Paths.DASHBOARD,
    //   page: () => const DashBoardScreen(),
    //   binding: DashboardBindings(),
    // ),
  ];
}
