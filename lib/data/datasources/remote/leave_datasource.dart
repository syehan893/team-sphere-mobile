import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/core/network/api_client.dart';

import '../../data.dart';

@injectable
class LeaveRequestDataSource {
  final ApiClient _apiClient;

  LeaveRequestDataSource(this._apiClient);

  Future<List<LeaveRequest>> getLeaveRequestsByEmployeeId(
      String employeeId) async {
    final response =
        await _apiClient.get('/leave-requests/employee/$employeeId');
    return (response.data as List)
        .map((json) => LeaveRequest.fromJson(json))
        .toList();
  }

  Future<List<LeaveRequest>> getLeaveRequestsByManagerId(
      String managerId) async {
    final response = await _apiClient.get('/leave-requests/manager/$managerId');
    return (response.data as List)
        .map((json) => LeaveRequest.fromJson(json))
        .toList();
  }

  Future<LeaveRequest> getLeaveRequestById(int requestId) async {
    final response = await _apiClient.get('/leave-requests/$requestId');
    return LeaveRequest.fromJson(response.data);
  }

  Future<void> createLeaveRequest(LeaveRequest leaveRequest) async {
    await _apiClient.post('/leave-requests', leaveRequest.toJson());
  }

  Future<void> updateLeaveRequest(LeaveRequest leaveRequest) async {
    await _apiClient.put('/leave-requests/${leaveRequest.requestId}',
        leaveRequest.toUpdateJson());
  }
}
