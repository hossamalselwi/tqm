import 'dart:io';

import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:tqm/utils/local_storage.dart';
import 'package:tqm/utils/network_utils/custom_http_client.dart';
import 'package:tqm/utils/network_utils/endpoints.dart';
import 'package:http_parser/http_parser.dart';
//////////////////////
///

final CustomHttpClient _customHttpClient = CustomHttpClient();
final LocalStorage _localStorage = LocalStorage();

class OrganizationService {
  Future<Response> getOrg({int id}) async {
    return await _customHttpClient.getRequest('${SettingConfig.orgPath}/$id');
  }

  Future<Response> createOrganizationRequest(
      {String imageUrl, String name, List<String> teams}) async {
    Map<String, dynamic> body = {
      "name": name,
      "logo": imageUrl,
      "teams": teams
    };
    print(body);
    return await _customHttpClient.postRequest(
        route: createOrganizationPath, body: body);
  }

  Future<Response> fileUploaderRequest({File file}) async {
    final token = await _localStorage.authToken();
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    final multipartRequest =
        MultipartRequest('POST', Uri.parse(fileUploaderPath));
    String fileName = basename(file.path);
    multipartRequest.headers.addAll(headers);
    multipartRequest.files.add(
      await MultipartFile.fromPath('file', file.path,
          filename: fileName, contentType: MediaType("image", "png")),
    );

    Response response = await Response.fromStream(await multipartRequest.send())
        .timeout(Duration(seconds: 120));

    return response;
  }

  /*Future<Response> getMemberListRequest({String organizationId}) async {
    return await _customHttpClient.getRequest(listMembersPath(organizationId));
  }*/
}
