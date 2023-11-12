import 'package:school_app/src/modules/home/data/model/home_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeModel model;

  HomeSuccess(this.model);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
