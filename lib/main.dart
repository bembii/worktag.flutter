import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Localization/WorktagLocalizations.dart';

import 'helper.dart';
import 'Model/Settings.dart';
import 'Widgets/TimeList.dart';
import 'Widgets/EditTimeScreen.dart';
import 'Widgets/SettingsScreen.dart';
import 'Widgets/SplashScreen.dart';

void main() {
  Settings.loadInstance();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkTag',
      theme: ThemeData(
        primaryColor: new Color.fromARGB(255, 255, 235, 51),
        primaryColorLight: new Color.fromARGB(255, 255, 242, 128),
        primaryColorDark: new Color.fromARGB(255, 230, 207, 0),
        accentColor: new Color.fromARGB(255, 0, 107, 94),
        //cardColor: new Color.fromARGB(255, 242, 254, 220),
      ),
      localizationsDelegates: [
        const WorktagLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('de', ''), // German
        // ... other locales the app supports
      ],
      navigatorObservers: <NavigatorObserver>[LogHelper.observer],
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => new HomeScreen(),
        'Settings': (BuildContext context) => new SettingsScreen(),
        'AddTime': (BuildContext context) => new EditTimeScreen(null),
      },
      home: new SplashScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WorkTag'),
        backgroundColor: Theme.of(context).primaryColor,
        primary: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('AddTime');
            },
          ),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: const Text(
                'test@test.de',
                style: const TextStyle(color: Colors.white),
              ),
              accountName: const Text(
                'test',
                style: const TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                image: new DecorationImage(
                  image: new ExactAssetImage('assets/images/bg_time.jpg'),
                  fit: BoxFit.fill,
                ),
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('AddTime');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('Settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Info'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LicensePage(
                            applicationName: 'WorkTag',
                            applicationVersion: '1.0.0',
                            applicationLegalese:
                                'Developed by Tobias Vogelbruch',
                          )),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: TimeList(),
      ),
    );
  }
}
