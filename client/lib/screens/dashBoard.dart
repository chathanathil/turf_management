import 'package:client/widgets/slot.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  static const routeName = '/dash-board';
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void _addMatch() {
    Navigator.of(context).pushNamed("/select-date");
  }

  List<Map<String, String>> teams = [
    {"time": "2am-3am", "name": "fahad", "phone": "9645508854", "team": "7s"},
    {"time": "2am-3am", "name": "fahad", "phone": "9645508854", "team": "7s"},
    {"time": "2am-3am", "name": "fahad", "phone": "9645508854", "team": "7s"}
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _addMatch,
          child: Icon(Icons.add),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  height: 60,
                  width: 200,
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.purple)),
                  child: Text(selectedDate.toString()),
                ),
              ),
              Container(
                height: 300,
                child: ListView.builder(
                  itemCount: teams.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Slot(
                        time: teams[index]['time'],
                        name: teams[index]['name'],
                        phone: teams[index]['phone'],
                        team: teams[index]['team']);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
