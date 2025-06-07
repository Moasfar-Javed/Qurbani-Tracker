part of 'utility.dart';

class FormattingUtility {
  // // returns duration as hh:mm:ss
  // static String toTimerDuration(int seconds) {
  //   final int hours = seconds ~/ 3600;
  //   final int minutes = (seconds % 3600) ~/ 60;
  //   final int secs = seconds % 60;

  //   if (hours > 0) {
  //     return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  //   } else if (minutes > 0) {
  //     return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  //   } else {
  //     return '00:${secs.toString().padLeft(2, '0')}';
  //   }
  // }

  // static String toLocalFormattedDateTime(
  //   BuildContext context,
  //   DateTime dateTime,
  // ) {
  //   DateFormat dateFormat = DateFormat(
  //     "MMM dd, yyyy hh:mm a",
  //     context.read<AppBloc>().state.locale,
  //   );

  //   return dateFormat.format(TimezoneUtility.toLocalTime(dateTime));
  // }

  // static String toLocalFormattedDate(BuildContext context, DateTime dateTime) {
  //   DateFormat dateFormat = DateFormat(
  //     "dd MMM, yyyy",
  //     context.read<AppBloc>().state.locale,
  //   );

  //   return dateFormat.format(TimezoneUtility.toLocalTime(dateTime));
  // }

  // static String toFormattedDate(BuildContext context, DateTime dateTime) {
  //   DateFormat dateFormat = DateFormat(
  //     "dd MMM, yyyy",
  //     context.read<AppBloc>().state.locale,
  //   );

  //   return dateFormat.format(dateTime);
  // }

  // static String toLocalFormattedTime(BuildContext context, DateTime dateTime) {
  //   DateFormat timeFormat = DateFormat(
  //     "hh:mm a",
  //     context.read<AppBloc>().state.locale,
  //   );

  //   return timeFormat.format(TimezoneUtility.toLocalTime(dateTime));
  // }

  // /// Converts a [DateTime] object to a human-readable "time ago" string.
  // /// Example: `2 minutes ago`, `1 hour ago`, `3 weeks ago`, `1 month ago`, `2 years ago`
  // static String toLocaleTimeAgo(DateTime dateTime) {
  //   final Duration difference = DateTime.now().difference(
  //     TimezoneUtility.toLocalTime(dateTime),
  //   );

  //   if (difference.inSeconds < 60) {
  //     return difference.inSeconds == 1 ? tr("justNow") : tr("fewSecondsAgo");
  //   } else if (difference.inMinutes < 60) {
  //     return difference.inMinutes == 1
  //         ? tr("oneMinuteAgo")
  //         : tr(
  //             "minutesAgo",
  //             namedArgs: {"time": difference.inMinutes.toString()},
  //           );
  //   } else if (difference.inHours < 24) {
  //     return difference.inHours == 1
  //         ? tr("oneHourAgo")
  //         : tr("hoursAgo", namedArgs: {"time": difference.inHours.toString()});
  //   } else if (difference.inDays < 7) {
  //     return difference.inDays == 1
  //         ? tr("oneDayAgo")
  //         : tr("daysAgo", namedArgs: {"time": difference.inDays.toString()});
  //   } else if (difference.inDays < 30) {
  //     final weeks = (difference.inDays / 7).floor();
  //     return weeks == 1
  //         ? tr("oneWeekAgo")
  //         : tr("weeksAgo", namedArgs: {"time": weeks.toString()});
  //   } else if (difference.inDays < 365) {
  //     final months = (difference.inDays / 30).floor();
  //     return months == 1
  //         ? tr("oneMonthAgo")
  //         : tr("monthsAgo", namedArgs: {"time": months.toString()});
  //   } else {
  //     final years = (difference.inDays / 365).floor();
  //     return years == 1
  //         ? tr("oneYearAgo")
  //         : tr("yearsAgo", namedArgs: {"time": years.toString()});
  //   }
  // }

  // static String getStringFromList(List<dynamic> list) {
  //   return list.join(', ');
  // }
}
