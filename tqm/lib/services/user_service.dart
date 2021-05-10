
import 'package:http/http.dart';
import 'package:tqm/utils/network_utils/custom_http_client.dart';
import 'package:tqm/utils/network_utils/endpoints.dart';

final CustomHttpClient _customHttpClient = CustomHttpClient();

class UserService {
  Future<Response> updateUserTeamRequest({String team}) async {
    return await _customHttpClient.putRequest(
        route: updateTeamPath, body: {'team': team});
  }

  Future<Response> getUserInformationRequest() async {
    return await _customHttpClient.getRequest(getUserInformationPath);
  }

  Future<Response> inviteMembersRequest({List<String> emails}) async {
    return await _customHttpClient
        .postRequest(route: inviteMembersPath, body: {'emails': emails});
  }

  Future<Response> sendNotificationTokenRequest({String token}) async {
    return await _customHttpClient
        .putRequest(route: updateTokenPath, body: {'fcm_token': token});
  }
}
