part of 'utility.dart';

class TimezoneUtility {
  static Future<void> initialize() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();

    final tz.Location location = tz.getLocation(timeZoneName);

    tz.setLocalLocation(location);
  }

  static DateTime toLocalTime(DateTime utcDateTime) {
    final tz.TZDateTime utcTZDateTime = tz.TZDateTime.utc(
      utcDateTime.year,
      utcDateTime.month,
      utcDateTime.day,
      utcDateTime.hour,
      utcDateTime.minute,
      utcDateTime.second,
      utcDateTime.millisecond,
      utcDateTime.microsecond,
    );
    final tz.TZDateTime localDateTime = utcTZDateTime.toLocal();
    return localDateTime;
  }
}
