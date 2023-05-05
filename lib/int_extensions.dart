extension IntExtensions on int {
  // turn an int to 00:00 format
  String get toMinuteSeconds {
    int h = this ~/ 3600;
    int m = ((this - h * 3600)) ~/ 60;
    int s = this - (h * 3600) - (m * 60);

    String minute = m.toString().length < 2 ? "0$m" : m.toString();
    String seconds = s.toString().length < 2 ? "0$s" : s.toString();

    return "$minute:$seconds";
  }
}
