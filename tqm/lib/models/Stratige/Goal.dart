import 'customer.dart';
import 'domain.dart';
import 'Pointer.dart';
import 'enverement.dart';

class GoalModel {
  String id;
  String name;
  String idOrg;
  String code;
  String img;
  int idStr;
  int idGoalName;
  int idDomainName;
  int idCustomerName;
  int idEnviromentName;
  List<PointerModel> pointers = List<PointerModel>();

  DomainModel domainModel;
  CustomerModel customerModel;
  EnviromentModel enviromentModel;

  GoalModel({
    this.id,
    this.name,
    this.code,
    this.idGoalName,
    this.img,
    this.idCustomerName,
    this.idDomainName,
    this.idStr,
    this.idEnviromentName,
    this.idOrg,
    this.pointers,
    //this.domainModel,
    // this.customerModel,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    String id = json['id'].toString();

    return GoalModel(
      id: id,
      name: json['name'] as String,
    );
  }

  static dynamic toJson(GoalModel model) {
    var body = {
      "name": model.name,

      //'Content-Type': 'application/json'
    };

    return body;
  }
}
