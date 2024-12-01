import 'package:injectable/injectable.dart';

import '../data.dart';

@injectable
class NewsRepository {
  final NewsDataSource _dataSource;

  NewsRepository(this._dataSource);

  Future<List<News>> getNews() {
    return _dataSource.getNews();
  }
}
