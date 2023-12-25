import 'api_service.dart';
import 'data_result.dart';

class Repository {
  final ApiService _apiService;

  Repository(this._apiService);

  Future<DataResult<Map<String, dynamic>>> fetchData(
      String name, String email, String message) async {
    final response = await _apiService.fetchData(name, email, message);
    return DataResult.fromResponse(response);
  }
}
