class Util {
  // Convert minutes into hours
  static String getDuration(String value) {
    if (int.parse(value) > 60) {
      final int hour = int.parse(value) ~/ 60;
      final int minutes = int.parse(value) % 60;
      return '${hour.toString().padLeft(2)}h ${minutes.toString().padLeft(2, "0")}m';
    } else {
      return '$value min';
    }
  }
}
