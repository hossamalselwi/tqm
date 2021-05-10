/*
class JobsModel {
  JobsModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Data> data;

  factory JobsModel.fromMap(Map<String, dynamic> json) => JobsModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
       // data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        // "data": data == null ? null : data.toMap(),
      };
}*/

class JobsModel {
  String id;
  String name;
  String img;

  String idNameJob;

  String idDeptBra;
  String nameDept;

  String idBrch;
  String nameBrch;
  String idorg;
// public int idJob { get; set; }

  JobsModel(
      {this.id,
      this.name,
      this.img,
      this.idDeptBra,
      this.idBrch,
      this.nameBrch,
      this.idNameJob,
      this.nameDept,
      this.idorg});

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "Img": img == null ? null : img,
        "IdOrg": idorg == null ? null : idorg,

        // "data": data == null ? null : data.toMap(),
      };

  Map<String, dynamic> toMapDept() => {
        "Id": id == null ? null : id,
        "IdJob": idNameJob == null ? null : idNameJob,
        "IdDeptBra": idDeptBra == null ? null : idDeptBra,

        // "data": data == null ? null : data.toMap(),
      };

  factory JobsModel.fromMap(Map<String, dynamic> json) {
    String id = json['id'].toString();

    return JobsModel(
      id: id,
      name: json['name'] as String,
      img: json['img'] as String,
    );
  }
}
