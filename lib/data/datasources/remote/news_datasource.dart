import 'package:injectable/injectable.dart';
import 'package:team_sphere_mobile/core/network/api_client.dart';

import '../../data.dart';

@injectable
class NewsDataSource {
  final ApiClient _apiClient;

  NewsDataSource(this._apiClient);

  Future<List<News>> getNews() async {
    final response = await _apiClient.get('/company-news');

    if (response.statusCode == 200) {
      final data = response.data as List;
      return data.map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch news call data');
    }
  }
}
