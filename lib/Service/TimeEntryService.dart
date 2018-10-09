import 'dart:async';

import '../Model/TimeEntry.dart';
import '../Model/WorkWeek.dart';

abstract class TimeEntryService{
  Future<TimeEntry> createTimeEntry(TimeEntry entry);
  Future<List<TimeEntry>> getTimeEntries(WorkWeek weekYear);
}