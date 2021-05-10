import 'Overload.dart';

class ExecuteDeptModel {
  int id;
  double idPointer;
  int idDeptName;
  List<OverloadModel> overload = List<OverloadModel>();

  String nameDept;

  ExecuteDeptModel({this.id, this.idPointer, this.idDeptName, this.nameDept});

  factory ExecuteDeptModel.fromJson(Map<String, dynamic> json) {
    return ExecuteDeptModel(
      id: json['id'],
    );
  }

  static dynamic toJson(ExecuteDeptModel model) {
    var body = {
      //'Content-Type': 'application/json'
    };

    return body;
  }
}
