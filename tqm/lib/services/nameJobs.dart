import 'dart:convert';

import 'package:http/http.dart';
import 'package:tqm/models/jobsModel.dart';

import 'package:tqm/utils/network_utils/custom_http_client.dart';
import 'package:tqm/utils/network_utils/endpoints.dart';

import 'package:tqm/utils/local_storage.dart';

final CustomHttpClient _api = CustomHttpClient();
final LocalStorage _varStorage = LocalStorage();
String idOrg = '-1';

Future<String> _testIdorg() async {
  if (idOrg == '-1') {
    idOrg = await _varStorage.getOrgId();
    return idOrg;
  }
  return idOrg;
}

class JobsNameService {
  static Future<List<JobsModel>> getNameAll() async {
    idOrg = await _testIdorg();
    var url = '${SettingConfig.jobnamePath}/$idOrg';

    List<JobsModel> temp = List<JobsModel>();

    var result = await _api.getRequest(url);

    var responseBody = json.decode(result.body) as List;
    for (int i = 0; i < responseBody.length; i++) {
      var model = JobsModel.fromMap(responseBody[i]);

      temp.add(model);
    }

    return temp;
  }

  Future<bool> add(JobsModel model) async {
    model.id = '0';
    model.idorg = await _testIdorg();

    bool statues = false;
    try {
      var response = await _api.postRequest(
          route: '${SettingConfig.jobnamePath}', body: model.toMap());

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
      var url = "${SettingConfig.jobnamePath}/${model.id}";
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
      var url = "${SettingConfig.jobnamePath}/$id";
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
