import 'package:equatable/equatable.dart';
import 'package:nba_bloc/model/player.dart';

class Team extends Equatable {
  final int id;
  final int wins;
  final int losses;
  final String fillName;
  final String abbreviation;
  final List<Player> players;

  const Team({this.id = -1, this.wins = -1, this.losses = -1, this.abbreviation = "", this.fillName = "", this.players = const []});

  factory Team.fromJson(Map<String, dynamic> json) {
    final playersData = json["players"] as List<dynamic>?;

    return Team(
        id: json["id"],
        wins: json["wins"],
        losses: json["losses"],
        fillName: json["full_name"],
        abbreviation: json["abbreviation"],
        players: playersData != null ? playersData.map((e) => Player.fromJson(e)).toList() : []);
  }

  @override
  List<Object?> get props => [id];
}
