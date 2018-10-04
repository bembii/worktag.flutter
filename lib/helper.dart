class Helper {
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
}