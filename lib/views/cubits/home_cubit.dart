import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

enum HomeNavBar { home, transaction, task, user }

class HomeState {
  final HomeNavBar homeNavBar;

  HomeState({required this.homeNavBar});
}

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(homeNavBar: HomeNavBar.home));

  void changeNavBar(HomeNavBar directionBar) {
    emit(HomeState(homeNavBar: directionBar));
  }
}
