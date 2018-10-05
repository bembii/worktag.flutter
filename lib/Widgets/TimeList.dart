import 'package:flutter/material.dart';
import 'dart:async';
import '../Model/TimeEntry.dart';
import '../States/TimeListState.dart';

class TimeList extends StatefulWidget {
  DateTime date;
  final Future<List<TimeEntry>> data;

  TimeList({this.date, this.data}){
    this.date = DateTime.now();
  }

  Future<List<TimeEntry>> loadTimeEntries() async {
    List<TimeEntry> entries = new List();
    for (int i = 0; i < 10; i++) {
      TimeEntry entry = new TimeEntry();
      entry.date = this.date;
      entry.start = this.date.add(new Duration(hours: -3));
      entry.end = this.date.add(new Duration(hours: 5));
      entry.breakInMinutes = 30;
      entries.add(entry);
    }
    return entries;
  }

  @override
  TimeListState createState() => new TimeListState();
}