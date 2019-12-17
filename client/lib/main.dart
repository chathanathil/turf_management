import 'package:client/screens/dashBoard.dart';
import 'package:flutter/material.dart';

import './screens/confirmation.dart';
import './screens/login.dart';
import './screens/selectDate.dart';
import './screens/selectTime.dart';
import './screens/selectTeam.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turf',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
      ),
      home: Login(),
      routes: {
        DashBoard.routeName: (ctx) => DashBoard(),
        SelectDate.routeName: (ctx) => SelectDate(),
        SelectTime.routeName: (ctx) => SelectTime(),
        SelectTeam.routeName: (ctx) => SelectTeam(),
        Confirmation.routeName: (ctx) => Confirmation()
      },
    );
  }
}
