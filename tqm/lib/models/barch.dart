import 'docsModel.dart';

class Barch {
  String id;
  String name;
  String countryid;
  String city;
  String address;
  String image;
  String email;
  String idorg;
  int countDepts;
  List<DocsModel> dos;

  bool isSelect;

  Barch(
      {this.id,
      this.name,
      this.countryid,
      this.city,
      this.address,
      this.image,
      this.dos,
      this.email,
      this.idorg,
      this.countDepts,
      this.isSelect});

  factory Barch.fromJson(Map<String, dynamic> json) {
    String id = json['id'].toString();

    return Barch(
      id: id,
      name: json['name'] as String,
      city: json['city'] as String,
      countryid: json['country'] as String,
      address: json['address'] as String,
      image: json['logo'] as String,
      email: json['email'] as String,
      countDepts: json['countDepts'] as int,
      dos: json['dos'],
    );
  }

  dynamic toJson(Barch model) {
    var body = {
      'Id': model.id,
      "NameBra": model.name,
      "Address": model.address.toString(),
      "Country": model.countryid,
      "City": model.city,
      "Email": model.email.toString(),
      "Logo": model.image.toString(),
      "IdOrg": model.idorg
    };

    return body;
  }
}
