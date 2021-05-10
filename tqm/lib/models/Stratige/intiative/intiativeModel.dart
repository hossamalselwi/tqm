import 'dart:io';

import '../Pointer.dart';

class InitiativeModel {
  String id;
  String name;
  List<InitiativePointersModel> initiativePointers = [];
  File initiativeImg;
  File initiativeFile;

  InitiativeModel(
      {this.id,
      this.name,
      this.initiativeImg,
      this.initiativeFile,
      this.initiativePointers});

  factory InitiativeModel.fromJson(Map<String, dynamic> json) {
    String id = json['id'].toString();

    return InitiativeModel(
      id: id,
      name: json['name'] as String,

      // image: json['logo'] as String,
    );
  }

  dynamic toJson(InitiativeModel model) {
    var body = {
      'Id': model.id,
      // 'IdBrch': model.idBrch,
      'IdStr': 0,
    };

    return body;
  }

  @override
  String toString() {
    return 'InitiativeModel{id: $id, name: $name, initiativePointers: ${initiativePointers.toString()}, initiativeImg: $initiativeImg, initiativeFile: $initiativeFile}';
  }
}

class InitiativePointersModel {
  String id;
  PointerModel pointer;
  int coverageRatio;

  InitiativePointersModel(this.id, this.pointer, this.coverageRatio);

  @override
  String toString() {
    return 'InitiativePointersModel{id: $id, pointer: ${pointer.toString()}, coverageRatio: $coverageRatio}';
  }
}
