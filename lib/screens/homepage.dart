import 'package:flutter/material.dart';
import '../models/game.dart';
import '../widgets/nba_game.dart';
import '../cloud_functions/balldontlie.dart';
import '../widgets/appbar.dart';

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
        firstDate: DateTime(2000, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _incrementDate() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
  }

  void _decrementDate() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
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
      appBar: buildAppBar(
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Text('Scores'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topCenter,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back),
                            Text(
                              'Back',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          _decrementDate();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        '${selectedDate.toLocal()}'.split(' ')[0],
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: Text(
                          'Select date',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () => setState(() {}),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        child: Row(
                          children: [
                            Text(
                              'Forward',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                        onPressed: () {
                          _incrementDate();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: FutureBuilder(
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
                    .split('-')[2]),
              ),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Game>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final games = snapshot.data!;
                  if (games.length == 0) {
                    return Text('No NBA games');
                  } else {
                    List<Widget> nbaWidgets = [];
                    for (int i = 0; i < games.length; i++) {
                      nbaWidgets.add(buildNBAGame(games[i], context));
                    }
                    return ListView(
                      children: nbaWidgets,
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
