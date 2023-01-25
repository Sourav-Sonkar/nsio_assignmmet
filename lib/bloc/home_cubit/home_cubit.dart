import 'package:api_client/api_client.dart';
import 'package:api_client/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiClient apiClient;
  HomeCubit(this.apiClient) : super(HomeInitial());

  void getBeers({bool? refresh = false}) async {
    if (state is HomeLoading) return;
    var currentState = state;
    try {
      if (refresh ?? false) {
        emit(HomeLoading());
        var result = await apiClient.getBeers();
        if (result.status == RequestStatus.SUCCESS) {
          emit(HomeLoaded(result.body ?? []));
        } else {
          emit(HomeFailed(result.message ?? "Something went wrong"));
        }
      } else if (currentState is HomeInitial) {
        emit(HomeLoading());
        var result = await apiClient.getBeers();
        if (result.status == RequestStatus.SUCCESS) {
          emit(HomeLoaded(result.body ?? []));
        } else {
          emit(HomeFailed(result.message ?? "Something went wrong"));
        }
      } else if (currentState is HomeLoaded) {
        List<Beer> old = currentState.beers;
        int page = currentState.page + 1;
        var result = await apiClient.getBeers(page: page);
        if (result.status == RequestStatus.SUCCESS) {
          List<Beer> newBeers = result.body ?? [];
          emit(HomeLoaded([...old, ...newBeers], page: page));
        } else {
          emit(HomeFailed(result.message ?? "Something went wrong"));
        }
      }
    } catch (e) {
      emit(HomeFailed(e.toString()));
    }
  }
}
