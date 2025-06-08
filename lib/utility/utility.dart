import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:qurbani_tracker/constants/constants.dart';
import 'package:qurbani_tracker/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:uuid/uuid.dart';

part 'timezone_utility.dart';
part 'haptics_util.dart';
part 'validation_utility.dart';
part 'formatting_utility.dart';
part 'event_notifier_utility.dart';
part 'extensions.dart';
part 'debouncer.dart';
part 'local_database.dart';
part 'connectivity_listener.dart';
part 'exceptions.dart';

class Utils {
  static bool isCupertino(BuildContext context) {
    final platform = Theme.of(context).platform;
    return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
  }

  static void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static DateTime? nullOrDateTime(String? value) {
    return value == null ? null : DateTime.parse(value);
  }

  static T? nullOrEnum<T>(int? value, T Function(int) fromValue) {
    return value == null ? null : fromValue(value);
  }

  static String genTimeStampString() {
    final now = DateTime.now().toUtc();
    final utcDate = now.toIso8601String();
    final numberOnly = utcDate.replaceAll(RegExp(r'[^0-9]'), "");
    return numberOnly;
  }

  static bool hasSmallHeight(Size screenSize) {
    return (screenSize.height < 500);
  }

  static String genUuid() {
    return Uuid().v4();
  }
}
