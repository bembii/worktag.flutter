import 'package:flutter/material.dart';
import 'dart:async';
import '../helper.dart';
import '../Model/TimeEntry.dart';
import '../Model/WorkWeek.dart';
import '../States/TimeListState.dart';

class TimeList extends StatefulWidget {
  DateTime date;
  final Future<List<TimeEntry>> data;

  TimeList({this.date, this.data}) {
    this.date = DateTime.now();
  }

  Future<List<TimeEntry>> loadTimeEntries() {
    WorkWeek week = WorkWeek.fromDate(this.date);
    return Helper.getService().getTimeEntries(week);
  }

  @override
  TimeListState createState() => new TimeListState();
}
