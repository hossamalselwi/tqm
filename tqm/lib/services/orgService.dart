import 'dart:convert';

import 'package:tqm/models/orgModel.dart';
import 'package:tqm/utils/local_storage.dart';
import 'package:tqm/utils/network_utils/custom_http_client.dart';
import 'package:tqm/utils/network_utils/endpoints.dart';

final CustomHttpClient _api = CustomHttpClient();
final LocalStorage _varStorage = LocalStorage();

class OrgService {
  Future<OrgModel> getOrg() async {
    String id = await _varStorage.getOrgId();

    var url = '${SettingConfig.orgPath}/$id';

    List<OrgModel> data = List<OrgModel>();

    var result = await _api.getRequest(url);
    ;
    var responseBody = json.decode(result.body) as List;

    for (int i = 0; i < responseBody.length; i++) {
      var model = OrgModel.fromJson(responseBody[i]);

      data.add(model);
    }

    return data[0];
  }

  Future<bool> update(OrgModel model) async {
    bool statues = false;
    try {
      var url = "${SettingConfig.orgPath}/${model.id}";
      var response = await _api.putRequest(route: url, body: model.toJson());

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
