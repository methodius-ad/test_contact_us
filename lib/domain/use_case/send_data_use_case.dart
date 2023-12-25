import 'package:test_contact_us/data/data_result.dart';
import 'package:test_contact_us/data/repository.dart';

class SendDataUseCase {
  final Repository _repo;

  SendDataUseCase(this._repo);

  Future<DataResult<Map<String, dynamic>>> processData(String name, String email, String message) async {
    return await _repo.fetchData(name, email, message);
  }
}