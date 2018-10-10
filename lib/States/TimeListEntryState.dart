import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper.dart';
import '../Localization/WorktagLocalizations.dart';
import '../Widgets/TimeListEntry.dart';
import '../Widgets/EditTimeScreen.dart';

class TimeListEntryState extends State<TimeListEntry> {
  static final weekdayFormatter = new DateFormat.E();

  @override
  Widget build(BuildContext context) {
    if (widget.timeEntry == null) return Text('NULL');

    String weekday = weekdayFormatter.format(widget.timeEntry.start);

    String start = DateHelper.convertTimeToString(widget.timeEntry.start);
    String end = DateHelper.convertTimeToString(widget.timeEntry.end);
    String title = '$start - $end';

    String subtitle = DateHelper.convertDateToString(widget.timeEntry.start);
    if (widget.timeEntry.breakInMinutes != null &&
        widget.timeEntry.breakInMinutes != 0)
      subtitle = '$subtitle - ${WorktagLocalizations.of(context).title_break}: ${widget.timeEntry.breakInMinutes}';

    return new Card(
      child: new Column(
        children: <Widget>[
          new ListTile(
            leading: new Text(weekday),
            title: new Text(title),
            subtitle: new Text(subtitle),
            trailing: new Text.rich(new TextSpan(
                text: widget.timeEntry.getWorktime(),
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    // TODO Einstellung für Arbeitszeit
                    color: widget.timeEntry.getWorktimeInMinutes() >= 480
                        ? Colors.green
                        : Colors.red))),
          ),
          new ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: Text(WorktagLocalizations.of(context).title_modify),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditTimeScreen(widget.timeEntry)),
                    );
                  },
                ),
                new FlatButton(
                  child: new Row(children: <Widget>[
                    const Icon(Icons.delete),
                    Text(WorktagLocalizations.of(context).title_delete),
                  ]),
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  onPressed: () {
                    // TODO: Löschen
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
