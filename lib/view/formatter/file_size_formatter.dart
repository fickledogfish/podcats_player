import 'dart:math';

class FileSizeFormatter {
  const FileSizeFormatter();

  String fromBytes(int bytes) {
    final magnitude = (log(bytes) / ln10).round() % 3;
    final scaledBytes = (bytes / pow(1000, magnitude)).round();

    return "$scaledBytes ${_magnitude(magnitude)}";
  }

  String _magnitude(int magnitude) {
    switch (magnitude) {
      case 0:
        return "B";

      case 1:
        return "KB";

      case 2:
        return "MB";

      case 3:
        return "GB";

      default:
        return "??";
    }
  }
}
