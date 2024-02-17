import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelection extends StatefulWidget {
  final String? title;

  const DateSelection({Key? key, this.title}) : super(key: key);

  @override
  _DateSelectionState createState() => _DateSelectionState();
}

class _DateSelectionState extends State<DateSelection> {
  DateTime? _selectedDate;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _someMethodWithDate(DateTime date) {
    // Use the non-nullable 'date' parameter here.
  }

  void _someMethodWithTitle(String title) {
    // Use the non-nullable 'title' parameter here.
  }

  @override
  Widget build(BuildContext context) {
    String titleToUse = widget.title ?? "Default Title";
    _someMethodWithTitle(titleToUse);

    DateTime? dateToUse = _selectedDate;
    if (dateToUse != null) {
      _someMethodWithDate(dateToUse);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(titleToUse),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text(
            _selectedDate == null
            ? 'No date was chosen!'
                : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate!)}',
        style: TextStyle(fontSize: 16),
      ),
              onPressed: () {
                _selectDate(context);
              },
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}