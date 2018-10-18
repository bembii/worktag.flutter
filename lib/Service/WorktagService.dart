import 'dart:async';

import '../Model/TimeEntry.dart';
import '../Model/WorkWeek.dart';
import '../Model/Settings.dart';

abstract class WorktagService {
  Future<TimeEntry> saveTimeEntry(TimeEntry entry);

  Future deleteTimeEntry(TimeEntry entry);

  Future<List<TimeEntry>> getTimeEntries(WorkWeek weekYear);

  Future<Settings> loadSettings();

  Future saveSettings();

  Map<String, dynamic> timeEntryToMap(TimeEntry entry) {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["date"] = entry.date;
    map["start"] = entry.start;
    map["end"] = entry.end;
    map["break"] = entry.breakInMinutes;
    return map;
  }

  TimeEntry timeEntryFromMap(Map<String, dynamic> map) {
    var entry = new TimeEntry();
    entry.date = map['date'];
    entry.start = map['start'];
    entry.end = map['end'];
    entry.breakInMinutes = map['break'];
    return entry;
  }

  Map<String, dynamic> settingsToMap(Settings settings) {
    Map<String, dynamic> map = new Map<String, dynamic>();
    return map;
  }

  Settings settingsFromMap(Map<String, dynamic> map) {
    var settings = new Settings();
    return settings;
  }
}
