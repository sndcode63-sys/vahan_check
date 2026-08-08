class ApiConstants {
  ApiConstants._();

  //  BASE CONFIG
  static const String baseUrl = "https://api.example.com/v1";
  static const int connectTimeout = 15000; // 15 sec
  static const int receiveTimeout = 15000;
  static const int sendTimeout = 15000;

  //  HEADERS ----------------
  static const String contentType = "application/json";
  static const String authHeaderKey = "Authorization";

  // Auth
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String refreshToken = "/auth/refresh";
  static const String logout = "/auth/logout";

  // User
  static const String userProfile = "/user/profile";
  static const String updateProfile = "/user/update";

  // Add more
}
