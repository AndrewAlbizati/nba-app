import 'package:flutter/material.dart';
import '../widgets/player_info_card.dart';
import '../widgets/appbar.dart';
import '../models/player.dart';
import '../cloud_functions/balldontlie.dart';

class PlayersPage extends StatefulWidget {
  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  List<Widget> _players = [];
  final _searchbarController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchbarController.dispose();
    super.dispose();
  }

  Future<void> _updateList() async {
    _players.clear();
    String query = _searchbarController.text;
    if (query.isNotEmpty) {
      List<Player> players = await getPlayers(query, 10);
      for (Player player in players) {
        _players.add(buildPlayerCard(player, context));
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Text('Players'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    flex: 9,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for a player',
                      ),
                      controller: _searchbarController,
                      onChanged: (text) async => _updateList(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async => _updateList(),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: _players.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => _players[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
