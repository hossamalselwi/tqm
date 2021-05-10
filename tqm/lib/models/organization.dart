// To parse this JSON data, do
//
//     final organization = organizationFromMap(jsonString);

import 'dart:convert';

import 'package:tqm/models/user.dart';

import 'SecialModel.dart';
import 'docsModel.dart';

Organization organizationFromMap(String str) => Organization.fromMap(json.decode(str));

String organizationToMap(Organization data) => json.encode(data.toMap());

class Organization {
    Organization({
        this.status,
        this.message,
        this.data,
    });

    bool status;
    String message;
    Data data;

    factory Organization.fromMap(Map<String, dynamic> json) => Organization(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toMap(),
    };
}

class Data {
    Data({
        this.id,
        this.name,
       this.email,
       this.address,
      this.image,
      this.numBasic,
      this.social, 
      this.docs,
      this.city,
      this.country,
      this.webSite ,
        this.createdAt,
        this.updatedAt,
      
    });

    /*int id;
    String name;
    String logo;
    List<String> teams;*/
    DateTime createdAt;
    DateTime updatedAt;
   // List<User> members;

     String id;
  String name;
  String email;
  String country;
  String city;


  String webSite;
  String numBasic;
  String address;
  String image;
  List<SocialModel> social;
  List<DocsModel> docs;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
          country: json["country"] == null ? null : json["country"],
          city: json["city"] == null ? null : json["city"],
          webSite: json["webSite"] == null ? null : json["webSite"],
          numBasic: json["numBasic"] == null ? null : json["numBasic"],
          address: json["address"] == null ? null : json["address"],
       // social: json["social"] == null ? null : List<String>.from(json["teams"].map((x) => x)),
       //  docs: json["docs"] == null ? null : List<User>.from(json["members"].map((x) => User.fromMap(x))),
    
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
       );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image": image == null ? null : image,
       
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
         "social": social == null ? null : List<dynamic>.from(social.map((x) => x)),
        "docs": docs == null ? null : List<dynamic>.from(docs.map((x) => x)),
    };

   /* factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        logo: json["logo"] == null ? null : json["logo"],
        teams: json["teams"] == null ? null : List<String>.from(json["teams"].map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        members: json["members"] == null ? null : List<User>.from(json["members"].map((x) => User.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "logo": logo == null ? null : logo,
        "teams": teams == null ? null : List<dynamic>.from(teams.map((x) => x)),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "members": members == null ? null : List<dynamic>.from(members.map((x) => x.toMap())),
    };*/
}
