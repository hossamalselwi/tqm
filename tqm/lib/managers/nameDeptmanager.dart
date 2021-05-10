import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:tqm/models/dept.dart';
import 'package:tqm/services/namesDept.dart';

class NameDeptManager with ChangeNotifier {
  Logger logger = Logger();

  String _message = '';
  bool _isLoading = false;

  String get message => _message;
  bool get isLoading => _isLoading;

  setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  setisLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  DeptNameService _deptNameService = DeptNameService();

  Future<bool> createNameDept({Data model}) async {
    bool isCreated = false;
    try {
      var response = await _deptNameService.add(model);

      int statusCode = response.statusCode;
      print(statusCode);
      var body = json.decode(response.body);
      // setMessage('${body['message']}');
      if (statusCode == 201 || statusCode == 200) {
        isCreated = true;
      } else {
        isCreated = false;
      }
    } catch (onError) {
      setMessage('$onError');
      isCreated = false;
    }
    return isCreated;
  }

  Future<String> deleteName(int id) async {
    try {
      var response = await DeptNameService.delete(id);

      int statusCode = response.statusCode;
      var body = json.decode(response.body);
      // setMessage(body['message']);
      // logger.d(body['message']);
      setisLoading(false);
      // print(body['message']);
      if (statusCode == 200) {
        return "Succ";
        // task = Task.fromMap(body);
      } else {
        return "fa";
        // task = null;
      }
    } catch (onError) {
      logger.d('$onError');
      setMessage('$onError');
      setisLoading(false);
    }
    /*timeout(Duration(seconds: 60), onTimeout: () {
      setMessage('Timeout! Check your internet connection.');
      setisLoading(false);
      // task = null;
    });*/
    return 'fa';
  }

  Future<bool> updateName(Data model) async {
    try {
      var response = await DeptNameService.update(model);
      int statusCode = response.statusCode;
      //Map<String, dynamic> body = json.decode(response.body);
      //setMessage(body['message']);
      //logger.d(body['message']);
      setisLoading(false);
      //print(body['message']);
      if (statusCode == 200) {
        return true;
        // task = Task.fromMap(body);
      } else {
        return false;
        // task = null;
      }
    } catch (onError) {
      logger.d('$onError');
      setMessage('$onError');
      setisLoading(false);
    }

    return false;
  }

  Future<Dept> getA() async {
    Dept temp = new Dept(data: [], message: '', status: true);

    try {
      setisLoading(true);
      var response = await _deptNameService.getAll1();

      int statusCode = response.statusCode;
      print(statusCode);
      print(response.body);
      var responseBody = json.decode(response.body) as List;
      setisLoading(false);
      // setMessage('${body['message']}');

      for (int i = 0; i < responseBody.length; i++) {
        var model = Data.fromMapName(responseBody[i]);

        temp.data.add(model);
      }

      return temp;
    } catch (onError) {
      setMessage('$onError');
    }
    ;
  }
}
