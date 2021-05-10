import 'dart:convert';

import 'package:http/http.dart';
import 'package:tqm/models/Stratige/customer.dart';
import 'package:tqm/models/Stratige/domain.dart';
import 'package:tqm/utils/local_storage.dart';
import 'package:tqm/utils/network_utils/custom_http_client.dart';
import 'package:tqm/utils/network_utils/endpoints.dart';

final CustomHttpClient _api = CustomHttpClient();
final LocalStorage _varStorage = LocalStorage();

class CustomerService {
  String idOrg = '-1';

  Future<String> _testIdorg() async {
    if (idOrg == '-1') {
      idOrg = await _varStorage.getOrgId();
      return idOrg;
    }
    return idOrg;
  }

  Future<List<CustomerModel>> getData() async {
    idOrg = await _testIdorg();

    var url = "${SettingConfig.customerPath}/$idOrg";
    var result = await _api.getRequest(url);

    var data = json.decode(result.body) as List;

    var dataApi = new List<CustomerModel>();
    for (int i = 0; i < data.length; i++) {
      var temp = CustomerModel.fromJson(data[i]);
      dataApi.add(temp);
    }
    //await Future<void>.delayed(Duration(seconds: 2));
    return dataApi;
  }

  ////
  ///

  Future<bool> delete(int id) async {
    bool statues = false;
    try {
      var url = "${SettingConfig.customerPath}/$id";
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

  Future<bool> update(CustomerModel model) async {
    bool statues = false;
    try {
      var url = "${SettingConfig.customerPath}/${model.id}";
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

  Future<bool> add(CustomerModel model) async {
    bool statues = false;
    model.id = '0';
    model.idOrg = await _testIdorg();

    try {
      var response = await _api.postRequest(
          route: '${SettingConfig.customerPath}', body: model.toJson(model));

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
}

//////////////////////////
///
///
///
