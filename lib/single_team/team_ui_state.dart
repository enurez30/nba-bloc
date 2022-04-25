import 'package:flutter/cupertino.dart';
import 'package:nba_bloc/model/Team.dart';

@immutable
abstract class TeamUiState {}

class Initial extends TeamUiState {
  final int id;

  Initial({required this.id});
}

class Success extends TeamUiState {
  final Team team;

  Success({this.team = const Team()});
}
