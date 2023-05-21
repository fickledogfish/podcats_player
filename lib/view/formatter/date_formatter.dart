class DateFormatter {
  const DateFormatter();

  /// yyyy-MM-dd
  String simplifiedDate(DateTime date) => "${date.year.toString()}-"
      "${date.month.toString().padLeft(2, '0')}-"
      "${date.day.toString().padLeft(2, '0')}";

  /// yyyy-MM-dd HH:mm
  String dateAndTime(DateTime date) => "${date.year.toString()}-"
      "${date.month.toString().padLeft(2, '0')}-"
      "${date.day.toString().padLeft(2, '0')} "
      "${date.hour.toString().padLeft(2, "0")}:"
      "${date.minute.toString().padLeft(2, "0")}";
}
