import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tqm/models/jobsModel.dart';
import 'package:tqm/utils/network_utils/custom_http_client.dart';
import 'package:tqm/utils/network_utils/endpoints.dart';

final CustomHttpClient _api = CustomHttpClient();

class JobDeptService {
  Future<bool> add(JobsModel model) async {
    model.id = '0';
    bool statues = false;
    try {
      var response = await _api.postRequest(
          route: '${SettingConfig.jobdeptPath}', body: model.toMapDept());

      int statusCode = response.statusCode;
      print(statusCode);
      var body = json.decode(response.body);
      // setMessage('${body['message']}');
      if (statusCode == 201 || statusCode == 200) {
        statues = true;
      } else {
        statues = false;
      }
    } catch (onError) {
      //setMessage('$onError');
      statues = false;
    }
    return statues;
  }

  Future<bool> update(JobsModel model) async {
    bool statues = false;
    try {
      var url = "${SettingConfig.jobdeptPath}/${model.id}";
      var response = await _api.putRequest(route: url, body: model.toMap());

      int statusCode = response.statusCode;
      print(statusCode);
      var body = json.decode(response.body);
      // setMessage('${body['message']}');
      if (statusCode == 201 || statusCode == 200) {
        statues = true;
      } else {
        statues = false;
      }
    } catch (onError) {
      //setMessage('$onError');
      statues = false;
    }
    return statues;
  }

  Future<bool> delete(String id) async {
    bool statues = false;
    try {
      var url = "${SettingConfig.jobdeptPath}/$id";
      var response = await _api.deleteRequest(url);

      int statusCode = response.statusCode;
      print(statusCode);
      var body = json.decode(response.body);
      // setMessage('${body['message']}');
      if (statusCode == 201 || statusCode == 200) {
        statues = true;
      } else {
        statues = false;
      }
    } catch (onError) {
      //setMessage('$onError');
      statues = false;
    }
    return statues;
  }

  Future<List<JobsModel>> getAll() async {
    List<JobsModel> data = List<JobsModel>();

    var url = "${SettingConfig.jobdeptPath}";
    var result = await _api.getRequest(url);

    var list = json.decode(result.body) as List;

    for (int i = 0; i < list.length; i++) {
      var temp = JobsModel.fromMap(list[i]);
      data.add(temp);
    }

    return data;
  }

  Future<List<JobsModel>> getbyDept(String idDept) async {
    var data = List<JobsModel>();

    var url = "${SettingConfig.jobdeptByPath}/$idDept";

    var result = await _api.getRequest(url);

    var list = json.decode(result.body) as List;

    for (int i = 0; i < list.length; i++) {
      var temp = JobsModel.fromMap(list[i]);
      data.add(temp);
    }

    return data;
  }
}
