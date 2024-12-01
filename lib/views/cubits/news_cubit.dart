import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/data.dart';
import 'package:equatable/equatable.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';

class NewsState extends Equatable {
  final FetchStatus? status;
  final List<News>? newsList;
  final String? errorMessage;

  const NewsState({
    this.status,
    this.newsList,
    this.errorMessage,
  });

  NewsState copyWith({
    FetchStatus? status,
    List<News>? newsList,
    String? errorMessage,
  }) {
    return NewsState(
      status: status ?? this.status,
      newsList: newsList ?? this.newsList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, newsList, errorMessage];
}

@injectable
class NewsCubit extends Cubit<NewsState> {
  final NewsRepository _repository;

  NewsCubit(this._repository) : super(const NewsState());

  Future<void> getNews() async {
    emit(state.copyWith(status: FetchStatus.loading));
    try {
      final newsList = await _repository.getNews();
      emit(state.copyWith(
        status: FetchStatus.loaded,
        newsList: newsList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FetchStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
