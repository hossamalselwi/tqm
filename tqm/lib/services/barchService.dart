import 'package:http/http.dart' as http;
import 'package:tqm/utils/local_storage.dart';
import 'package:tqm/utils/network_utils/endpoints.dart';

import '../models/barch.dart';
import '../utils/network_utils/custom_http_client.dart';
import 'dart:convert';

class BrchSerivce {
  static List<Barch> dataApi = new List<Barch>();

  CustomHttpClient _api = CustomHttpClient();

  final LocalStorage _varStorage = LocalStorage();
  String idOrg = '-1';

  Future<String> _testIdorg() async {
    if (idOrg == '-1') {
      idOrg = await _varStorage.getOrgId();
      return idOrg;
    }
    return idOrg;
  }

  Future<bool> add(Barch model) async {
    bool isCreated = false;
    model.id = '0';
    model.idorg = await _testIdorg();

    try {
      var response = await _api.postRequest(
          route: '${SettingConfig.brchPath}', body: model.toJson(model));

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
      //setMessage('$onError');
      isCreated = false;
    }
    return isCreated;
  }

  Future<bool> delete(String id) async {
    bool statues = false;
    try {
      var url = "${SettingConfig.brchPath}/$id";
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
  ///////////////////
  ///
  ///
  ///////////////////
  ///
  ///
  ///

  Future<List<Barch>> getAll() async {
    idOrg = await _testIdorg();

    List<Barch> data = new List<Barch>();
    var url = "${SettingConfig.brchPath}/$idOrg";
    var responseBody = await _api.getRequest(url);
    var list = json.decode(responseBody.body) as List;

    for (int i = 0; i < list.length; i++) {
      var model = Barch.fromJson(list[i]);
      /*model.dos = [
       new DocsModel(
            id: '49',
            name: '',
            path:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/OOjs_UI_icon_add.svg/1024px-OOjs_UI_icon_add.svg.png')
      ];*/
      data.add(model);
    }

    dataApi.addAll(data);
    return data;
  }

  Future<bool> update(Barch model) async {
    bool statues = false;
    try {
      var url = "${SettingConfig.brchPath}/${model.id}";
      var response =
          await _api.putRequest(route: url, body: model.toJson(model));

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
////////////////////////
///
///
///

///////////////////////
///
///
///
///
///
///
///
///////////////////////
///
