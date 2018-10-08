import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import '../Service/TimeEntryService.dart';
import '../helper.dart';
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
    _controllerDate = new TextEditingController(text: Helper.convertDateToString(widget.timeEntry.date));
    _controllerTimeStart = new TextEditingController(text: Helper.convertTimeToString(widget.timeEntry.start));
    _controllerTimeEnd = new TextEditingController(text: Helper.convertTimeToString(widget.timeEntry.end));
  }

  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var firstDate = now.add(new Duration(days: -100));
    var lastDate = now.add(new Duration(days: 100));
    var initialDate = Helper.convertToDate(initialDateString) ?? now;
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
    var initialTime = Helper.convertToDate(initialTimeString) ?? now;

    var result =
        await showTimePicker(context: context, initialTime: initialTime);

    if (result == null) return;

    DateTime dt = Helper.convertTimeToDate(result);

    setState(() {
      if (start)
        _controllerTimeStart.text = Helper.convertTimeToString(dt);
      else
        _controllerTimeEnd.text = Helper.convertTimeToString(dt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Edit Entry"),
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
                        labelText: 'Date',
                      ),
                      controller: _controllerDate,
                      keyboardType: TextInputType.datetime,
                      validator: (val) =>
                          isValidDate(val) ? null : 'Not a valid date',
                      onSaved: (val) =>
                          widget.timeEntry.date = Helper.convertToDate(val),
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
                        labelText: 'Start',
                      ),
                      controller: _controllerTimeStart,
                      keyboardType: TextInputType.datetime,
                      validator: (val) =>
                          isValidTime(val) ? null : 'Not a valid time',
                      onSaved: (val) => widget.timeEntry.start =
                          Helper.convertTimeToDate(
                              Helper.convertToTimeOfDay(val)),
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
                        labelText: 'End',
                      ),
                      controller: _controllerTimeEnd,
                      keyboardType: TextInputType.datetime,
                      validator: (val) =>
                          isValidTime(val) ? null : 'Not a valid time',
                      onSaved: (val) => widget.timeEntry.start =
                          Helper.convertTimeToDate(
                              Helper.convertToTimeOfDay(val)),
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
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.free_breakfast),
                      hintText: 'Enter the break in minutes',
                      labelText: 'Break',
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: widget.timeEntry.breakInMinutes.toString(),
                    onSaved: (val) => widget.timeEntry.breakInMinutes = int.parse(val),
                  ),
                  new InputDecorator(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.work),
                      labelText: 'Place',
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
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: _submitForm,
                      )),
                ],
              ))),
    );
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
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
      var service = Helper.getService();
      service.createTimeEntry(widget.timeEntry)
          .then((value) =>
          showMessage('New Entry created for ${widget.timeEntry.date.toIso8601String()}!', Colors.blue)
      );
    }
  }

  bool isValidDate(String value) {
    if (value.isEmpty) return false;
    var d = Helper.convertToDate(value);
    return d != null;
  }

  bool isValidTime(String value) {
    if (value.isEmpty) return false;
    var d = Helper.convertToTimeOfDay(value);
    return d != null;
  }
}
