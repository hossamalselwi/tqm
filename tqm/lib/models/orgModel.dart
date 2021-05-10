import 'SecialModel.dart';
import 'docsModel.dart';

class OrgModel {
  String id;
  String name;
  String email;
  String country;
  String city;

  String webSite;
  String numBasic;
  String address;
  String image;
  //IdAdmin
  List<SocialModel> social;
  List<DocsModel> docs;

  OrgModel(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.image,
      this.numBasic,
      this.social,
      this.docs,
      this.city,
      this.country,
      this.webSite});

  factory OrgModel.fromJson(Map<String, dynamic> json) {
    String id = json['id'].toString();

    return OrgModel(
      id: id,
      name: json['nameOrg'] as String,
      email: json['email'] as String,
      country: json['country'] as String,
      webSite: json['website'] as String,
      numBasic: json['numOrg'] as String,
      address: json['address'] as String,
      image: json['logo'] as String,
      city: json['city'] as String,

      //for () List Docs

      //for () List social
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id == id,
        'nameOrg': name,
        'email': email,
        'country': country,
        'city': city,
        'website': webSite,
        'address': address,
        'numOrg': numBasic,
        'logo': image,

        //"docs": Email == null ? null : data.toMap(),
      };
}

////////////
/////////////////
////////////
///
///
