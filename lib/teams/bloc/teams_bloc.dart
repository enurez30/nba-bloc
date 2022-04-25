import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nba_bloc/model/Team.dart';

import '../teams_ui_state.dart';
import 'model/teams_event.dart';

class TeamsBloc extends Bloc<DataEvent, UiState> {
  TeamsBloc() : super(Initial()) {
    on<DataEvent>(_onDataFetch);
  }

  ///
  Future<void> _onDataFetch(DataEvent event, Emitter<UiState> emitter) async {
    /// set loading state each time _onDataFetch is called
    emitter(Loading());

    /// fetch data from assets
    var data = await _loadFromAsset();
    emitter(Success(teams: data));
  }

  ///
  Future<List<Team>> _loadFromAsset() async {
    String json = await rootBundle.loadString("assets/json/input.json");
    List<Team> teams = (jsonDecode(json) as List<dynamic>).map((e) => Team.fromJson(e)).toList();
    return teams;
  }
}
