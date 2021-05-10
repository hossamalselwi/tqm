import 'dart:convert';

import 'package:tqm/models/JobsEmpModel.dart';
import 'package:tqm/utils/network_utils/custom_http_client.dart';
import 'package:tqm/utils/network_utils/endpoints.dart';

final CustomHttpClient _api = CustomHttpClient();

class JobEmpService {
  Future<bool> add(JobsEmpModel model) async {
    model.id = 0;
    bool statues = false;
    try {
      var response = await _api.postRequest(
          route: '${SettingConfig.jobempPath}', body: model.toMap());

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

  Future<bool> update(JobsEmpModel model) async {
    bool statues = false;
    try {
      var url = "${SettingConfig.jobempPath}/${model.id}";
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
      var url = "${SettingConfig.jobempPath}/$id";
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
}
