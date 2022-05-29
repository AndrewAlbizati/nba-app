import 'package:flutter/material.dart';
import '../models/game.dart';
import '../screens/stats_page.dart';

Future<void> _showStatPage(Game game, BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) {
        return FutureBuilder(
          future: buildStatsPage(game),
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: buildScaffold(
                  game,
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            } else {
              return snapshot.data!;
            }
          },
        );
      }),
    ),
  );
}

Widget buildNBAGame(Game game, BuildContext context) {
  return Container(
    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
    child: TextButton(
      onPressed: () => _showStatPage(game, context),
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/team-logos/${game.visitorTeam.id}.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  game.visitorTeam.abbreviation,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  (() {
                    if (game.postseason) {
                      return '${game.visitorTeamScore}  -  ${game.homeTeamScore}\n${game.status}\n${game.postseasonStatus}';
                    }

                    return '${game.visitorTeamScore}  -  ${game.homeTeamScore}\n${game.status}';
                  })(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Text(
                  game.homeTeam.abbreviation,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/team-logos/${game.homeTeam.id}.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
