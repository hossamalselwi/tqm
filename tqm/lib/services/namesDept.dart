import 'dart:convert';

import 'package:http/http.dart';
import 'package:tqm/utils/local_storage.dart';
import 'package:tqm/utils/network_utils/custom_http_client.dart';
import 'package:tqm/utils/network_utils/endpoints.dart';

import '../models/dept.dart';

final CustomHttpClient _api = CustomHttpClient();
final LocalStorage _varStorage = LocalStorage();

class DeptNameService {
  String idOrg = '-1';

  Future<String> _testIdorg() async {
    if (idOrg == '-1') {
      idOrg = await _varStorage.getOrgId();
      return idOrg;
    }
    return idOrg;
  }

  Future<Response> getAll1() async {
    String idOr = await _testIdorg();
    var url = '${SettingConfig.deptnamePath}/$idOr';

    var result = await _api.getRequest(url);
    ;
    return result;
  }
  ////
  ///

  static Future<Response> delete(int id) async {
    var url = "${SettingConfig.deptnamePath}/$id";
    try {
      return await _api.deleteRequest(url);
    } catch (eee) {
      //return eee.toString();
    }
    //return 'error';
  }

  static Future<Response> update(Data model) async {
    var url = "${SettingConfig.deptnamePath}/${model.id}";
    try {
      var result = await _api.putRequest(route: url, body: model.toMapNam());
      return result;
    } catch (eee) {
      print(eee.toString());
    }
    //return 'error';
  }

  Future<Response> add(Data model) async {
    model.idOrg = await _testIdorg();

    var result = await _api.postRequest(
        route: '${SettingConfig.deptnamePath}', body: model.toMapNam());
    return result;
  }
}

//////////////////////////
///
///
///
