import 'dart:convert';
import 'package:http/http.dart' as http;

import 'game.dart';

Future<Game> getGame(int id) async {
  String url = 'https://www.balldontlie.io/api/v1/games/' + id.toString();
  final response = await http.get(Uri.parse(url));

  return Game.fromJson(jsonDecode(response.body));
}

Future<List<Game>> getGames(int year, int month, int day) async {
  List<Game> list = [];
  String date = year.toString() + '-' + month.toString() + '-' + day.toString();
  String url =
      'https://www.balldontlie.io/api/v1/games?start_date=$date&end_date=$date';
  final response = await http.get(Uri.parse(url));

  Map<String, dynamic> gamesMap = jsonDecode(response.body);
  List<dynamic> games = gamesMap["data"];
  games.forEach((game) {
    list.add(Game.fromJson(game));
  });

  return list;
}
