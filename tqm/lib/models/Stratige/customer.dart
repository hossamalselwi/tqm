class CustomerModel {
  String id;
  String name;
  String idOrg;

  String img;

  CustomerModel({this.id, this.name, this.img, this.idOrg});

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    String id = json['id'].toString();

    return CustomerModel(
      id: id,
      name: json['name'] as String,
      img: json['img'] as String,
    );
  }

  dynamic toJson(CustomerModel model) {
    var body = {"Id": id, "Name": model.name, "Img": img, 'IdOrg': model.idOrg};

    return body;
  }
}
