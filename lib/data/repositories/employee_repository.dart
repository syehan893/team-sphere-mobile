import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/core/constant/strings.dart';

import '../data.dart';

@injectable
class EmployeeRepository {
  final EmployeeDataSource _dataSource;
  final UserLocalDatasource _userLocalDatasource;

  EmployeeRepository(this._dataSource, this._userLocalDatasource);

  Future<Employee> getEmployeeByEmail() async {
    String? email = await _userLocalDatasource.getUser();
    return _dataSource.getEmployeeByEmail(email ?? CommonStrings.emptyString);
  }
}
