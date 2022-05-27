import 'package:flutter/material.dart';
import 'package:nba_app/cloud_functions/balldontlie.dart';
import 'package:nba_app/models/player_season_average.dart';
import '../models/player.dart';
import '../widgets/appbar.dart';

Scaffold buildScaffold(Player player, Widget body) {
  return Scaffold(
    appBar: buildAppBar(
      Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Player Info for ${player.firstName} ${player.lastName}',
          ),
        ),
      ),
    ),
    body: body,
  );
}

Future<Widget> buildStatsTable(Player player) async {
  List<String> columnTitles = [
    'GP',
    'MIN',
    'FG',
    '3PT',
    'REB',
    'AST',
    'PF',
    'PTS'
  ];
  List<String> rowTitles = [];
  List<List<String>> data = [[], [], [], [], [], [], [], []];

  // Organize the stats for the table
  for (int season = 1979; season < 2022; season++) {
    PlayerSeasonAverage average =
        await getPlayerSeasonAverage(player.id, season);
    for (PlayerStats ps in sortedStats) {
      rowTitles.add('${ps.firstName.substring(0, 1)}. ${ps.lastName}');
      data[0].add(ps.min.split(':')[0]);
      data[1].add('${ps.fgm} - ${ps.fga}');
      data[2].add('${ps.fg3m} - ${ps.fg3a}');
      data[3].add('${ps.reb}');
      data[4].add('${ps.ast}');
      data[5].add('${ps.pf}');
      data[6].add('${ps.pts}');
    }
  }

  // Create table for a specific team
  return StickyHeadersTable(
    columnsLength: columnTitles.length,
    rowsLength: rowTitles.length,
    columnsTitleBuilder: (i) => Text(columnTitles[i]),
    rowsTitleBuilder: (i) => Text(rowTitles[i]),
    contentCellBuilder: (i, j) => Text(data[i][j]),
    legendCell: Text('PLAYER'),
  );
}

Widget buildPlayerPage(Player player) {
  return buildScaffold(
    player,
    Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/team-logos/${player.team.id}.png',
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              alignment: Alignment.topCenter,
              child: Text(
                '${player.firstName} ${player.lastName}',
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
          Divider(),
          Expanded(
            flex: 10,
            child: Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  if (player.position.isNotEmpty) ...[
                    Row(
                      children: [
                        Text(
                          'Position: ',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${player.position}',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (player.heightFeet != -1 && player.heightInches != -1) ...[
                    Row(
                      children: [
                        Text(
                          'Height: ',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${player.heightFeet}\' ${player.heightInches}"',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (player.weightPounds != -1) ...[
                    Row(
                      children: [
                        Text(
                          'Weight: ',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${player.weightPounds} lbs',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
