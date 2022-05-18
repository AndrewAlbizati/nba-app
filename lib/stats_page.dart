import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'game.dart';
import 'player_stats.dart';
import 'request_data.dart';
import 'appbar.dart';

Scaffold buildScaffold(Game game, Widget body) {
  return Scaffold(
    appBar: buildAppBar(
      Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Stats for ' +
              game.visitorTeam.abbreviation +
              ' vs ' +
              game.homeTeam.abbreviation),
        ),
      ),
    ),
    body: body,
  );
}

Widget buildStatsTable(Game game, int teamId) {
  List<String> columnTitles = ["MIN", "FG", "3PT", "REB", "AST", "PF", "PTS"];
  List<String> rowTitles = [];
  List<List<String>> data = [[], [], [], [], [], [], []];

  List<PlayerStats> sortedStats = [];
  for (PlayerStats stats in game.stats) {
    if (stats.teamId == teamId &&
        stats.min != '' &&
        stats.min.split(':')[0] != '0') {
      sortedStats.add(stats);
    }
  }
  // Sort the list by minutes played
  sortedStats.sort((a, b) {
    int player1Time = (int.parse(a.min.split(":")[0]) * 60) +
        (int.parse(a.min.split(":")[1]));
    int player2Time = (int.parse(b.min.split(":")[0]) * 60) +
        (int.parse(b.min.split(":")[1]));
    return player1Time.compareTo(player2Time);
  });
  sortedStats = List.from(sortedStats.reversed);

  for (PlayerStats ps in sortedStats) {
    rowTitles.add(ps.firstName.substring(0, 1) + ". " + ps.lastName);
    data[0].add(ps.min.split(":")[0]);
    data[1].add(ps.fgm.toString() + ' - ' + ps.fga.toString());
    data[2].add(ps.fg3m.toString() + ' - ' + ps.fg3a.toString());
    data[3].add(ps.reb.toString());
    data[4].add(ps.ast.toString());
    data[5].add(ps.pf.toString());
    data[6].add(ps.pts.toString());
  }

  return StickyHeadersTable(
    columnsLength: columnTitles.length,
    rowsLength: rowTitles.length,
    columnsTitleBuilder: (i) => Text(columnTitles[i]),
    rowsTitleBuilder: (i) => Text(rowTitles[i]),
    contentCellBuilder: (i, j) => Text(data[i][j]),
    legendCell: Text('PLAYER'),
  );
}

Future<Widget> buildStatsPage(Game game) async {
  game.stats = await getStats(game.id);
  if (game.stats.length == 0) {
    return buildScaffold(
      game,
      Container(
        alignment: Alignment.topCenter,
        child: Text('Stats are not available for this game.'),
      ),
    );
  }

  return buildScaffold(
    game,
    Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.topLeft,
          child: Text(
            game.visitorTeam.name,
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
        Expanded(
          child: buildStatsTable(game, game.visitorTeam.id),
        ),
        Divider(),
        Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.topLeft,
          child: Text(
            game.homeTeam.name,
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
        Expanded(
          child: buildStatsTable(game, game.homeTeam.id),
        ),
      ],
    ),
  );
}
