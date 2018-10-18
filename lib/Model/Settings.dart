import 'dart:async';

import '../helper.dart';

class Settings {
  static Settings instance;

  static Future<Settings> loadInstance() async {
    if (instance == null) {
      instance = await Helper.getService().loadSettings();
      if (instance == null) {
        instance = new Settings();
      }
      if (instance.defaultWorktimePerDay == null) {
        instance.defaultWorktimePerDay = 480;
      }
      if (instance.defaultWorkdaysPerWeek == null) {
        instance.defaultWorkdaysPerWeek = 5;
      }
    }
    return instance;
  }

  int defaultWorktimePerDay;
  int defaultWorkdaysPerWeek;
  int get defaultWorktimePerWeek => defaultWorktimePerDay * defaultWorkdaysPerWeek;
}
