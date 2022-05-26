import 'package:flutter/material.dart';
import '../models/player.dart';
import '../screens/player_info_page.dart';

Future<void> _showPlayerPage(Player player, BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) {
        return buildPlayerPage(player);
      }),
    ),
  );
}

Widget buildPlayerCard(Player player, BuildContext context) {
  return TextButton(
    child: Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: SizedBox(
        height: 50,
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
    onPressed: () => _showPlayerPage(player, context),
  );
}
