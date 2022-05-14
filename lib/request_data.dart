import 'dart:convert';
import 'package:http/http.dart' as http;

import 'game.dart';
import 'player_stats.dart';

Future<Game> getGame(int id) async {
  String url = 'https://www.balldontlie.io/api/v1/games/$id&per_page=100';
  final response = await http.get(Uri.parse(url));

  Game game = Game.fromJson(jsonDecode(response.body));
  game.stats = await getStats(id);

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
    list.add(g);
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
