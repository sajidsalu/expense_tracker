import 'package:flutter/material.dart';

class DataManager {
  DataManager._();
  static DataManager? _dataManager;
  static DataManager get instance {
    _dataManager ??= DataManager._();
    return _dataManager!;
  }

  String _username ='';
  String get username => _username;

  void setUsername({required String username}){
    _username = username;
  }
}