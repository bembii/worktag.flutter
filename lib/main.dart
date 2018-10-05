import 'package:flutter/material.dart';
import 'Widgets/TimeList.dart';
import 'Widgets/EditTimeScreen.dart';

void main() {
  runApp(new MaterialApp(
    title: 'WorkTag',
    home: new HomeScreen(),
  ));
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
