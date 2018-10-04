import 'package:flutter/material.dart';
import '../Model/TimeEntry.dart';
import '../Widgets/TimeListEntry.dart';

class TimeListEntryState extends State<TimeListEntry> {
  TimeEntry _TimeEntry;

  TimeListEntryState(TimeEntry entry){
    _TimeEntry = entry;
  }

  @override
  Widget build(BuildContext context) {
    if (_TimeEntry == null)
      return Text('NULL');
    return Text(_TimeEntry.start.toString() + " - " + _TimeEntry.end.toString());
  }
}