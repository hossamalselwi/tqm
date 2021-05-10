import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'endpoints.dart';
////////////////////////////

/////////////////
///
///
///

class CustomHttpClient {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  CustomHttpClient._privateConstructor();

  static final CustomHttpClient _instance =
      CustomHttpClient._privateConstructor();

  factory CustomHttpClient() {
    return _instance;
  }

  Future<Response> getRequest(String route) async {
    User user = firebaseAuth.currentUser;
    String token = await user.getIdToken();
    var path = "${SettingConfig.SERVER_URL}$route";

    var result = await get(path, headers: {"Content-Type": "application/json"});

    /* Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      //"Authorization": "Bearer $token"
    };*/

    return result;
    //await get(route, headers: headers);
  }

  Future<Response> postRequest(
      {@required String route, @required Map body}) async {
    User user = firebaseAuth.currentUser;
    var path = "${SettingConfig.SERVER_URL}$route";

    String token = await user.getIdToken();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    debugPrint(path);
    debugPrint(jsonEncode(body));

    Response response =
        await post(path, body: jsonEncode(body), headers: headers);
    return response;
  }

  Future<Response> postStringRequest(
      {@required String route, @required String body}) async {
    User user = firebaseAuth.currentUser;
    var path = "${SettingConfig.SERVER_URL}$route";

    String token = await user.getIdToken();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    Response response =
        await post(path, body: jsonEncode(body), headers: headers);
    return response;
  }

  Future<Response> putRequest(
      {@required String route, @required Map body}) async {
    var path = "${SettingConfig.SERVER_URL}$route";

    User user = firebaseAuth.currentUser;
    //String token = await user.getIdToken();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      //"Authorization": "Bearer $token"
    };

    Response response =
        await put(path, body: jsonEncode(body), headers: headers);
    debugPrint(response.body);
    return response;
  }

  Future<Response> patchRequest(
      {@required String route, @required Map body}) async {
    User user = firebaseAuth.currentUser;
    var url = "${SettingConfig.SERVER_URL}$route";

    String token = await user.getIdToken();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    Response response =
        await patch(url, body: jsonEncode(body), headers: headers);
    return response;
  }

  Future<Response> deleteRequest(String route) async {
    User user = firebaseAuth.currentUser;
    String token = await user.getIdToken();
    var url = "${SettingConfig.SERVER_URL}$route";

    Map<String, String> headers = {
      // "Accept": "application/json",
      "Content-Type": "application/json",
      //"Authorization": "Bearer $token"
    };

    Response response = await delete(url, headers: headers);
    return response;
  }
}
