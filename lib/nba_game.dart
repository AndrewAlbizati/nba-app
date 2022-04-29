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
            child: Text(
              game.visitorTeam.abbreviation,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              game.visitorTeamScore.toString() +
                  '  -  ' +
                  game.homeTeamScore.toString() +
                  ' (' +
                  game.status +
                  ')',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              game.homeTeam.abbreviation,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
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
