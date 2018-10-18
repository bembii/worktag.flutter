import 'package:flutter/material.dart';
import '../Model/Settings.dart';
import '../States/SettingsScreenState.dart';
import '../helper.dart';

class SettingsScreen extends StatefulWidget {

  @override
  SettingsScreenState createState() {
    LogHelper.analytics.setCurrentScreen(screenName: "SettingsScreen");
    return new SettingsScreenState();
  }

  void save(BuildContext context) {
    var service = Helper.getService();

  }
}
