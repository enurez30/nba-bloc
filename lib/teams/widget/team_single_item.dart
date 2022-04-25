import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nba_bloc/model/Team.dart';

class TeamSingleItem extends StatelessWidget {
  final Team team;
  final Function(int teamId) onItemClick;

  const TeamSingleItem({Key? key, required this.team, required this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final String logoUrl = "https://i.cdn.turner.com/nba/nba/assets/logos/teams/primary/web/${team.abbreviation}.svg";

    final Widget networkSvg = SvgPicture.network(
      logoUrl,
      placeholderBuilder: (BuildContext context) => const Padding(
        padding: EdgeInsets.all(30.0),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.green, BlendMode.srcATop),
          child: CupertinoActivityIndicator(
            radius: 12.0,
          ),
        ),
      ),
      height: 100,
      fit: BoxFit.fill,
    );

    return Card(
      child: InkWell(
        splashColor: Colors.red[200],
        onTap: () => {onItemClick(team.id)},
        child: Row(
          children: [
            networkSvg,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(team.fillName, style: textTheme.headline5), _getSubtitle(team)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  Widget _getSubtitle(Team team) {
    return Row(
      children: [
        const Text("team wins: "),
        Text("${team.wins}", style: const TextStyle(color: Colors.green)),
        Container(
          width: 10,
        ),
        const Text("team losses: "),
        Text("${team.losses}", style: const TextStyle(color: Colors.red))
      ],
    );
  }
}
