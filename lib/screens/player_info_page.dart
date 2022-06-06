import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import '../cloud_functions/balldontlie.dart';
import '../models/player_season_average.dart';
import '../models/player.dart';
import '../widgets/appbar.dart';

Scaffold buildScaffold(Player player, Widget body) {
  return Scaffold(
    appBar: buildAppBar(
      Flexible(
        child: Container(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Text(
            'Player Info for ${player.firstName} ${player.lastName}',
            overflow: TextOverflow.fade,
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
    'FG%',
    'FG3%',
    'REB',
    'AST',
    'PTS',
  ];
  List<String> rowTitles = [];
  List<List<String>> data = [[], [], [], [], [], [], []];

  // Iterate through 1979 - current year
  var currentYear = DateTime.now().year;
  for (int season = 1979; season < currentYear; season++) {
    print(season);
    PlayerSeasonAverage psa = await getPlayerSeasonAverage(player.id, season);
    if (psa.isEmpty) {
      continue;
    }

    // Organize the stats for the table
    rowTitles.add(_seasonToString(season));
    data[0].add('${psa.gamesPlayed}');
    data[1].add(psa.min);
    data[2].add('${(psa.fg_pct * 100).toStringAsFixed(1)}%');
    data[3].add('${(psa.fg3_pct * 100).toStringAsFixed(1)}%');
    data[4].add(psa.reb.toStringAsFixed(1));
    data[5].add(psa.ast.toStringAsFixed(1));
    data[6].add(psa.pts.toStringAsFixed(1));
  }

  // Create table
  return StickyHeadersTable(
    columnsLength: columnTitles.length,
    rowsLength: rowTitles.length,
    columnsTitleBuilder: (i) => Text(columnTitles[i]),
    rowsTitleBuilder: (i) => Text(rowTitles[i]),
    contentCellBuilder: (i, j) => Text(data[i][j]),
    legendCell: Text('YEAR'),
  );
}

String _seasonToString(int season) {
  String s = '\'';
  if ((season % 100) < 10) {
    s += '0${season % 100}';
  } else {
    s += '${season % 100}';
  }

  s += ' - \'';
  if (((season + 1) % 100) < 10) {
    s += '0${(season + 1) % 100}';
  } else {
    s += '${(season + 1) % 100}';
  }

  return s;
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
          Expanded(
            flex: 8,
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
                  Divider(),
                  Text(
                    'Regular Season Averages',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: buildStatsTable(player),
                      builder: (BuildContext context,
                          AsyncSnapshot<Widget> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: CircularProgressIndicator(),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text('Collecting data...'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return snapshot.data!;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
