import 'JobsEmpModel.dart';
import 'docsModel.dart';

class EmpModel {
  String id;
  String name;
  String email;
  String phone;
  String numIdityfy;
  String address;
  String image;
  List<DocsModel> docs = List<DocsModel>();
  String idorg;

  List<JobsEmpModel> jobs = List<JobsEmpModel>();

  EmpModel(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.phone,
      this.image,
      this.numIdityfy,
      this.idorg,
      this.docs,
      this.jobs});

  factory EmpModel.fromJson(Map<String, dynamic> json) {
    String id = json['id'].toString();

//--------- job
    List job = json['jop_emp_ViewModel'] as List;

    List<JobsEmpModel> tempJob = List<JobsEmpModel>();
    for (int i = 0; i < job.length; i++) {
      JobsEmpModel model = JobsEmpModel.fromJson(job[i]);
      tempJob.add(model);
    }

    return EmpModel(
        id: id,
        name: json['name'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        numIdityfy: json['num_identity'] as String,
        address: json['address'] as String,
        image: json['img'] as String,
        jobs: tempJob

        //for () List Docs
        );
  }

  static dynamic toJson(EmpModel model) {
    var body = {
      "Id": int.parse(model.id),

      "Name": model.name,
      "Img": model.image,
      "Email": model.email,
      "Phone": model.phone,
      "NumIdentity": model.numIdityfy,
      'Address': model.address,
      'IdOrg': model.idorg,

      //'Content-Type': 'application/json'
    };

    return body;
  }
}
