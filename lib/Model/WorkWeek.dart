import '../helper.dart';

class WorkWeek {
  DateTime start;
  DateTime end;
  int week;
  int year;

  static WorkWeek fromDate(DateTime date) {
    DateTime dateToUse = DateTime.utc(date.year, date.month, date.day);
    DateTime weekStart = WeekHelper.getWeekStart(dateToUse);

    WorkWeek week = new WorkWeek();
    week.start = weekStart;
    week.end = weekStart.add(new Duration(days: 6));
    week.week = WeekHelper.getWeekOfYear(weekStart);
    week.year = WeekHelper.getWeekYear(weekStart);
    return week;
  }

  @override
  String toString() {
    return "${this.week}/${this.year}";
  }

}