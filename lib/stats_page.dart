import 'package:flutter/material.dart';
import 'game.dart';
import 'player_stats.dart';
import 'appbar.dart';

Scaffold _buildScaffold(Game game, Widget body) {
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

DataTable _buildDataTable(Game g, int teamId) {
  List<DataRow> rows = [];

  // Add players with at least 1 minute played
  List<PlayerStats> sortedStats = [];
  for (PlayerStats stats in g.stats) {
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

  // Build the rows
  for (int i = 0; i < sortedStats.length; i++) {
    rows.add(_buildDataRow(sortedStats[i]));
  }

  return DataTable(
    dataRowHeight: 25,
    columns: [
      DataColumn(label: Text('PLAYER')),
      DataColumn(label: Text('MIN')),
      DataColumn(label: Text('FG')),
      DataColumn(label: Text('3PT')),
      DataColumn(label: Text('REB')),
      DataColumn(label: Text('AST')),
      DataColumn(label: Text('PF')),
      DataColumn(label: Text('PTS')),
    ],
    rows: rows,
  );
}

DataRow _buildDataRow(PlayerStats stats) {
  return DataRow(
    cells: [
      DataCell(Text(stats.firstName.substring(0, 1) + '. ' + stats.lastName)),
      DataCell(Text(stats.min.split(":")[0])),
      DataCell(Text(stats.fgm.toString() + ' - ' + stats.fga.toString())),
      DataCell(Text(stats.fg3m.toString() + ' - ' + stats.fg3a.toString())),
      DataCell(Text(stats.reb.toString())),
      DataCell(Text(stats.ast.toString())),
      DataCell(Text(stats.pf.toString())),
      DataCell(Text(stats.pts.toString())),
    ],
  );
}

Widget buildStatsPage(Game game) {
  if (game.stats.length == 0) {
    return _buildScaffold(
      game,
      Container(
        alignment: Alignment.topCenter,
        child: Text('Stats are not available for this game.'),
      ),
    );
  }

  return _buildScaffold(
    game,
    ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            game.visitorTeam.name,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _buildDataTable(game, game.visitorTeam.id),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            game.homeTeam.name,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _buildDataTable(game, game.homeTeam.id),
        ),
      ],
    ),
  );
}
