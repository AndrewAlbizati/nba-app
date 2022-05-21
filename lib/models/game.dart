import 'package:intl/intl.dart';
import 'package:nba_app/cloud_functions/balldontlie.dart';
import 'team.dart';
import 'player_stats.dart';

class Game {
  late int id;
  late String date;

  late Team homeTeam;
  late Team visitorTeam;

  late bool postseason;
  late String postseasonStatus;

  late int period;
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

    postseason = json['postseason'];

    period = json['period'];
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

      return '$t (${quarter}Q)';
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
    DateTime dateTime =
        DateFormat('hh:mm').parse('$hour:$minute', true).toLocal();

    String status = '${dateTime.hour % 12}:';

    // Add 0 if minute is too small (e.g. 12:5 --> 12:05)
    if (dateTime.minute < 10) {
      status += '0${dateTime.minute}';
    } else {
      status += '${dateTime.minute}';
    }

    // Add AM or PM
    if (dateTime.hour > 12) {
      status += ' PM';
    } else {
      status += ' AM';
    }

    return status;
  }

  Future<void> loadSeriesStatus() async {
    if (!postseason) {
      postseasonStatus = '';
    }

    List<Game> gamesInSeries = await getPostseasonGamesByTeams(this);

    // Total the team wins
    int visitorTeamWins = 0;
    int homeTeamWins = 0;
    for (Game g in gamesInSeries) {
      if (g.status != 'Final') {
        continue;
      }

      if (g.homeTeamScore > g.visitorTeamScore) {
        if (g.homeTeam.id == homeTeam.id) {
          homeTeamWins++;
        } else {
          visitorTeamWins++;
        }
      } else {
        if (g.homeTeam.id == homeTeam.id) {
          visitorTeamWins++;
        } else {
          homeTeamWins++;
        }
      }
    }

    // Set the status
    if (homeTeamWins > visitorTeamWins) {
      if (homeTeamWins < 4) {
        postseasonStatus =
            '${homeTeam.abbreviation} LEADS $homeTeamWins - $visitorTeamWins';
      } else {
        postseasonStatus =
            '${homeTeam.abbreviation} WINS $homeTeamWins - $visitorTeamWins';
      }
    } else if (visitorTeamWins > homeTeamWins) {
      if (visitorTeamWins < 4) {
        postseasonStatus =
            '${visitorTeam.abbreviation} LEADS $visitorTeamWins - $homeTeamWins';
      } else {
        postseasonStatus =
            '${visitorTeam.abbreviation} WINS $visitorTeamWins - $homeTeamWins';
      }
    } else {
      postseasonStatus = 'SERIES TIED $homeTeamWins - $visitorTeamWins';
    }
  }
}
