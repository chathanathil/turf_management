import 'package:flutter/material.dart';

class Slot extends StatelessWidget {
  final String time;
  final String name;
  final String phone;
  final String team;
  Slot({this.time, this.name, this.phone, this.team});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(time),
      title: Text(name),
      subtitle: Text(phone),
      trailing: Text(team),
    );
  }
}
