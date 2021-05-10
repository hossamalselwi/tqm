import 'package:http/http.dart';
import 'package:tqm/utils/network_utils/custom_http_client.dart';
import 'package:tqm/utils/network_utils/endpoints.dart';

final CustomHttpClient _customHttpClient = CustomHttpClient();

class TaskService {
  Future<Response> createTaskRequest(
      {String description,
      String dueDate,
      String team,
      bool isReminder,
      String organizationId,
      int createdBy,
      List<int> assignees}) async {
    Map<String, dynamic> body = {
      'description': description,
      'due_date': dueDate,
      'is_reminder': isReminder,
      'assignees': assignees,
      'organizationId': organizationId,
      'created_by': createdBy,
      'team': team
    };
    return await _customHttpClient.postRequest(
        route: createTaskPath, body: body);
  }

  Future<Response> getTaskRequest(int organizationId) async {
    return await _customHttpClient.getRequest(getTaskPath(organizationId));
  }

  Future<Response> getTaskStatisticsRequest(String userId) async {
    return await _customHttpClient.getRequest(getTaskStatisticsPath(userId));
  }
}

///////////////////////
////////////////////////////////
///
///
///
///
///
///
///
