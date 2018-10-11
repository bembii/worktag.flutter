class TimeEntry {
  String ID;
  DateTime date;
  DateTime start;
  DateTime end;
  int breakInMinutes;

  int getWorktimeInMinutes() {
    Duration duration = this.end.difference(this.start);
    int minutes = duration.inMinutes;
    if (breakInMinutes != null)
      minutes -= breakInMinutes;
    return minutes;
  }

  String getWorktime() {
    int totalMinutes = this.getWorktimeInMinutes();
    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    String minutesString;
    if (minutes < 10)
      minutesString = '0$minutes';
    else
      minutesString = '$minutes';

    return '$hours:$minutesString';
  }

  @override
  String toString() {
    return '$start - $end';
  }

}