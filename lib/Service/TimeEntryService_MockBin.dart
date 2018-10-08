import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'TimeEntryService.dart';
import '../Model/TimeEntry.dart';
import '../helper.dart';

class TimeEntryService_MockBin extends TimeEntryService {
  static const _serviceUrl = 'http://mockbin.org/echo';
  static final _headers = {'Content-Type': 'application/json'};

  @override
  Future<TimeEntry> createTimeEntry(TimeEntry entry) async {
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

  TimeEntry _fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    var entry = new TimeEntry();
    entry.date = Helper.convertToDate(map['date']);
    entry.start = Helper.convertTimeToDate(Helper.convertToTimeOfDay(map['start']));
    entry.end = Helper.convertTimeToDate(Helper.convertToTimeOfDay(map['end']));
    entry.breakInMinutes = int.parse(map['break']);
    return entry;
  }

  String _toJson(TimeEntry entry) {
    var mapData = new Map();
    mapData["date"] = Helper.convertDateToString(entry.date);
    mapData["start"] = Helper.convertTimeToString(entry.start);
    mapData["end"] = Helper.convertTimeToString(entry.start);
    mapData["break"] = entry.breakInMinutes.toString();
    String json = jsonEncode(mapData);
    return json;
  }
}
