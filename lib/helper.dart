import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Service/TimeEntryService.dart';
import 'Service/TimeEntryService_MockBin.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';


class LogHelper{
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  static void log(String name, String message){
    analytics.logEvent(
      name: name,
      parameters: <String, dynamic>{
        'message': message,
      });
  }
}

class Helper {
  static final dateFormat = new DateFormat.yMd();
  static final timeFormat = new DateFormat.jm();

  static int getWeek(DateTime date){
    final startOfYear = new DateTime(date.year, 1, 1, 0, 0);
    final firstMonday = startOfYear.weekday;
    final daysInFirstWeek = 8 - firstMonday;
    final diff = date.difference(startOfYear);
    var weeks = ((diff.inDays - daysInFirstWeek) / 7).ceil();
    // It might differ how you want to treat the first week
    if(daysInFirstWeek > 3) {
      weeks += 1;
    }
    return weeks;
  }

  static String getWeekYear(DateTime date){
    int week = getWeek(date);
    int year = date.year;
    return week.toString() + "/" + year.toString();
  }

  static TimeOfDay convertToTimeOfDay(String input) {
    try {
      var d = timeFormat.parseStrict(input);
      return new TimeOfDay.fromDateTime(d);
    } catch (e) {
      return null;
    }
  }

  static String convertTimeToString(DateTime input) {
    if (input == null) return null;
    return timeFormat.format(input);
  }

  static DateTime convertTimeToDate(TimeOfDay input) {
    if (input == null) return null;
    DateTime dt = DateTime.now();
    return new DateTime(dt.year, dt.month, dt.day, input.hour, input.minute);
  }

  static DateTime convertToDate(String input) {
    try {
      var d = dateFormat.parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  static String convertDateToString(DateTime input) {
    if (input == null) return null;
    return dateFormat.format(input);
  }

  static TimeEntryService getService(){
    return new TimeEntryService_MockBin();
  }
}