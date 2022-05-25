import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game.dart';
import '../models/player_stats.dart';
import '../models/player.dart';
import '../models/team.dart';

Future<Game> getGame(int id) async {
  String url = 'https://www.balldontlie.io/api/v1/games/$id&per_page=100';
  final response = await http.get(Uri.parse(url));

  Game game = Game.fromJson(jsonDecode(response.body));

  return game;
}

Future<List<Game>> getGames(int year, int month, int day) async {
  List<Game> list = [];
  String date = year.toString() + '-' + month.toString() + '-' + day.toString();
  String url =
      'https://www.balldontlie.io/api/v1/games?start_date=$date&end_date=$date&per_page=100';
  final response = await http.get(Uri.parse(url));

  Map<String, dynamic> gamesMap = jsonDecode(response.body);
  List<dynamic> games = gamesMap["data"];

  for (int i = 0; i < games.length; i++) {
    Game g = Game.fromJson(games[i]);
    if (g.postseason) {
      await g.loadSeriesStatus();
    }
    list.add(g);
  }

  return list;
}

Future<List<Game>> getPostseasonGamesByTeams(Game game) async {
  List<Game> list = [];
  String startDate = '${game.season}-1-1';
  String endDate = game.date.split("T")[0];
  String url =
      'https://www.balldontlie.io/api/v1/games?team_ids[]=${game.visitorTeam.id}&start_date=$startDate&end_date=$endDate&per_page=100&postseason=true';

  final response = await http.get(Uri.parse(url));

  Map<String, dynamic> gamesMap = jsonDecode(response.body);
  List<dynamic> games = gamesMap["data"];

  for (int i = 0; i < games.length; i++) {
    Game g = Game.fromJson(games[i]);
    if (g.visitorTeam.id == game.homeTeam.id ||
        g.homeTeam.id == game.homeTeam.id) {
      list.add(g);
    }
  }

  return list;
}

Future<List<PlayerStats>> getStats(int gameId) async {
  List<PlayerStats> list = [];
  String url =
      'https://www.balldontlie.io/api/v1/stats?game_ids[]=$gameId&per_page=100';

  final response = await http.get(Uri.parse(url));

  Map<String, dynamic> data = jsonDecode(response.body);

  List<dynamic> players = data['data'];
  players.forEach((player) {
    list.add(PlayerStats.fromJson(player));
  });
  return list;
}

Future<List<Player>> getPlayers(String search, int maxSize) async {
  List<Player> list = [];
  String url =
      'https://www.balldontlie.io/api/v1/players?search=$search&per_page=$maxSize';

  final response = await http.get(Uri.parse(url));

  Map<String, dynamic> data = jsonDecode(response.body);

  List<dynamic> players = data['data'];
  players.forEach((player) {
    list.add(Player.fromJson(player));
  });
  return list;
}

Future<Player> getPlayer(int id) async {
  String url = 'https://www.balldontlie.io/api/v1/players/$id';
  final response = await http.get(Uri.parse(url));

  Map<String, dynamic> data = jsonDecode(response.body);

  return Player.fromJson(data['data']);
}

Future<Team> getTeam(int id) async {
  String url = 'https://www.balldontlie.io/api/v1/teams/$id';
  final response = await http.get(Uri.parse(url));

  Map<String, dynamic> data = jsonDecode(response.body);

  return Team.fromJson(data['data']);
}
