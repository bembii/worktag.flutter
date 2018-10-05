import 'package:flutter/material.dart';
import '../Model/TimeEntry.dart';
import '../States/EditTimeScreenState.dart';

class EditTimeScreen extends StatefulWidget {
  TimeEntry timeEntry;

  EditTimeScreen(TimeEntry entry) : super(key: new Key(entry.toString())) {
    timeEntry = entry;
    if (timeEntry == null) {
      timeEntry = new TimeEntry();
      timeEntry.date = DateTime.now();
      timeEntry.start = new DateTime(
          timeEntry.date.year, timeEntry.date.month, timeEntry.date.day, 7, 30);
      timeEntry.end = new DateTime(
          timeEntry.date.year, timeEntry.date.month, timeEntry.date.day, 16, 0);
    }
  }

  @override
  EditTimeScreenState createState() => new EditTimeScreenState();

  void save(BuildContext context) {
    Navigator.pop(context);
  }
}
