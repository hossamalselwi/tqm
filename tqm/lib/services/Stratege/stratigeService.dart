import 'package:tqm/models/Stratige/Stratige.dart';
import 'package:tqm/utils/local_storage.dart';
import 'dart:async';
import 'dart:convert';

import 'package:tqm/utils/network_utils/custom_http_client.dart';
import 'package:tqm/utils/network_utils/endpoints.dart';

final CustomHttpClient _api = CustomHttpClient();

final LocalStorage _varStorage = LocalStorage();

class StratigeService {
  String idOrg = '-1';

  Future<String> _testIdorg() async {
    if (idOrg == '-1') {
      idOrg = await _varStorage.getOrgId();
      return idOrg;
    }
    return idOrg;
  }

  Future<bool> add(StratigeModel model) async {
    bool statues = false;
    model.id = 0;
    model.idOrg = await _testIdorg();

    try {
      var response = await _api.postRequest(
          route: '${SettingConfig.stratigePath}', body: model.toJson(model));

      int statusCode = response.statusCode;
      print(statusCode);
      var body = json.decode(response.body);

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

  Future<bool> update(StratigeModel model) async {
    bool statues = false;
    try {
      var url = "${SettingConfig.stratigePath}/${model.id}";
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

  Future<List<StratigeModel>> getData() async {
    idOrg = await _testIdorg();

    var url = "${SettingConfig.stratigePath}/$idOrg";
    var result = await _api.getRequest(url);

    var data = json.decode(result.body) as List;

    dataApi = new List<StratigeModel>();
    for (int i = 0; i < data.length; i++) {
      var temp = StratigeModel.fromJson(data[i]);
      dataApi.add(temp);
    }
    //await Future<void>.delayed(Duration(seconds: 2));
    return dataApi;
  }

  static List<StratigeModel> dataApi = new List<StratigeModel>();
}
