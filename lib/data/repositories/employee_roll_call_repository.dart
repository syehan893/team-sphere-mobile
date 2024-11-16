import 'package:injectable/injectable.dart';

import '../data.dart';

@injectable
class EmployeeRollCallRepository {
  final EmployeeRollCallDataSource _dataSource;

  EmployeeRollCallRepository(this._dataSource);

  Future<List<EmployeeRollCall>> getEmployeeRollCallsByDay(String day) {
    return _dataSource.getEmployeeRollCallsByDay(day);
  }

  Future<void> saveRollCall(EmployeeRollCall rollCall) {
    return _dataSource.saveRollCall(rollCall);
  }
}
