import 'package:flutter/material.dart';
import 'game.dart';
import 'player_stats.dart';
import 'appbar.dart';

Scaffold _buildScaffold(Game game, Widget body) {
  return Scaffold(
    appBar: buildAppBar(
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Text('Stats for ' +
            game.visitorTeam.abbreviation +
            ' vs ' +
            game.homeTeam.abbreviation),
      ),
    ),
    body: body,
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
    Container(),
  );
}
