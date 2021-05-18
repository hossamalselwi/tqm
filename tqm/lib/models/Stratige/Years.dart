class YearsModel {
  int id;
  final int number;
  final String name;

  String idStr;
  bool isActive;

  YearsModel({this.id, this.number, this.name, this.idStr, this.isActive});

  dynamic toJson(YearsModel model) {
    var body = {
      "Id": model.id,
      "Num": model.number,
      "IdStr": model.idStr,
    };

    return body;
  }
}
