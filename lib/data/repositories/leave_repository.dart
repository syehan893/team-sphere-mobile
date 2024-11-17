import 'package:injectable/injectable.dart';

import '../data.dart';

@injectable
class LeaveRequestRepository {
  final LeaveRequestDataSource _dataSource;

  LeaveRequestRepository(this._dataSource);

  Future<List<LeaveRequest>> getLeaveRequestsByEmployeeId(String employeeId) {
    return _dataSource.getLeaveRequestsByEmployeeId(employeeId);
  }

  Future<List<LeaveRequest>> getLeaveRequestsByManagerId(String managerId) {
    return _dataSource.getLeaveRequestsByManagerId(managerId);
  }

  Future<LeaveRequest> getLeaveRequestById(int requestId) {
    return _dataSource.getLeaveRequestById(requestId);
  }

  Future<void> createLeaveRequest(LeaveRequest leaveRequest) {
    return _dataSource.createLeaveRequest(leaveRequest);
  }

  Future<void> updateLeaveRequest(LeaveRequest leaveRequest) {
    return _dataSource.updateLeaveRequest(leaveRequest);
  }
}
