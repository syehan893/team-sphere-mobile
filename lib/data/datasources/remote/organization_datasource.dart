import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/core/network/api_client.dart';

import '../../data.dart';

@injectable
class OrganizationDataSource {
  final ApiClient _apiClient;

  OrganizationDataSource(this._apiClient);

  Future<List<Organization>> getDepartments() async {
    final response = await _apiClient.get('/departments');

    if (response.statusCode == 200) {
      final data = response.data as List;
      return data.map((json) => Organization.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch departments call data');
    }
  }
}
