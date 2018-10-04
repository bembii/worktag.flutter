import 'package:flutter/material.dart';
import 'helper.dart';
import 'Widgets/TimeList.dart';

void main() => runApp(MyApp());
final helper = new Helper();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkTag',
      home: Scaffold(
        appBar: AppBar(
          title: Text('WorkTag'),
        ),
        body: Center(
          child: TimeList(),
        ),
      ),
    );
  }
}