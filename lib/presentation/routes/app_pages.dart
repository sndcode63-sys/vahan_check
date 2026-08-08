import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bindings/user_binding.dart';
import '../views/user_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const Transition _smoothTransition = Transition.cupertino;
  static const Duration _smoothDuration = Duration(milliseconds: 350);
  static const Curve _smoothCurve = Curves.easeInOutCubic;

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.user,
      page: () => const UserView(),
      binding: UserBinding(),
      transition: _smoothTransition,
      transitionDuration: _smoothDuration,
      curve: _smoothCurve,
    ),

    // GetPage(
    //   name: AppRoutes.home,
    //   page: () => const HomeView(),
    //   binding: HomeBinding(),
    //   transition: _smoothTransition,
    //   transitionDuration: _smoothDuration,
    //   curve: _smoothCurve,
    // ),
  ];
}