import 'team.dart';

class Player {
  late int id;

  late String firstName;
  late String lastName;
  late String position;

  late int heightFeet;
  late int heightInches;
  late int weightPounds;

  late Team team;

  Player({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.heightFeet,
    required this.heightInches,
    required this.weightPounds,
    required this.team,
  });

  Player.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    firstName = json['first_name'];
    lastName = json['last_name'];
    position = json['position'];

    if (json['height_feet'] != null) {
      heightFeet = json['height_feet'];
    } else {
      heightFeet = -1;
    }

    if (json['height_feet'] != null) {
      heightInches = json['height_inches'];
    } else {
      heightInches = -1;
    }

    if (json['weight_pounds'] != null) {
      weightPounds = json['weight_pounds'];
    } else {
      weightPounds = -1;
    }

    team = Team.fromJson(json['team']);
  }
}
