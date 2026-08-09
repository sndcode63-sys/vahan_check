import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/api_response.dart';
import '../../core/utils/secure_storage_service.dart';
import '../../data/models/user_model.dart';
import '../../data/repository/user_repository.dart';

class UserState {
  final UserModel? user;
  final bool isLoading;
  final String errorMessage;

  const UserState({
    this.user,
    this.isLoading = false,
    this.errorMessage = '',
  });

  UserState copyWith({
    UserModel? user,
    bool? isLoading,
    String? errorMessage,
    bool clearUser = false,
  }) {
    return UserState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Same responsibilities as the old GetX `UserController`, rewritten as a
/// Riverpod [Notifier]. Screens read/react to it with
/// `ref.watch(userProvider)` and call actions with
/// `ref.read(userProvider.notifier).login(...)`.
class UserNotifier extends Notifier<UserState> {
  final UserRepository _userRepository = UserRepository();

  @override
  UserState build() => const UserState();

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: '');

    final ApiResponse<UserModel> response =
        await _userRepository.login(email: email, password: password);

    switch (response.status) {
      case Status.success:
        final token = response.data?.accessToken;
        if (token != null && token.isNotEmpty) {
          await SecureStorageService.saveAccessToken(token);
        }
        state = state.copyWith(user: response.data, isLoading: false);
        break;

      case Status.error:
        state = state.copyWith(
          isLoading: false,
          errorMessage: response.message ?? "Login failed",
        );
        break;

      case Status.loading:
        break;
    }
  }

  Future<void> logout() async {
    await SecureStorageService.clearAll();
    state = state.copyWith(clearUser: true);
  }

  Future<void> fetchProfile() async {
    state = state.copyWith(isLoading: true);

    final response = await _userRepository.getProfile();

    if (response.isSuccess) {
      state = state.copyWith(user: response.data, isLoading: false);
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: response.message ?? "Failed to load profile",
      );
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true);

    final response = await _userRepository.updateProfile(data);

    if (response.isSuccess) {
      state = state.copyWith(user: response.data, isLoading: false);
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: response.message ?? "Update failed",
      );
    }
  }
}

final userProvider = NotifierProvider<UserNotifier, UserState>(UserNotifier.new);
