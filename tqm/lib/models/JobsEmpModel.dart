class JobsEmpModel {
  int id;
  int idDeptJob;
  int idEmp;

  String idJob;
  String nameJob;

  String namedept;
  String idBrch;
  String nameBrch;

  JobsEmpModel(
      {this.id,
      this.nameJob,
      this.namedept,
      this.nameBrch,
      this.idBrch,
      this.idDeptJob,
      this.idEmp,
      this.idJob});

  Map<String, dynamic> toMap() => {
        "Id": id == null ? null : id,
        "IdEmp": idEmp == null ? null : idEmp,
        "IdJobDept": idDeptJob == null ? null : idDeptJob,
      };

  factory JobsEmpModel.fromJson(Map<String, dynamic> json) {
    //------ dept
    var de = json['dept'];
    int idDept;
    String nameDept;

    if (de != null) {
      idDept = de['id'];
      nameDept = de['name'] as String;
    }
//----------Brch
    var br = json['brch'];
    String idBrchs;
    String nameBrchs;

    if (br != null) {
      idBrchs = br['id'].toString();
      nameBrchs = br['name'].toString();
    }

    int id = json['id'];

    return JobsEmpModel(
        id: id,
        nameJob: json['name_job'] as String,
        idJob: json['id_job'].toString(),
        namedept: nameDept,
        idBrch: idBrchs.toString(),
        idDeptJob: idDept,
        idEmp: json['id_emp'],
        nameBrch: nameBrchs.toString());
  }
}
