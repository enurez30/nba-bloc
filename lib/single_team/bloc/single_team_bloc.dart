import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nba_bloc/model/Team.dart';
import 'package:nba_bloc/single_team/bloc/model/team_event.dart';
import 'package:nba_bloc/single_team/team_ui_state.dart';

class SingleTeamBloc extends Bloc<TeamDataEvent, TeamUiState> {
  SingleTeamBloc(TeamUiState initialState) : super(initialState) {
    on<TeamDataEvent>(_onDataFetch);
  }

  ///
  Future<void> _onDataFetch(TeamDataEvent event, Emitter<TeamUiState> emitter) async {
    /// fetch data from assets
    var data = await _loadFromAsset();
    if (state is Initial) {
      Team singleTeam = data.where((element) => element.id == (state as Initial).id).first;
      emitter(Success(team: singleTeam));
    }
  }

  ///
  Future<List<Team>> _loadFromAsset() async {
    String json = await rootBundle.loadString("assets/json/input.json");
    List<Team> teams = (jsonDecode(json) as List<dynamic>).map((e) => Team.fromJson(e)).toList();
    return teams;
  }
}
