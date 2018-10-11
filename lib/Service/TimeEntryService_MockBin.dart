import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'TimeEntryService.dart';
import '../Model/TimeEntry.dart';
import '../Model/WorkWeek.dart';
import '../helper.dart';

class TimeEntryService_MockBin extends TimeEntryService {
  static const _serviceUrl = 'http://mockbin.org/echo';
  static final _headers = {'Content-Type': 'application/json'};

  @override
  Future<TimeEntry> saveTimeEntry(TimeEntry entry) async {
    try {
      String json = _toJson(entry);
      final response =
          await http.post(_serviceUrl, headers: _headers, body: json);
      var c = _fromJson(response.body);
      return c;
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }

  @override
  Future deleteTimeEntry(TimeEntry entry) async {
    try {
      String json = _toJson(entry);
      final response =
      await http.post(_serviceUrl, headers: _headers, body: json);
      var c = _fromJson(response.body);
      return c;
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }

  @override
  Future<List<TimeEntry>> getTimeEntries(WorkWeek weekYear) async {
    try {
      return Future.delayed(new Duration(seconds: 2), () {
        List<TimeEntry> entries = new List();
        if (weekYear != null) {
          DateTime start = weekYear.start;
          while (start.isBefore(weekYear.end)) {
            TimeEntry entry = new TimeEntry();
            entry.date = start;
            entry.start =
                new DateTime(start.year, start.month, start.day, 8, 30);
            entry.end = new DateTime(start.year, start.month, start.day, 17);
            entry.breakInMinutes = 30;
            entries.add(entry);

            start = start.add(new Duration(days: 1));
          }
        }
        return entries;
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  TimeEntry _fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    var entry = new TimeEntry();
    entry.date = DateHelper.parseDate(map['date']);
    entry.start =
        DateHelper.convertTimeToDate(DateHelper.parseTimeOfDay(map['start']));
    entry.end =
        DateHelper.convertTimeToDate(DateHelper.parseTimeOfDay(map['end']));
    entry.breakInMinutes = int.parse(map['break']);
    return entry;
  }

  String _toJson(TimeEntry entry) {
    var mapData = new Map();
    mapData["date"] = DateHelper.convertDateToString(entry.date);
    mapData["start"] = DateHelper.convertTimeToString(entry.start);
    mapData["end"] = DateHelper.convertTimeToString(entry.end);
    mapData["break"] = entry.breakInMinutes.toString();
    String json = jsonEncode(mapData);
    return json;
  }
}
