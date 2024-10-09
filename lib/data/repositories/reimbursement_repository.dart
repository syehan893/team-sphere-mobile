import 'package:injectable/injectable.dart';

import '../data.dart';

@injectable
class ReimbursementRequestRepository {
  final ReimbursementRequestDataSource _dataSource;

  ReimbursementRequestRepository(this._dataSource);

  Future<List<ReimbursementRequest>> getReimbursementRequestsByEmployeeId(String employeeId) {
    return _dataSource.getReimbursementRequestsByEmployeeId(employeeId);
  }

  Future<List<ReimbursementRequest>> getReimbursementRequestsByManagerId(String managerId) {
    return _dataSource.getReimbursementRequestsByManagerId(managerId);
  }

  Future<ReimbursementRequest> getReimbursementRequestById(int requestId) {
    return _dataSource.getReimbursementRequestById(requestId);
  }

  Future<void> createReimbursementRequest(ReimbursementRequest reimbursementRequest) {
    return _dataSource.createReimbursementRequest(reimbursementRequest);
  }

  Future<void> updateReimbursementRequest(int requestId, Map<String, dynamic> data) {
    return _dataSource.updateReimbursementRequest(requestId, data);
  }
}
