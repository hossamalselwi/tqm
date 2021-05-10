class EnviromentModel {
  String id;
  String name;
  String idOrg;

  String img;

  EnviromentModel({this.id, this.name, this.img, this.idOrg});

  factory EnviromentModel.fromJson(Map<String, dynamic> json) {
    String id = json['id'].toString();

    return EnviromentModel(
      id: id,
      name: json['name'] as String,
      img: json['img'] as String,
    );
  }

  dynamic toJson(EnviromentModel model) {
    var body = {"Id": id, "Name": model.name, "Img": img, 'IdOrg': model.idOrg};

    return body;
  }
}
