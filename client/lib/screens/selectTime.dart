import 'package:flutter/material.dart';

class SelectTime extends StatelessWidget {
  static const routeName = "/select-time";

  void _next(BuildContext context) {
    Navigator.of(context).pushNamed("/select-team");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Text("Select time"),
            InkWell(
              onTap: () => _next(context),
              child: Text("1am to 2am"),
            ),
            InkWell(
              onTap: null,
              child: Text("1am to 2am"),
            ),
            InkWell(
              onTap: null,
              child: Text("1am to 2am"),
            ),
            InkWell(
              onTap: null,
              child: Text("1am to 2am"),
            ),
          ],
        ),
      ),
    );
  }
}
