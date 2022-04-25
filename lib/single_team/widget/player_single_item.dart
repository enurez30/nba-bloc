import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nba_bloc/model/player.dart';

class PlayerSingleItem extends StatelessWidget {
  final Player player;
  final Function(int teamId) onItemClick;

  const PlayerSingleItem({Key? key, required this.player, required this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final String imageUrl = "https://nba-players.herokuapp.com/players/${player.lastName}/${player.firstName}";

    Widget image = Hero(
      tag: "hero_payer_${player.id}",
      child: Image.network(
        imageUrl,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, object, trace) {
          return SizedBox(
            height: 100,
            width: 100,
            child: Image.asset('assets/images/no_photo.png'),
          );
        },
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
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
    );

    return Card(
      child: InkWell(
        splashColor: Colors.red[100],
        onTap: () => {onItemClick(player.id)},
        child: Row(
          children: [
            image,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("${player.firstName} ${player.lastName}", style: textTheme.headline5), Text("position: ${player.position}")],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
