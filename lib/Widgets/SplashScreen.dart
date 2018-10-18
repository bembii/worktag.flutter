import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../Model/Settings.dart';
import '../States/SplashScreenState.dart';
import '../helper.dart';

class SplashScreen extends StatefulWidget {

  @override
  SplashScreenState createState() {
    LogHelper.analytics.setCurrentScreen(screenName: "SplashScreen");
    return new SplashScreenState();
  }

  Future initializeApp(Function callback) async{
    initializeDateFormatting();
    await Settings.loadInstance();

    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, callback);
  }
}
