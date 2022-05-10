import 'package:flutter/material.dart';
import 'game.dart';

void _showStatPage(Game game, BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: ((context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text('Stats for ' +
                  game.visitorTeam.abbreviation +
                  ' vs ' +
                  game.homeTeam.abbreviation),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text('t'),
            Text('e'),
            Text('s'),
            Text('t'),
          ],
        ),
      ),
    );
  })));
}

Widget buildNBAGame(Game game, BuildContext context) {
  return Container(
    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
    child: TextButton(
      onPressed: () => _showStatPage(game, context),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/team-logos/' + game.visitorTeam.id.toString() + '.png',
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
                  game.visitorTeamScore.toString() +
                      '  -  ' +
                      game.homeTeamScore.toString() +
                      '\n' +
                      game.status,
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
                'assets/team-logos/' + game.homeTeam.id.toString() + '.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
