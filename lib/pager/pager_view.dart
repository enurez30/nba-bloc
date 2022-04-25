import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nba_bloc/model/Team.dart';
import 'package:nba_bloc/model/player.dart';

class PagerView extends StatelessWidget {
  final Team team;
  final int playerId;

  const PagerView({Key? key, required this.team, required this.playerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int initialIndex = team.players.indexOf(team.players.where((element) => element.id == playerId).first);
    final PageController controller = PageController(initialPage: initialIndex);

    return Scaffold(
      appBar: AppBar(title: const Text('Single player pager view')),
      body: PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        controller: controller,
        children: team.players.map((e) => _content(e)).toList(),
      ),
    );
  }

  Widget _content(Player player) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _imageContainer(player),
        const SizedBox(height: 10,),
        Text("${player.firstName} ${player.lastName}"),
      ],
    );
  }

  Widget _imageContainer(Player player) {
    final String imageUrl = "https://nba-players.herokuapp.com/players/${player.lastName}/${player.firstName}";
    return Hero(
      tag: "hero_payer_${player.id}",
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, object, trace) {
          return Image.asset('assets/images/no_photo.png');
        },
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return const SizedBox(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.green, BlendMode.srcATop),
              child: CupertinoActivityIndicator(
                radius: 12.0,
              ),
            ),
          );
        },
      ),
    );
  }
}
