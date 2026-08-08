import '../../core/network/api_client.dart';
abstract class BaseRepository {
  final ApiClient apiClient = ApiClient.instance;
}
