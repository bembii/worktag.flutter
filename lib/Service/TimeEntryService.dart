import 'dart:async';

import '../Model/TimeEntry.dart';

abstract class TimeEntryService{
  Future<TimeEntry> createTimeEntry(TimeEntry entry);
}