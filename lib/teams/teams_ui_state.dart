import 'package:flutter/cupertino.dart';
import 'package:nba_bloc/model/Team.dart';

@immutable
abstract class UiState {}

class Initial extends UiState {}

class Loading extends UiState {}

class Success extends UiState {
  final List<Team> teams;

  Success({this.teams = const <Team>[]});
}
