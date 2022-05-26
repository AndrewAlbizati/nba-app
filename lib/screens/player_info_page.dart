import 'package:flutter/material.dart';
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
