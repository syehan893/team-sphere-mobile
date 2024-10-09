import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/core/network/api_client.dart';

import '../../data.dart';

@injectable
class EmployeeRollCallDataSource {
  final ApiClient _apiClient;

  EmployeeRollCallDataSource(this._apiClient);

  Future<List<EmployeeRollCall>> getEmployeeRollCallsByDay(String day) async {
    final response = await _apiClient.get('/employee-roll-calls?day=$day');
    
    if (response.statusCode == 200) {
      final data = response.data as List;
      return data.map((json) => EmployeeRollCall.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch employee roll call data');
    }
  }
}
