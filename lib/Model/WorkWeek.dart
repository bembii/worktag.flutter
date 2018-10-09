import '../helper.dart';

class WorkWeek {
  DateTime start;
  DateTime end;
  int week;
  int year;

  static WorkWeek fromDate(DateTime date) {
    DateTime weekStart = WeekHelper.getWeekStart(date);

    WorkWeek week = new WorkWeek();
    week.start = weekStart;
    week.end = weekStart.add(new Duration(days: 7));
    week.week = WeekHelper.getWeekOfYear(weekStart);
    week.year = WeekHelper.getWeekYear(weekStart);
    return week;
  }

  @override
  String toString() {
    return "${this.week}/${this.year}";
  }

}