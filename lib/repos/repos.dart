import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qurbani_tracker/constants/constants.dart';
import 'package:qurbani_tracker/models/models.dart';
import 'package:qurbani_tracker/utility/utility.dart';
import 'package:sqflite/sql.dart';

part 'settings/local_settings_repo.dart';
part 'settings/remote_settings_repo.dart';
part 'settings/settings_repo.dart';

part 'auth/local_auth_repo.dart';
part 'auth/remote_auth_repo.dart';
part 'auth/auth_repo.dart';
