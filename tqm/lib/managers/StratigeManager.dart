/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tqm/models/user.dart';
import 'package:tqm/services/task_service.dart';
import 'package:tqm/utils/local_storage.dart';
import '../models/Stratige/Stratige.dart';

class StartigeManager with ChangeNotifier {
  Logger logger = Logger();
  final TaskService _taskService = TaskService();
  final LocalStorage _localStorage = LocalStorage();

  List<Data> _assignees = [];
  List<String> _imagesList = [];
  String _message = '';
  bool _isLoading = false;

  String get message => _message;
  bool get isLoading => _isLoading;
  List<Data> get assignees => _assignees;
  List<String> get imagesList => _imagesList;

  setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  setisLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  setAssignees(List<Data> users) {
    _assignees = users;
    List<String> ee = [];
    users.forEach((element) {
      ee.add(element.picture);
    });
    _imagesList = ee;

    notifyListeners();
  }

  Future<bool> createTask(
      {@required String description,
      @required String team,
      @required String dueDate,
      @required bool shouldSetReminder,
      @required List<int> assignees}) async {
    setisLoading(true);
    bool isSaved = false;
    String userId = await _localStorage.getId();
    String organizationId = await _localStorage.getOrgId();
    await _taskService
        .createTaskRequest(
            team: team,
            dueDate: dueDate,
            createdBy: int.parse(userId),
            assignees: assignees,
            description: description,
            isReminder: shouldSetReminder,
            organizationId: organizationId)
        .then((response) {
      int statusCode = response.statusCode;
      Map<String, dynamic> body = json.decode(response.body);
      setMessage(body['message']);
      setisLoading(false);
      print(body['message']);
      if (statusCode == 201) {
        isSaved = true;
      } else {
        isSaved = false;
      }
    }).catchError((onError) {
      isSaved = false;
      setMessage('$onError');
      setisLoading(false);
    }).timeout(Duration(seconds: 60), onTimeout: () {
      setMessage('Timeout! Check your internet connection.');
      setisLoading(false);
      isSaved = false;
    });
    return isSaved;
  }

  Future<List<StratigeModel>> getSteatiges() async {
    String organizationId = await _localStorage.getOrgId();

    return [
      StratigeModel(
        id: 1,
        countTime: 5,
        name: 'استراتيجة 1',
        type: 'Year',
        qtyTarget: 10,
        unitTarget: 'سلة غدائية',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        startInterval: '1 يناير',
        endtInterval: 'يناير',
      ),
      StratigeModel(
        id: 1,
        countTime: 5,
        name: 'استراتيجة 2',
        type: 'Year',
        qtyTarget: 10,
        unitTarget: 'اداء الموظفين',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        startInterval: '1 يناير',
        endtInterval: 'يناير',
      ),
      StratigeModel(
        id: 1,
        countTime: 5,
        name: 'استراتيجة جديدة',
        type: 'Year',
        qtyTarget: 10,
        unitTarget: ' null',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        startInterval: '1 يناير',
        endtInterval: 'يناير',
      )
    ];

/*
    await _taskService.getTaskRequest(organizationId).then((response) {
      int statusCode = response.statusCode;
      Map<String, dynamic> body = json.decode(response.body);
      setMessage(body['message']);
      logger.d(body['message']);
      setisLoading(false);
      print(body['message']);
      if (statusCode == 200) {
        task = Task.fromMap(body);
      } else {
        task = null;
      }
    }).catchError((onError) {
      task = null;
      logger.d('$onError');
      setMessage('$onError');
      setisLoading(false);
    }).timeout(Duration(seconds: 60), onTimeout: () {
      setMessage('Timeout! Check your internet connection.');
      setisLoading(false);
      task = null;
    });*/
  }

  /*  Future<TaskStatistic> getTaskStatistics() async {
    TaskStatistic taskStatistic= new TaskStatistic().getdata();
    



    String userId = await  _localStorage.getId();
/*
    await _taskService.getTaskStatisticsRequest( userId ).then((response) {
      int statusCode = response.statusCode;
      Map<String, dynamic> body = json.decode(response.body);
      setMessage(body['message']);
      logger.d(body['message']);
      setisLoading(false);
      print(body['message']);
      if (statusCode == 200) {
        taskStatistic = TaskStatistic.fromMap(body);
      } else {
        taskStatistic = null;
      }
    }).catchError((onError) {
      taskStatistic = null;
      logger.d('$onError');
      setMessage('$onError');
      setisLoading(false);
    }).timeout(Duration(seconds: 60), onTimeout: () {
      setMessage('Timeout! Check your internet connection.');
      setisLoading(false);
      taskStatistic = null;
    });*/
    return taskStatistic;
  }*/
}
*/
