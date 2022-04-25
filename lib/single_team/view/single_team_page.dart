import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nba_bloc/model/Team.dart';
import 'package:nba_bloc/single_team/bloc/model/team_event.dart';
import 'package:nba_bloc/single_team/bloc/single_team_bloc.dart';
import 'package:nba_bloc/single_team/team_ui_state.dart';
import 'package:nba_bloc/single_team/view/single_team_list.dart';

class SingleTeamPage extends StatelessWidget {
  final int id;
  final int position;
  final Team team;

  const SingleTeamPage({Key? key, required this.id, required this.position,required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NBA players list')),
      body: BlocProvider(
        create: (_) => SingleTeamBloc(Initial(id: id))..add(FetchTeam()),
        child: SingleTeamList(position: position,team: team,),
      ),
    );
  }
}
