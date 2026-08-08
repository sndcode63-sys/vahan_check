import 'package:get/get.dart';

class NavService {
  NavService._();
  static Future<T?>? toNamed<T>(String route, {dynamic arguments}) {
    return Get.toNamed<T>(route, arguments: arguments);
  }

  static Future<T?>? offNamed<T>(String route, {dynamic arguments}) {
    return Get.offNamed<T>(route, arguments: arguments);
  }

  static Future<T?>? offAllNamed<T>(String route, {dynamic arguments}) {
    return Get.offAllNamed<T>(route, arguments: arguments);
  }

  static void back<T>({T? result}) {
    if (Get.isBottomSheetOpen ?? false) {
      Get.back(result: result);
      return;
    }
    Get.back<T>(result: result);
  }

  static T? arguments<T>() => Get.arguments as T?;
}
