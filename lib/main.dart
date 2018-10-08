import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'helper.dart';
import 'Widgets/TimeList.dart';
import 'Widgets/EditTimeScreen.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    TimeOfDayFormat timeFormat = MaterialLocalizations.of(context).timeOfDayFormat();
    Helper.timeFormat = new DateFormat(timeFormat.toString());

    return MaterialApp(
      title: 'WorkTag',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('de', 'DE'), // German
        // ... other locales the app supports
      ],
      navigatorObservers: <NavigatorObserver>[LogHelper.observer],
      home: HomeScreen(),
    );
  }
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WorkTag'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditTimeScreen(null)),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: TimeList(),
      ),
    );
  }
}
