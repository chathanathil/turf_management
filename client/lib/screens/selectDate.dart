import 'package:flutter/material.dart';

class SelectDate extends StatefulWidget {
  static const routeName = '/select-date';

  @override
  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
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

  void _next() {
    Navigator.of(context).pushNamed("/select-time");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Text("Select Date"),
            InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                height: 10,
                width: 30,
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.purple)),
                child: Text(selectedDate.toString()),
              ),
            ),
            RaisedButton(
              onPressed: _next,
              child: Text("Next"),
            )
          ],
        ),
      ),
    );
  }
}
