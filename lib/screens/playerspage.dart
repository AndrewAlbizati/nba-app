import 'package:flutter/material.dart';
import '../widgets/appbar.dart';

class PlayersPage extends StatefulWidget {
  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
      body: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search),
      ),
    );
  }
}
