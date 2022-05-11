import 'package:intl/intl.dart';
import 'team.dart';
import 'player_stats.dart';

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

  late List<PlayerStats> stats;

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
    time = json['time'];

    status = _convertStatus(status, time);

    homeTeamScore = json['home_team_score'];
    visitorTeamScore = json['visitor_team_score'];
  }

  String _convertStatus(String s, String t) {
    if (s == 'Final') {
      return s;
    }

    if (!s.contains('ET') && !s.contains('PM') && !s.contains('AM')) {
      int quarter = int.parse(s.substring(0, 1));

      return t + ' (' + quarter.toString() + 'Q)';
    }

    int hour = int.parse(s.split(':')[0]);
    int minute = int.parse(s.split(':')[1].split(' ')[0]);
    String timeOfDay = s.split(' ')[1];
    if (timeOfDay == 'PM') {
      hour += 12;
    }
    hour += 5;
    hour %= 24;

    // Convert UTC to local
    DateTime dateTime = DateFormat("hh:mm")
        .parse(hour.toString() + ':' + minute.toString(), true)
        .toLocal();

    String status = (dateTime.hour % 12).toString() + ':';

    // Add 0 if minute is too small (e.g. 12:5 --> 12:05)
    if (dateTime.minute < 10) {
      status += '0' + dateTime.minute.toString();
    } else {
      status += dateTime.minute.toString();
    }

    // Add AM or PM
    if (dateTime.hour > 12) {
      status += ' PM';
    } else {
      status += ' AM';
    }

    return status;
  }
}
