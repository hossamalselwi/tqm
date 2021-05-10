
class StatusModel {
  int id;
  String name;
  String code2;
  String code3;
  List<Statee> state;

  StatusModel({this.id, this.name, this.code2, this.code3, this.state});

  StatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code2 = json['code2'];
    code3 = json['code3'];
    if (json['states'] != null) {
      state = new List<Statee>();
      json['states'].forEach((v) {
        state.add(new Statee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code2'] = this.code2;
    data['code3'] = this.code3;
    if (this.state != null) {
      data['state'] = this.state.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statee {
  int id;
  String name;
  int countryId;
  List<City> city;

  Statee({this.id, this.name, this.countryId, this.city});

  Statee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryId = json['country_id'];
    if (json['city'] != null) {
      city = new List<City>();
      json['city'].forEach((v) {
        city.add(new City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['country_id'] = this.countryId;
    if (this.city != null) {
      data['city'] = this.city.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int id;
  String name;
  int stateId;

  City({this.id, this.name, this.stateId});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state_id'] = this.stateId;
    return data;

  }
}

