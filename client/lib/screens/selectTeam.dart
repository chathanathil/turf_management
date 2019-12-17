import 'package:flutter/material.dart';

class SelectTeam extends StatelessWidget {
  static const routeName = "/select-team";

  void _next(BuildContext context) {
    Navigator.of(context).pushNamed("/confirmation");
  } 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            InkWell(
              onTap: () => _next(context),
              child: Text("7s"),
            ),
            InkWell(
              onTap: null,
              child: Text("5s A"),
            ),
            InkWell(
              onTap: null,
              child: Text("5s B"),
            ),
          ],
        ),
      ),
    );
  }
}
