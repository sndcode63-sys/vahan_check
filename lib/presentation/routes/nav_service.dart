import 'package:go_router/go_router.dart';
import 'app_router.dart';

/// Same call-sites as before (`NavService.toNamed(...)`), now backed by
/// go_router instead of `Get.toNamed` / `Get.offNamed`. Uses
/// [rootNavigatorKey] so it still works without a local `BuildContext`.
class NavService {
  NavService._();

  static GoRouter get _router => appRouter;

  /// Push a new route on top of the stack (like `Get.toNamed`).
  static void toNamed(String routeName, {Object? arguments, Map<String, String> pathParameters = const {}}) {
    _router.pushNamed(
      _stripSlash(routeName),
      pathParameters: pathParameters,
      extra: arguments,
    );
  }

  /// Replace the current route (like `Get.offNamed`).
  static void offNamed(String routeName, {Object? arguments, Map<String, String> pathParameters = const {}}) {
    _router.replaceNamed(
      _stripSlash(routeName),
      pathParameters: pathParameters,
      extra: arguments,
    );
  }

  /// Clear the whole stack and go to a route (like `Get.offAllNamed`).
  static void offAllNamed(String routeName, {Object? arguments, Map<String, String> pathParameters = const {}}) {
    _router.goNamed(
      _stripSlash(routeName),
      pathParameters: pathParameters,
      extra: arguments,
    );
  }

  static void back<T>({T? result}) {
    if (_router.canPop()) {
      _router.pop<T>(result);
    }
  }

  /// Reads the `extra` payload passed via [toNamed] (like `Get.arguments`).
  static T? arguments<T>(GoRouterState state) => state.extra as T?;

  static String _stripSlash(String routeName) =>
      routeName.startsWith('/') ? routeName.substring(1) : routeName;
}
