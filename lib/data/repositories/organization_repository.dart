import 'package:injectable/injectable.dart';

import '../data.dart';

@injectable
class OrganizationRepository {
  final OrganizationDataSource _dataSource;

  OrganizationRepository(this._dataSource);

  Future<List<Organization>> getDepartments() {
    return _dataSource.getDepartments();
  }
}
