import 'package:flutter/material.dart';
import 'dart:async';
import '../helper.dart';
import '../Model/TimeEntry.dart';
import '../Widgets/TimeList.dart';
import '../Widgets/TimeListEntry.dart';

class TimeListState extends State<TimeList> {
  List<TimeEntry> _data = new List();

  void _addEntries(List<TimeEntry> entries) {
    setState(() {
      _data.clear();
      _data.addAll(entries);
    });
  }

  Future<Null> _onRefresh() {
    Completer<Null> completer = new Completer<Null>();

    widget.loadTimeEntries().then((entries) => _addEntries(entries));
    completer.complete();

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KW ' + Helper.getWeekYear(widget.date)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_before),
            onPressed: () {
              setState(() {
                widget.date = widget.date.add(new Duration(days: -7));
              });
              _onRefresh();
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              setState(() {
                widget.date = DateTime.now();
              });
              _onRefresh();
            },
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            onPressed: () {
              setState(() {
                widget.date = widget.date.add(new Duration(days: 7));
              });
              _onRefresh();
            },
          ),
        ],
      ),
      body: new RefreshIndicator(
          child: new ListView.builder(
              itemCount: _data.length,
              itemBuilder: (BuildContext ctx, int index) {
                TimeEntry entry = _data[index];
                return new TimeListEntry(entry);
              }),
          onRefresh: _onRefresh),
    );
  }
}
