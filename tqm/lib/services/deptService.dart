import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tqm/models/Stratige/Brch.dart';
import 'package:tqm/utils/local_storage.dart';
import 'package:tqm/utils/network_utils/custom_http_client.dart';
import '../models/dept.dart';
import '../utils/network_utils/endpoints.dart';

final LocalStorage _varStorage = LocalStorage();
String idOrg = '-1';

Future<String> _testIdorg() async {
  if (idOrg == '-1') {
    idOrg = await _varStorage.getOrgId();
    return idOrg;
  }
  return idOrg;
}

class DeptService {
  CustomHttpClient _apiSer = CustomHttpClient();

  Future<List<Data>> getAll() async {
    idOrg = await _testIdorg();

    var data = List<Data>();
    var url = "${SettingConfig.deptbrchPath}/$idOrg";
    var responseBody = await _apiSer.getRequest(url);
    var list = json.decode(responseBody.body) as List;

    for (int i = 0; i < list.length; i++) {
      var model = Data.fromMap(list[i]);
      data.add(model);
    }

    return data;
  }

  Future<List<Data>> getByBrch(String idBrch) async {
    var data = List<Data>();
    var url = "${SettingConfig.deptbrchPath}/bybrch/$idBrch";
    var responseBody = await _apiSer.getRequest(url);
    var list = json.decode(responseBody.body) as List;

    for (int i = 0; i < list.length; i++) {
      var model = Data.fromMap(list[i]);
      data.add(model);
    }

    return data;
  }

  Future<List<Data>> getMutiDeptByMutiBrch(List<BrchSrtModel> idsBrch) async {
    var data = List<Data>();
    var url = "${SettingConfig.deptbrchPath}/bybrch/${idsBrch[0].id}";
    var responseBody = await _apiSer.getRequest(url);
    var list = json.decode(responseBody.body) as List;

    for (int i = 0; i < list.length; i++) {
      var model = Data.fromMap(list[i]);
      data.add(model);
    }

    return data;
  }

  Future<bool> delete(int id) async {
    bool statues = false;
    try {
      var url = "${SettingConfig.deptbrchPath}/$id";
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

  final CustomHttpClient _api = CustomHttpClient();

  Future<bool> update(Data model) async {
    bool statues = false;
    try {
      var url = "${SettingConfig.deptbrchPath}/${model.id}";
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

  Future<bool> add(Data model) async {
    model.id = 0;
    bool statues = false;
    try {
      var response = await _api.postRequest(
          route: '${SettingConfig.deptbrchPath}', body: model.toMap());

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
