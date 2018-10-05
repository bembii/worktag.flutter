import 'package:flutter/material.dart';
import '../Model/TimeEntry.dart';
import '../States/TimeListEntryState.dart';

class TimeListEntry extends StatefulWidget {
  TimeEntry timeEntry;

  TimeListEntry(TimeEntry entry) : super(key: new Key(entry.toString()))  {
    timeEntry = entry;
  }

  @override
  TimeListEntryState createState() => new TimeListEntryState();
}