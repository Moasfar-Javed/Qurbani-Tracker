part of '../repos.dart';

class LocalAuthRepo {
  LocalAuthRepo._privateConstructor();
  static final LocalAuthRepo _instance = LocalAuthRepo._privateConstructor();
  factory LocalAuthRepo() {
    return _instance;
  }
}
