import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:nba_bloc/custom_view/ac_custom_button.dart';
import 'package:nba_bloc/teams/bloc/model/teams_event.dart';
import 'package:nba_bloc/teams/bloc/teams_bloc.dart';
import 'package:nba_bloc/teams/teams_ui_state.dart';
import 'package:nba_bloc/teams/widget/team_single_item.dart';


class TeamsList extends StatefulWidget {
  const TeamsList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TeamsListState();
}

class _TeamsListState extends State<TeamsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsBloc, UiState>(builder: (context, state) {
      if (state is Initial) {
        context.read<TeamsBloc>().add(FetchTeamsData());
        return Container();
      }
      if (state is Loading) {
        return const Center(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.green,
              BlendMode.srcATop,
            ),
            child: CupertinoActivityIndicator(
              radius: 14.0,
            ),
          ),
        );
      }
      if (state is Success) {
        return ListView.builder(
          itemCount: state.teams.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 150),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: Hero(
                  tag: "hero_view_custom_$index",
                  child: TeamSingleItem(
                    team: state.teams[index],
                    onItemClick: (id) => {
                      Navigator.of(context).push(
                        createRoute(
                            // SingleTeamPage(
                            //   id: id,
                            //   position: index,
                            //   team: state.teams[index],
                            // ),
                            const ArcWidget()),
                      )
                    },
                  ),
                ),
              ),
            );
          },
        );
      }

      // /// default state
      return Container();
    });
  }

  Route createRoute(Widget page) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          // return SlideTransition(
          //   position: tween.animate(curvedAnimation),
          //   child: child,
          // );
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        });
  }
}
