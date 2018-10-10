import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/date_symbol_data_local.dart';

import '../helper.dart';
import '../Model/TimeEntry.dart';
import '../Widgets/TimeList.dart';
import '../Widgets/TimeListEntry.dart';

class TimeListState extends State<TimeList> {
  Future<List<TimeEntry>> _dataAsync;

  Future<void> _onRefresh() {
    Completer<Null> completer = new Completer<Null>();

    setState(() {
      _dataAsync = widget.loadTimeEntries();
    });

    completer.complete();
    return completer.future;
  }

  Function _dateNowButtonPressed() {
    if (DateHelper.equalsDate(widget.date, DateTime.now()))
      return null;
    else {
      return () {
        setState(() {
          widget.date = DateTime.now();
        });
        _onRefresh();
      };
    }
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
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
                  widget.date = widget.date.add(new Duration(days: -7));
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
                  widget.date = widget.date.add(new Duration(days: 7));
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
                return const Center(child: const CircularProgressIndicator(),);
              default:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else {
                  return new RefreshIndicator(
                      child: new ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            TimeEntry entry = snapshot.data[index];
                            return new TimeListEntry(entry);
                          }),
                      onRefresh: _onRefresh);
                }
            }
          },
        )
        );
  }
}
