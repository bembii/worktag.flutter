import 'dart:async';

import '../Model/TimeEntry.dart';
import '../Model/WorkWeek.dart';

abstract class TimeEntryService {
  Future<TimeEntry> saveTimeEntry(TimeEntry entry);

  Future deleteTimeEntry(TimeEntry entry);

  Future<List<TimeEntry>> getTimeEntries(WorkWeek weekYear);
}
