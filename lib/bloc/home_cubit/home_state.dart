part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Beer> beers;
  final int page;
  const HomeLoaded(this.beers, {this.page = 1});

  @override
  List<Object> get props => [beers, page];

  @override
  String toString() => 'HomeLoaded(beers: $beers, page: $page)';
}

class HomeFailed extends HomeState {
  final String message;
  const HomeFailed(this.message);
}
