import 'dart:convert';
import 'dart:developer' as developer;

class AppLogger {
  AppLogger._();

  static const String _reset = '\x1B[0m';
  static const String _green = '\x1B[32m';
  static const String _red = '\x1B[31m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';
  static const String _cyan = '\x1B[36m';

  static bool enableLogs = true;

  static void d(String message, {String tag = "DEBUG"}) {
    if (!enableLogs) return;
    developer.log("$_blue[$tag]$_reset $message", name: "APP");
  }

  static void i(String message, {String tag = "INFO"}) {
    if (!enableLogs) return;
    developer.log("$_green[$tag]$_reset $message", name: "APP");
  }

  static void w(String message, {String tag = "WARNING"}) {
    if (!enableLogs) return;
    developer.log("$_yellow[$tag]$_reset $message", name: "APP");
  }

  static void e(String message, {String tag = "ERROR", Object? error, StackTrace? stack}) {
    if (!enableLogs) return;
    developer.log(
      "$_red[$tag]$_reset $message",
      name: "APP",
      error: error,
      stackTrace: stack,
    );
  }

  //  API SPECIFIC LOGS

  static void apiRequest({
    required String method,
    required String url,
    Map<String, dynamic>? headers,
    dynamic body,
  }) {
    if (!enableLogs) return;
    final buffer = StringBuffer();
    buffer.writeln("$_cyan┌── API REQUEST ──────────────────────────$_reset");
    buffer.writeln("$_cyan│ METHOD :$_reset $method");
    buffer.writeln("$_cyan│ URL    :$_reset $url");
    if (headers != null) buffer.writeln("$_cyan│ HEADERS:$_reset ${_pretty(headers)}");
    if (body != null) buffer.writeln("$_cyan│ BODY   :$_reset ${_pretty(body)}");
    buffer.write("$_cyan└─────────────────────────────────────────$_reset");
    developer.log(buffer.toString(), name: "API");
  }

  static void apiResponse({
    required String url,
    required int? statusCode,
    dynamic body,
  }) {
    if (!enableLogs) return;
    final buffer = StringBuffer();
    buffer.writeln("$_green┌── API RESPONSE ─────────────────────────$_reset");
    buffer.writeln("$_green│ URL    :$_reset $url");
    buffer.writeln("$_green│ STATUS :$_reset $statusCode");
    buffer.writeln("$_green│ BODY   :$_reset ${_pretty(body)}");
    buffer.write("$_green└─────────────────────────────────────────$_reset");
    developer.log(buffer.toString(), name: "API");
  }

  static void apiError({
    required String url,
    required String message,
    int? statusCode,
  }) {
    if (!enableLogs) return;
    final buffer = StringBuffer();
    buffer.writeln("$_red┌── API ERROR ────────────────────────────$_reset");
    buffer.writeln("$_red│ URL    :$_reset $url");
    buffer.writeln("$_red│ STATUS :$_reset $statusCode");
    buffer.writeln("$_red│ MESSAGE:$_reset $message");
    buffer.write("$_red└─────────────────────────────────────────$_reset");
    developer.log(buffer.toString(), name: "API");
  }

  static String _pretty(dynamic json) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(json);
    } catch (_) {
      return json.toString();
    }
  }
}
