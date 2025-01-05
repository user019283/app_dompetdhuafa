import 'package:get/get.dart';

import '../modules/camera/bindings/camera_binding.dart';
import '../modules/camera/views/camera_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/maps/bindings/maps_binding.dart';
import '../modules/maps/views/maps_view.dart';
import '../modules/mic/bindings/mic_binding.dart';
import '../modules/mic/views/mic_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/speaker/bindings/speaker_binding.dart';
import '../modules/speaker/views/speaker_view.dart';
import '../modules/webviewnews/bindings/webviewnews_binding.dart';
import '../modules/webviewnews/views/webviewnews_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SIGNIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.WEBVIEWNEWS,
      page: () => const WebviewnewsView(url: "https://www.youtube.com/"),
      binding: WebviewnewsBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.CAMERA,
      page: () => const CameraView(),
      binding: CameraBinding(),
    ),
    GetPage(
      name: _Paths.SPEAKER,
      page: () => const SpeakerView(),
      binding: SpeakerBinding(),
    ),
    GetPage(
      name: _Paths.MIC,
      page: () => const MicView(),
      binding: MicBinding(),
    ),
    GetPage(
      name: _Paths.MAPS,
      page: () => const MapsView(),
      binding: MapsBinding(),
    ),
  ];
}
