import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Service/TimeEntryService.dart';
import 'Service/TimeEntryService_MockBin.dart';
import 'Service/TimeEntryService_CloudFirestore.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class LogHelper {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  static void log(String name, String message) {
    analytics.logEvent(name: name, parameters: <String, dynamic>{
      'message': message,
    });
  }
}

class WeekHelper {
  static final firstDayOfWeek = new DateFormat().dateSymbols.FIRSTDAYOFWEEK;
  static final _minusOneDay = new Duration(days: -1);

  static DateTime getWeekStart(DateTime date) {
    int firstDay =
        firstDayOfWeek == null || firstDayOfWeek == 0 ? 1 : firstDayOfWeek;
    DateTime weekStart = date;
    while (weekStart.weekday != firstDay) {
      weekStart = weekStart.add(_minusOneDay);
    }
    return weekStart;
  }

  static int getWeekOfYear(DateTime date) {
    final weekYearStartDate = _getWeekYearStartDateForDate(date);
    final dayDiff = date.difference(weekYearStartDate).inDays;
    return ((dayDiff + 1) / 7).ceil();
  }

  static DateTime _getWeekYearStartDateForDate(DateTime date) {
    int weekYear = getWeekYear(date);
    return _getWeekYearStartDate(weekYear);
  }

  static int getWeekYear(DateTime date) {
    //assert(date.isUtc);

    final weekYearStartDate = _getWeekYearStartDate(date.year);

    // in previous week year?
    if (weekYearStartDate.isAfter(date)) {
      return date.year - 1;
    }

    // in next week year?
    final nextWeekYearStartDate = _getWeekYearStartDate(date.year + 1);
    if (nextWeekYearStartDate.isBefore(date) ||
        DateHelper.equalsDate(nextWeekYearStartDate, date)) {
      return date.year + 1;
    }

    return date.year;
  }

  static DateTime _getWeekYearStartDate(int year) {
    final firstDayOfYear = DateTime.utc(year, 1, 1);
    final dayOfWeek = firstDayOfYear.weekday;
    if (dayOfWeek <= DateTime.thursday) {
      return firstDayOfYear.add(new Duration(days: 1 - dayOfWeek));
    } else {
      return firstDayOfYear.add(new Duration(days: 8 - dayOfWeek));
    }
  }
}

class DateHelper {
  static final dateFormat = new DateFormat.yMd();
  static DateFormat timeFormat = new DateFormat.Hm();

  static bool equalsDate(DateTime a, DateTime b) {
    if (a.year != b.year) return false;
    if (a.month != b.month) return false;
    if (a.day != b.day) return false;
    return true;
  }

  static TimeOfDay parseTimeOfDay(String input) {
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

  static DateTime parseDate(String input) {
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
}

class Helper {
  static String getWeekYearString(DateTime date) {
    int week = WeekHelper.getWeekOfYear(date);
    int year = WeekHelper.getWeekYear(date);
    return week.toString() + "/" + year.toString();
  }

  static TimeEntryService _service;

  static TimeEntryService getService() {
    if (_service == null) {
      _service = new TimeEntryService_CloudFirestore();
    }
    return _service;
  }
}
