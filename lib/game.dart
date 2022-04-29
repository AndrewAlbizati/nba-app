import 'team.dart';

class Game {
  late int id;
  late String date;

  late Team homeTeam;
  late Team visitorTeam;

  late int period;
  late bool postseason;
  late int season;
  late String status;
  late String time;

  late int homeTeamScore;
  late int visitorTeamScore;

  Game(
      {required this.id,
      required this.date,
      required this.homeTeam,
      required this.visitorTeam,
      required this.period,
      required this.postseason,
      required this.season,
      required this.status,
      required this.time,
      required this.homeTeamScore,
      required this.visitorTeamScore});

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];

    homeTeam = Team.fromJson(json['home_team']);
    visitorTeam = Team.fromJson(json['visitor_team']);

    period = json['period'];
    postseason = json['postseason'];
    season = json['season'];
    status = json['status'];
    switch (status.toLowerCase()) {
      case '1st quarter':
      case '2nd quarter':
      case '3rd quarter':
      case '4th quarter':
        status = status.substring(0, 1) + 'Q';
        break;

      case 'final':
        status = 'F';
    }
    time = json['time'];

    homeTeamScore = json['home_team_score'];
    visitorTeamScore = json['visitor_team_score'];
  }
}
