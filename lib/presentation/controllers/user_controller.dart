import 'package:get/get.dart';
import '../../core/network/api_response.dart';
import '../../core/utils/app_utils.dart';
import '../../core/utils/secure_storage_service.dart';
import '../../data/models/user_model.dart';
import '../../data/repository/user_repository.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository();

  final Rx<UserModel?> user = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;

    final ApiResponse<UserModel> response =
        await _userRepository.login(email: email, password: password);

    isLoading.value = false;

    switch (response.status) {
      case Status.success:
        user.value = response.data;

        final token = response.data?.accessToken;
        if (token != null && token.isNotEmpty) {
          await SecureStorageService.saveAccessToken(token);
        }

        AppUtils.showSuccess("Login successful");
        break;

      case Status.error:
        errorMessage.value = response.message ?? "Login failed";
        AppUtils.showError(errorMessage.value);
        break;

      case Status.loading:
        break;
    }
  }

  Future<void> logout() async {
    await SecureStorageService.clearAll();
    user.value = null;
    AppUtils.showInfo("Logged out");
  }

  Future<void> fetchProfile() async {
    isLoading.value = true;

    final response = await _userRepository.getProfile();

    isLoading.value = false;

    if (response.isSuccess) {
      user.value = response.data;
    } else {
      AppUtils.showError(response.message ?? "Failed to load profile");
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    isLoading.value = true;

    final response = await _userRepository.updateProfile(data);

    isLoading.value = false;

    if (response.isSuccess) {
      user.value = response.data;
      AppUtils.showSuccess("Profile updated");
    } else {
      AppUtils.showError(response.message ?? "Update failed");
    }
  }
}
