import 'package:flutter/material.dart';

import 'helper.dart';
import 'Widgets/TimeList.dart';
import 'Widgets/EditTimeScreen.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkTag',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
              LogHelper.log('Test', 'Navigate to EditScreen');
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
