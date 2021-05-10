class DomainModel {
  String id;
  String name;
  String idOrg;
  String code;
  String img;

  DomainModel({this.id, this.name, this.code, this.img
      //this.idOrg
      });

  factory DomainModel.fromJson(Map<String, dynamic> json) {
    String id = json['id'].toString();

    return DomainModel(
      id: id,
      name: json['name'] as String,
      code: json['code'] as String,
      img: json['img'] as String,
    );
  }

  dynamic toJson(DomainModel model) {
    var body = {
      "Id": id,
      "Name": model.name,
      "Code": model.code,
      "Img": img,
      'IdOrg': model.idOrg
    };

    return body;
  }
}
