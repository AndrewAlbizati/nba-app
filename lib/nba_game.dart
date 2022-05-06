import 'package:flutter/material.dart';
import 'game.dart';

Widget buildNBAGame(Game game) {
  return Container(
    padding: EdgeInsets.all(15),
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
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                game.visitorTeam.abbreviation,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              game.visitorTeamScore.toString() +
                  '  -  ' +
                  game.homeTeamScore.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              game.status,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Text(
                game.homeTeam.abbreviation,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 25.0,
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
  );
}
