import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'WorktagService.dart';
import '../Model/TimeEntry.dart';
import '../Model/WorkWeek.dart';
import '../Model/Settings.dart';
import '../helper.dart';

class WorktagService_CloudFirestore extends WorktagService {
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

    if (entry.ID == null) {
      await db
          .document('/users/test/years/${week.year}/weeks/${week.week}')
          .collection('entries')
          .add(timeEntryToMap(entry))
          .then((v) {
        newEntry.ID = v.documentID;
      });
    } else {
      await db
          .document('/users/test/years/${week.year}/weeks/${week.week}/entries/${entry.ID}')
          .updateData(timeEntryToMap(entry));
    }
    return newEntry;
  }

  @override
  Future deleteTimeEntry(TimeEntry entry) async {
    final db = await _resolveFirestore();
    final week = WorkWeek.fromDate(entry.date);
    await db
        .document(
            '/users/test/years/${week.year}/weeks/${week.week}/entries/${entry.ID}')
        .delete();
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
        TimeEntry entry = timeEntryFromMap(d.data);
        entry.ID = d.documentID;
        entries.add(entry);
      }
    });
    return entries;
  }

  @override
  Future<Settings> loadSettings() async{
    Settings settings;
    final db = await _resolveFirestore();
    await db.document('/users/test/settings/default').get().then((d) {
      settings = settingsFromMap(d.data);
    });
    return settings;
  }

  @override
  Future saveSettings() {}
}
