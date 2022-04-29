import 'package:flutter/material.dart';
import 'game.dart';
import 'nba_game.dart';
import 'request_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
              child: Text('Scores'),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text("${selectedDate.toLocal()}".split(' ')[0]),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select date'),
              ),
            ],
          ),
          FutureBuilder(
            future: getGames(
                int.parse(selectedDate
                    .toLocal()
                    .toString()
                    .split(' ')[0]
                    .split('-')[0]),
                int.parse(selectedDate
                    .toLocal()
                    .toString()
                    .split(' ')[0]
                    .split('-')[1]),
                int.parse(selectedDate
                    .toLocal()
                    .toString()
                    .split(' ')[0]
                    .split('-')[2])),
            builder:
                (BuildContext context, AsyncSnapshot<List<Game>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final games = snapshot.data!;
                List<Widget> nbaWidgets = [];
                for (int i = 0; i < games.length; i++) {
                  nbaWidgets.add(buildNBAGame(games[i]));
                }
                return Column(
                  children: nbaWidgets,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
