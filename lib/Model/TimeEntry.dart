class TimeEntry {
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
    return "$hours:$minutes";
  }

  @override
  String toString() {
    return start.toIso8601String() + " - " + end.toIso8601String();
  }

}