import 'package:flutter/material.dart';
import '../models/player.dart';

Widget buildPlayerInfo(Player player) {
  return TextButton(
    child: Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/team-logos/${player.team.id}.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            Expanded(
              flex: 12,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  '${player.firstName} ${player.lastName}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    onPressed: () {},
  );
}
