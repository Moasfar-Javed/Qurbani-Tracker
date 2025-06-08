import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qurbani_tracker/app/app.dart';
import 'package:qurbani_tracker/app/app_cubit.dart';
import 'package:qurbani_tracker/constants/constants.dart';
import 'package:qurbani_tracker/firebase_options.dart';
import 'package:qurbani_tracker/utility/utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    EasyLocalization.ensureInitialized(),
    TimezoneUtility.initialize(),
    LocalDatabase.initialize(),
  ]);
  EasyLocalization.logger.enableBuildModes = [];

  runApp(
    BlocProvider(
      create: (providerContext) => AppCubit()..initialize(),
      child: EasyLocalization(
        supportedLocales: Languages.supported,
        path: Languages.pathToFiles,
        fallbackLocale: Languages.fallback,
        child: const App(),
      ),
    ),
  );
}
