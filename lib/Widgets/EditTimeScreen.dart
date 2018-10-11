import 'package:flutter/material.dart';
import '../Model/TimeEntry.dart';
import '../States/EditTimeScreenState.dart';
import '../helper.dart';

class EditTimeScreen extends StatefulWidget {
  TimeEntry timeEntry;

  EditTimeScreen(TimeEntry entry) : super(key: new Key(entry.toString())) {
    timeEntry = entry;
    // TODO: Einstellungen für Standardwerte
    if (timeEntry == null) {
      timeEntry = new TimeEntry();
      timeEntry.date = DateTime.now();
      timeEntry.start = new DateTime(
          timeEntry.date.year, timeEntry.date.month, timeEntry.date.day, 7, 30);
      timeEntry.end = new DateTime(
          timeEntry.date.year, timeEntry.date.month, timeEntry.date.day, 16, 0);
      timeEntry.breakInMinutes = 0;
    }
  }

  @override
  EditTimeScreenState createState() {
    LogHelper.analytics.setCurrentScreen(screenName: "EditScreen");
    return new EditTimeScreenState();
  }

  void save(BuildContext context) {
    var service = Helper.getService();
    service.saveTimeEntry(this.timeEntry)
        .then((value)
        {
          LogHelper.analytics.setCurrentScreen(screenName: "MainScreen");
          Navigator.of(context).pop(true);
        }
    );
  }
}
