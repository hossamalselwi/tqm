class UnitsModel {
  int id;
  String name;
  String idOrg;

  UnitsModel({this.id, this.name, this.idOrg});

  factory UnitsModel.fromJson(Map<String, dynamic> json) {
    return UnitsModel(
      id: json['id'],
      name: json['name'] as String,
    );
  }

  dynamic toJson(UnitsModel model) {
    var body = {"Id": id, "Name": model.name, 'IdOrg': model.idOrg};

    return body;
  }
}
