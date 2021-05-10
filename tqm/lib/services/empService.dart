import 'package:flutter/material.dart';
import 'package:tqm/models/JobsEmpModel.dart';
import 'package:tqm/models/docsModel.dart';
import 'package:tqm/models/empModel.dart';
import 'package:tqm/utils/local_storage.dart';
import 'dart:async';
import 'dart:convert';

import 'package:tqm/utils/network_utils/custom_http_client.dart';
import 'package:tqm/utils/network_utils/endpoints.dart';

final CustomHttpClient _api = CustomHttpClient();

final LocalStorage _varStorage = LocalStorage();

class EmpService {
  String idOrg = '-1';

  Future<String> _testIdorg() async {
    if (idOrg == '-1') {
      idOrg = await _varStorage.getOrgId();
      return idOrg;
    }
    return idOrg;
  }

  Future<bool> add(EmpModel model) async {
    bool statues = false;
    model.id = '0';
    model.idorg = await _testIdorg();

    try {
      var response = await _api.postRequest(
          route: '${SettingConfig.empPath}', body: EmpModel.toJson(model));

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

  Future<bool> update(EmpModel model) async {
    bool statues = false;
    try {
      var url = "${SettingConfig.empPath}/${model.id}";
      var response =
          await _api.putRequest(route: url, body: EmpModel.toJson(model));

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
      var url = "${SettingConfig.empPath}/$id";
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

  Future<List<EmpModel>> getData() async {
    idOrg = await _testIdorg();

    var url = "${SettingConfig.empPath}/$idOrg";
    var result = await _api.getRequest(url);

    var data = json.decode(result.body) as List;

    dataApi = new List<EmpModel>();
    for (int i = 0; i < data.length; i++) {
      var temp = EmpModel.fromJson(data[i]);
      dataApi.add(temp);
    }
    //await Future<void>.delayed(Duration(seconds: 2));
    return dataApi;
  }

  Future<List<JobsEmpModel>> getJobs(String id) async {
    var data = await _api.getRequest('${SettingConfig.jobempPath}$id') as List;

    var dataJob = new List<JobsEmpModel>();
    for (int i = 0; i < data.length; i++) {
      var temp = JobsEmpModel.fromJson(data[i]);
      dataJob.add(temp);
    }
    return dataJob;
  }

  Future<List<DocsModel>> getDoc(String id) async {
    var data = await _api.getRequest('${SettingConfig.empPath}doc/$id') as List;

    List<DocsModel> temp = new List<DocsModel>();

    for (int i = 0; i < data.length; i++) {
      temp.add(DocsModel.fromJson(data[i]));
    }
    return temp;
  }

  static List<EmpModel> dataApi = new List<EmpModel>();
}

class ProviderEmp extends ChangeNotifier {
  int indexSelect = 0;

  changeindexSelect(int index) {
    this.indexSelect = index;
    notifyListeners();
  }
}
