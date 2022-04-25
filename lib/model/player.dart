import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String position;
  final int number;

  const Player({this.id = -1, this.firstName = "", this.lastName = "", this.position = "", this.number = -1});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        position: json["position"],
        number: json["number"]);
  }

  @override
  List<Object?> get props => [id];
}
