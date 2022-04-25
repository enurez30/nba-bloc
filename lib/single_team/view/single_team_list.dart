import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:nba_bloc/model/Team.dart';
import 'package:nba_bloc/pager/pager_view.dart';
import 'package:nba_bloc/single_team/bloc/single_team_bloc.dart';
import 'package:nba_bloc/single_team/team_ui_state.dart';
import 'package:nba_bloc/single_team/widget/player_single_item.dart';
import 'package:nba_bloc/teams/widget/team_single_item.dart';

class SingleTeamList extends StatefulWidget {
  final int position;
  final Team team;

  const SingleTeamList({Key? key, required this.position, required this.team}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SingleTeamListState();
}

class _SingleTeamListState extends State<SingleTeamList> {
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;

    return Column(
      children: [
        SizedBox(
          child: Hero(
            tag: "hero_view_custom_${widget.position}",
            child: TeamSingleItem(
              team: widget.team,
              onItemClick: (id) => {},
            ),
          ),
        ),
        BlocBuilder<SingleTeamBloc, TeamUiState>(
          builder: (context, state) {
            if (state is Success) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.team.players.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 150),
                      child: SlideAnimation(
                        verticalOffset: 100.0,
                        // horizontalOffset: -250,
                        child: FadeInAnimation(
                          child: PlayerSingleItem(
                            onItemClick: (id) => {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PagerView(
                                    team: widget.team,
                                    playerId: id,
                                  ),
                                ),
                              ),
                            },
                            player: state.team.players[index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return const SizedBox(
              height: 100,
              width: 100,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(Colors.green, BlendMode.srcATop),
                child: CupertinoActivityIndicator(
                  radius: 12.0,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
