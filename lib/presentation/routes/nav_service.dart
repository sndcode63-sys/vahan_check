// import 'package:go_router/go_router.dart';
// import 'app_router.dart';
//
// /// Same call-sites as before (`NavService.toNamed(...)`), now backed by
//
// class NavService {
//   NavService._();
//
//   static GoRouter get _router => appRouter;
//
//   static void toNamed(String routeName, {Object? arguments, Map<String, String> pathParameters = const {}}) {
//     _router.pushNamed(
//       _stripSlash(routeName),
//       pathParameters: pathParameters,
//       extra: arguments,
//     );
//   }
//
//   static void offNamed(String routeName, {Object? arguments, Map<String, String> pathParameters = const {}}) {
//     _router.replaceNamed(
//       _stripSlash(routeName),
//       pathParameters: pathParameters,
//       extra: arguments,
//     );
//   }
//
//   static void offAllNamed(String routeName, {Object? arguments, Map<String, String> pathParameters = const {}}) {
//     _router.goNamed(
//       _stripSlash(routeName),
//       pathParameters: pathParameters,
//       extra: arguments,
//     );
//   }
//
//   static void back<T>({T? result}) {
//     if (_router.canPop()) {
//       _router.pop<T>(result);
//     }
//   }
//
//   static T? arguments<T>(GoRouterState state) => state.extra as T?;
//
//   static String _stripSlash(String routeName) =>
//       routeName.startsWith('/') ? routeName.substring(1) : routeName;
// }
