import 'package:flutter/material.dart';
import '../Model/TimeEntry.dart';
import '../States/TimeListEntryState.dart';

class TimeListEntry extends StatefulWidget {
  TimeEntry _TimeEntry;

  TimeListEntry(TimeEntry entry){
    _TimeEntry = entry;
  }

  @override
  TimeListEntryState createState() => new TimeListEntryState(_TimeEntry);
}