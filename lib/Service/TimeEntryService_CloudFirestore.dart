import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'TimeEntryService.dart';
import '../Model/TimeEntry.dart';
import '../Model/WorkWeek.dart';
import '../helper.dart';

class TimeEntryService_CloudFirestore extends TimeEntryService {
  Firestore _firestore;

  Future<Firestore> _resolveFirestore() async {
    if (_firestore == null) {
      _firestore = Firestore.instance;
    }
    return _firestore;
  }

  @override
  Future<TimeEntry> saveTimeEntry(TimeEntry entry) async {
    final db = await _resolveFirestore();
    final week = WorkWeek.fromDate(entry.date);
    TimeEntry newEntry = entry;
    await db
        .document('/users/test/years/${week.year}/weeks/${week.week}')
        .collection('entries')
        .add(_toDocument(entry))
        .then((v) {
          entry.ID = v.documentID;
        });
    return newEntry;
  }

  @override
  Future deleteTimeEntry(TimeEntry entry) async {
    final db = await _resolveFirestore();
    final week = WorkWeek.fromDate(entry.date);
    await db.document('/users/test/years/${week.year}/weeks/${week.week}/entries/${entry.ID}').delete();
  }

  @override
  Future<List<TimeEntry>> getTimeEntries(WorkWeek weekYear) async {
    List<TimeEntry> entries = new List();
    final db = await _resolveFirestore();
    await db
        .document('/users/test/years/${weekYear.year}/weeks/${weekYear.week}')
        .collection('entries')
        .getDocuments()
        .then((v) {
      print('Got ${v.documents.length} Documents');
      for (DocumentSnapshot d in v.documents) {
        TimeEntry entry = _fromDocument(d.data);
        entry.ID = d.documentID;
        entries.add(entry);
      }
    });
    return entries;
  }

  TimeEntry _fromDocument(Map<String, dynamic> map) {
    var entry = new TimeEntry();
    entry.date = map['date'];
    entry.start = map['start'];
    entry.end = map['end'];
    entry.breakInMinutes = map['break'];
    return entry;
  }

  Map<String, dynamic> _toDocument(TimeEntry entry) {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["date"] = entry.date;
    map["start"] = entry.start;
    map["end"] = entry.end;
    map["break"] = entry.breakInMinutes;
    return map;
  }
}
