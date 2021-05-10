import 'ExecuteDept.dart';

class BrchSrtModel {
  String id;
  int idStr;
  int idBrch;

  String name;
  String image;

  BrchSrtModel({
    this.id,
    this.name,
    this.image,
  });

  factory BrchSrtModel.fromJson(Map<String, dynamic> json) {
    String id = json['id'].toString();

    return BrchSrtModel(
      id: id,
      name: json['name'] as String,
      image: json['logo'] as String,
    );
  }

  dynamic toJson(BrchSrtModel model) {
    var body = {
      'Id': model.id,
      'IdBrch': model.idBrch,
      'IdStr': 0,
    };

    return body;
  }
}
