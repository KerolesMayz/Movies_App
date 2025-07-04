import 'package:movies/data/models/watch_list_response/favourite_movie.dart';

sealed class HistoryState {}

class HistorySuccessState extends HistoryState {
  final List<FavouriteMovie> data;

  HistorySuccessState({required this.data});
}

class HistoryLoadingState extends HistoryState {}

class HistoryErrorState extends HistoryState {
  final Exception? exception;

  HistoryErrorState({this.exception});
}
