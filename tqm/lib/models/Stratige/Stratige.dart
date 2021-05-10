import 'Brch.dart';
import 'Goal.dart';
import 'Years.dart';

class StratigeModel {
  int id;
  String name;
  String img;
  String idOrg;
  int iduserEnter;
  DateTime dateEnter;

  List<BrchSrtModel> brchs = List<BrchSrtModel>();
  List<YearsModel> years = List<YearsModel>();
  List<GoalModel> goals = List<GoalModel>();
  String type;

  StratigeModel(
      {this.id,
      this.name,
      this.img,
      this.dateEnter,
      this.idOrg,
      this.iduserEnter,
      this.brchs,
      this.years,
      this.type});

  factory StratigeModel.fromJson(Map<String, dynamic> json) {
    return StratigeModel(
      id: json['id'],
      name: json['name'] as String,
      img: json['email'] as String,

      //brchs: json['img'],
    );
  }

  dynamic toJson(StratigeModel model) {
    var body = {
      "Id": model.id,
      "Name": model.name.toString(),
      "Img": model.img.toString(),
      "IdOrg": model.idOrg,
      "IduserEnter": 3,
      "DateEnter": DateTime.now(),
      'Years': years == null
          ? null
          : List<dynamic>.from(years.map((x) => x.toJson(x))),
      'brchStr': brchs == null
          ? null
          : List<dynamic>.from(brchs.map((x) => x.toJson(x))),
    };

    return body;
  }

  dynamic toJsonDataBase(StratigeModel model) {
    var body = {
      "Id": model.id,
      "Name": model.name,
      "Img": model.img,
      "IdOrg": model.idOrg,
      "IduserEnter": 1,
      "DateEnter": DateTime.now(),

      /* 'Years': years == null
          ? null
          : List<dynamic>.from(years.map((x) => x.toJson(x))),
      'brchStr': brchs == null
          ? null
          : List<dynamic>.from(brchs.map((x) => x.toJson(x))),
          */
    };

    return body;
  }
}
