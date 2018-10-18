import 'package:flutter/material.dart';
import 'dart:async';

import '../helper.dart';
import '../Model/TimeEntry.dart';
import '../Model/Settings.dart';
import '../Widgets/TimeList.dart';
import '../Widgets/TimeListEntry.dart';

class TimeListState extends State<TimeList> {
  Future<List<TimeEntry>> _dataAsync;
  final _prevWeek = new Duration(days: -6);
  final _nextWeek = new Duration(days: 6);

  Future<void> _onRefresh() {
    Completer<Null> completer = new Completer<Null>();

    setState(() {
      _dataAsync = widget.loadTimeEntries();
    });

    completer.complete();
    return completer.future;
  }

  Function _dateNowButtonPressed() {
    DateTime now = DateTime.now();
    if (DateHelper.equalsDate(widget.date, now))
      return null;
    else {
      return () {
        setState(() {
          widget.date = now;
        });
        _onRefresh();
      };
    }
  }

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('KW ' + Helper.getWeekYearString(widget.date)),
          backgroundColor: Theme.of(context).primaryColorLight,
          primary: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.navigate_before),
              onPressed: () {
                setState(() {
                  widget.date = widget.date.add(_prevWeek);
                });
                _onRefresh();
              },
            ),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: _dateNowButtonPressed(),
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              onPressed: () {
                setState(() {
                  widget.date = widget.date.add(_nextWeek);
                });
                _onRefresh();
              },
            ),
          ],
        ),
        body: new FutureBuilder<List<TimeEntry>>(
          future: _dataAsync,
          builder:
              (BuildContext context, AsyncSnapshot<List<TimeEntry>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('Loading...');
              case ConnectionState.waiting:
                return const Center(
                  child: const CircularProgressIndicator(),
                );
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else {
                  return new RefreshIndicator(
                      child: new ListView.builder(
                          itemCount: snapshot.data.length + 1,
                          itemBuilder: (BuildContext ctx, int index) {
                            if (index == 0) {
                              return new ListTile(
                                leading: const Icon(Icons.info),
                                title: new Text(
                                    'Arbeitszeit: ${this._getWorktimeString(snapshot.data)}'),
                                subtitle: new Text.rich(new TextSpan(children: [
                                  new TextSpan(text: 'Abweichung: '),
                                  new TextSpan(
                                      text:
                                          this._getWorktimeDiffString(snapshot.data),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: this._getWorktime(snapshot.data) >=
                                                  Settings.instance.defaultWorktimePerWeek
                                              ? Colors.green
                                              : Colors.red)),
                                ])),
                              );
                            }
                            index -= 1;
                            TimeEntry entry = snapshot.data[index];
                            return new TimeListEntry(entry);
                          }),
                      onRefresh: _onRefresh);
                }
            }
          },
        ));
  }

  int _getWorktime(List<TimeEntry> times) {
    int time = 0;
    for (TimeEntry t in times) time += t.getWorktimeInMinutes();
    return time;
  }

  String _getWorktimeString(List<TimeEntry> times) {
    return TimeEntry.getMinutesAsString(this._getWorktime(times));
  }

  String _getWorktimeDiffString(List<TimeEntry> times) {
    int time = this._getWorktime(times);
    int totalMinutes = time - Settings.instance.defaultWorktimePerWeek;
    return TimeEntry.getMinutesAsString(totalMinutes);
  }
}
