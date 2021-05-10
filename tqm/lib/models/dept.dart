import 'jobsModel.dart';

class Data {
  int id;

  String idNameDept;
  String name;
  String idBrch;

  String nameBrch;
  String idOrg;

  String fileTask;
  String typeFile;

  List<JobsModel> jobs = List<JobsModel>();

  Data(
      {this.id,
      this.name,
      this.idBrch,
      this.idNameDept,
      this.nameBrch,
      this.idOrg,
      this.jobs,
      this.fileTask,
      this.typeFile});

  Map<String, dynamic> toMapNam() {
    return {"Id": id, "Name": name, 'IdOrg': idOrg};
  }

  Map<String, dynamic> toMap() {
    return {
      "Id": id,

      'FileTask': fileTask.toString(),
      'TypeFile': typeFile.toString(),
      'IdBra': idBrch,
      'IdDept': idNameDept,
      //'IdOrg': idOrg
      //"Name": name,
    };
  }
  //toMapNam

  factory Data.fromMapName(Map<String, dynamic> json) {
    return Data(
      id: json['id'] == null ? null : json['id'] as int,
      name: json['name'] as String,
    );
  }

  factory Data.fromMap(Map<String, dynamic> json) {
    //String id =  json['id'];
    //

    List jobsDept = json["jobs"] == null ? null : json["jobs"] as List;

    List<JobsModel> jobsTemp = List<JobsModel>();

    for (int i = 0; i < jobsDept.length; i++) {
      JobsModel jobsModel = JobsModel.fromMap(jobsDept[i]);
      jobsTemp.add(jobsModel);
    }

    return Data(
      id: json['id'] == null ? null : json['id'] as int,
      name: json['name'] as String,
      idBrch: json['idBrch'] as String,
      nameBrch: json['nameBrch'] as String,
      idNameDept: json['idNameDept'] as String,
      fileTask: json['fileTask'] as String,
      typeFile: json['typeFile'] as String,
      jobs: jobsTemp == null ? null : jobsTemp,
    );
  }
}

class Dept {
  Dept({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Data> data;

  factory Dept.fromMap(Map<String, dynamic> json) => Dept(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],

        // data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        // "data": data == null ? null : data.toMap(),
      };
}
