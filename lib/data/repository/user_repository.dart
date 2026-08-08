import '../../core/constants/api_constants.dart';
import '../../core/network/api_response.dart';
import '../models/user_model.dart';
import 'base_repository.dart';

class UserRepository extends BaseRepository {
  Future<ApiResponse<UserModel>> login({
    required String email,
    required String password,
  }) {
    return apiClient.post<UserModel>(
      ApiConstants.login,
      body: {"email": email, "password": password},
      fromJson: (json) => UserModel.fromJson(json['data']),
    );
  }

  Future<ApiResponse<UserModel>> getProfile() {
    return apiClient.get<UserModel>(
      ApiConstants.userProfile,
      fromJson: (json) => UserModel.fromJson(json['data']),
    );
  }

  Future<ApiResponse<UserModel>> updateProfile(Map<String, dynamic> data) {
    return apiClient.put<UserModel>(
      ApiConstants.updateProfile,
      body: data,
      fromJson: (json) => UserModel.fromJson(json['data']),
    );
  }
}
