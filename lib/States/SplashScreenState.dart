import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import '../helper.dart';
import '../Localization/WorktagLocalizations.dart';
import '../Widgets/SplashScreen.dart';

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    widget.initializeApp(navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Home');
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new ExactAssetImage('assets/icon/icon.png'),
        fit: BoxFit.scaleDown,
      ),
      color: Theme.of(context).primaryColor,
    ));
  }
}
