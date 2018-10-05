import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Widgets/TimeListEntry.dart';
import '../Widgets/EditTimeScreen.dart';

class TimeListEntryState extends State<TimeListEntry> {
  static final weekdayFormatter = new DateFormat.E();
  static final timeFormatter = new DateFormat.jm();
  static final dateFormatter = new DateFormat.yMd();

  @override
  Widget build(BuildContext context) {
    if (widget.timeEntry == null) return Text('NULL');

    String weekday = weekdayFormatter.format(widget.timeEntry.start);

    String start = timeFormatter.format(widget.timeEntry.start);
    String end = timeFormatter.format(widget.timeEntry.end);
    String title = '$start - $end';

    String subtitle = dateFormatter.format(widget.timeEntry.start);
    if (widget.timeEntry.breakInMinutes != null)
      subtitle = '$subtitle - Break: ${widget.timeEntry.breakInMinutes}';

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
                    color: widget.timeEntry.getWorktimeInMinutes() >= 480
                        ? Colors.green
                        : Colors.red))),
          ),
          new ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: new ButtonBar(
              children: <Widget>[
                new FlatButton(
                  child: const Text('Modify'),
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
                    const Text('Delete'),
                  ]),
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () {
                    /* ... */
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
