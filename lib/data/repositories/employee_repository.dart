import 'package:injectable/injectable.dart';

import '../data.dart';

@injectable
class EmployeeRepository {
  final EmployeeDataSource _dataSource;

  EmployeeRepository(this._dataSource);

  Future<Employee> getEmployeeByEmail(String email) {
    return _dataSource.getEmployeeByEmail(email);
  }
}
