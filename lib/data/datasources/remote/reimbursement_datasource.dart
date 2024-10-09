
import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/core/network/api_client.dart';

import '../../data.dart';

@injectable
class ReimbursementRequestDataSource {
  final ApiClient _apiClient;

  ReimbursementRequestDataSource(this._apiClient);

  Future<List<ReimbursementRequest>> getReimbursementRequestsByEmployeeId(String employeeId) async {
    final response = await _apiClient.get('/reimbursement-requests/employee/$employeeId');
    return (response.data as List).map((json) => ReimbursementRequest.fromJson(json)).toList();
  }

  Future<List<ReimbursementRequest>> getReimbursementRequestsByManagerId(String managerId) async {
    final response = await _apiClient.get('/reimbursement-requests/manager/$managerId');
    return (response.data as List).map((json) => ReimbursementRequest.fromJson(json)).toList();
  }

  Future<ReimbursementRequest> getReimbursementRequestById(int requestId) async {
    final response = await _apiClient.get('/reimbursement-requests/$requestId');
    return ReimbursementRequest.fromJson(response.data);
  }

  Future<void> createReimbursementRequest(ReimbursementRequest reimbursementRequest) async {
    await _apiClient.post('/reimbursement-requests', reimbursementRequest.toJson());
  }

  Future<void> updateReimbursementRequest(int requestId, Map<String, dynamic> data) async {
    await _apiClient.put('/reimbursement-requests/$requestId', data);
  }
}
