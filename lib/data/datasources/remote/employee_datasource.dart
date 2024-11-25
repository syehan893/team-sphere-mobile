import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/core/network/api_client.dart';

import '../../data.dart';

@injectable
class EmployeeDataSource {
  final ApiClient _apiClient;

  EmployeeDataSource(this._apiClient);

  Future<Employee> getEmployeeByEmail(String email) async {
    final response = await _apiClient.get('/employees/by-email/$email');
    
    if (response.statusCode == 200) {
      return Employee.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch employee data');
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    await _apiClient.put('/employees/${employee.employeeId}',
        employee.toJson());
  }
}
