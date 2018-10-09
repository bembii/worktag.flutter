import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import '../helper.dart';
import '../Localization/WorktagLocalizations.dart';
import '../Widgets/EditTimeScreen.dart';

class EditTimeScreenState extends State<EditTimeScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<String> _places = <String>['', 'red', 'green', 'blue', 'orange'];
  String _place = '';

  TextEditingController _controllerDate;
  TextEditingController _controllerTimeStart;
  TextEditingController _controllerTimeEnd;

  @override
  void initState() {
    super.initState();
    _controllerDate = new TextEditingController(
        text: DateHelper.convertDateToString(widget.timeEntry.date));
    _controllerTimeStart = new TextEditingController(
        text: DateHelper.convertTimeToString(widget.timeEntry.start));
    _controllerTimeEnd = new TextEditingController(
        text: DateHelper.convertTimeToString(widget.timeEntry.end));
  }

  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var firstDate = now.add(new Duration(days: -100));
    var lastDate = now.add(new Duration(days: 100));
    var initialDate = DateHelper.parseDate(initialDateString) ?? now;
    initialDate =
        (initialDate.isAfter(firstDate) && initialDate.isBefore(lastDate)
            ? initialDate
            : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);

    if (result == null) return;

    setState(() {
      _controllerDate.text = new DateFormat.yMd().format(result);
    });
  }

  Future _chooseTime(
      bool start, BuildContext context, String initialTimeString) async {
    var now = new TimeOfDay.now();
    var initialTime = DateHelper.parseDate(initialTimeString) ?? now;

    var result =
        await showTimePicker(context: context, initialTime: initialTime);

    if (result == null) return;

    DateTime dt = DateHelper.convertTimeToDate(result);

    setState(() {
      if (start)
        _controllerTimeStart.text = DateHelper.convertTimeToString(dt);
      else
        _controllerTimeEnd.text = DateHelper.convertTimeToString(dt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(WorktagLocalizations.of(context).screen_edit),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _submitForm();
            },
          ),
        ],
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new Row(children: <Widget>[
                    new Expanded(
                        child: new TextFormField(
                      decoration: new InputDecoration(
                        icon: const Icon(Icons.calendar_today),
                        hintText: 'Enter the date',
                        labelText: WorktagLocalizations.of(context).title_date,
                      ),
                      controller: _controllerDate,
                      keyboardType: TextInputType.datetime,
                      validator: (val) =>
                          isValidDate(val) ? null : 'Not a valid date',
                      onSaved: (val) =>
                          widget.timeEntry.date = DateHelper.parseDate(val),
                    )),
                    new IconButton(
                      icon: new Icon(Icons.more_horiz),
                      tooltip: 'Choose date',
                      onPressed: (() {
                        _chooseDate(context, _controllerDate.text);
                      }),
                    )
                  ]),
                  new Row(children: <Widget>[
                    new Expanded(
                        child: new TextFormField(
                      decoration: new InputDecoration(
                        icon: const Icon(Icons.timer),
                        hintText: 'Enter the start time',
                        labelText: WorktagLocalizations.of(context).title_start,
                      ),
                      controller: _controllerTimeStart,
                      keyboardType: TextInputType.datetime,
                      validator: (val) =>
                          isValidTime(val) ? null : 'Not a valid time',
                      onSaved: (val) => widget.timeEntry.start =
                          DateHelper.convertTimeToDate(
                              DateHelper.parseTimeOfDay(val)),
                    )),
                    new IconButton(
                      icon: new Icon(Icons.more_horiz),
                      tooltip: 'Choose time',
                      onPressed: (() {
                        _chooseTime(true, context, _controllerTimeStart.text);
                      }),
                    )
                  ]),
                  new Row(children: <Widget>[
                    new Expanded(
                        child: new TextFormField(
                      decoration: new InputDecoration(
                        icon: const Icon(Icons.timer_off),
                        hintText: 'Enter the end time',
                        labelText: WorktagLocalizations.of(context).title_end,
                      ),
                      controller: _controllerTimeEnd,
                      keyboardType: TextInputType.datetime,
                      validator: (val) =>
                          isValidTime(val) ? null : 'Not a valid time',
                      onSaved: (val) => widget.timeEntry.start =
                          DateHelper.convertTimeToDate(
                              DateHelper.parseTimeOfDay(val)),
                    )),
                    new IconButton(
                      icon: new Icon(Icons.more_horiz),
                      tooltip: 'Choose time',
                      onPressed: (() {
                        _chooseTime(false, context, _controllerTimeEnd.text);
                      }),
                    )
                  ]),
                  new TextFormField(
                    decoration: new InputDecoration(
                      icon: const Icon(Icons.free_breakfast),
                      hintText: 'Enter the break in minutes',
                      labelText: WorktagLocalizations.of(context).title_break,
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: widget.timeEntry.breakInMinutes.toString(),
                    onSaved: (val) =>
                        widget.timeEntry.breakInMinutes = int.parse(val),
                  ),
                  new InputDecorator(
                    decoration: new InputDecoration(
                      icon: const Icon(Icons.work),
                      labelText: WorktagLocalizations.of(context).title_place,
                    ),
                    isEmpty: _place == '',
                    child: new DropdownButtonHideUnderline(
                      child: new DropdownButton<String>(
                        value: _place,
                        isDense: true,
                        onChanged: (String newValue) {
                          setState(() {
                            _place = newValue;
                          });
                        },
                        items: _places.map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  new Container(
                    padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                    child: new FlatButton(
                      child: new Row(children: <Widget>[
                        const Icon(Icons.save),
                        new Padding(padding: const EdgeInsets.only(left: 5.0)),
                        Text(WorktagLocalizations.of(context).title_submit),
                      ]),
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      onPressed: () {
                        /* ... */
                      },
                    ),
                  ),
                ],
              ))),
    );
  }

  void showMessage(String message, [Color color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save(); //This invokes each onSaved event

      print('Form save called, newContact is now up to date...');
      print('Date: ${widget.timeEntry.date}');
      print('Start: ${widget.timeEntry.start}');
      print('End: ${widget.timeEntry.end}');
      print('Break: ${widget.timeEntry.breakInMinutes}');
      print('========================================');
      print('Submitting to back end...');

      showMessage('Saving Entry...', Theme.of(form.context).accentColor);

      widget.save(form.context);
    }
  }

  bool isValidDate(String value) {
    if (value.isEmpty) return false;
    var d = DateHelper.parseDate(value);
    return d != null;
  }

  bool isValidTime(String value) {
    if (value.isEmpty) return false;
    var d = DateHelper.parseTimeOfDay(value);
    return d != null;
  }
}
