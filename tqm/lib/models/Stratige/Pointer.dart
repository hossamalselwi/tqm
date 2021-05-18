import 'package:flutter/foundation.dart';

import 'ExecuteDept.dart';
import 'Goal.dart';
import 'MeasurementOfficer.dart';
import 'Unit.dart';

class PointerModel {
  String id;
  String name;
  double qty;
  //String type;
  // bool isNegitive;
  int idGoal;
  int idUnitName;
  String status;
  DateTime startStop;
  DateTime endStop;

  Polar isNegitive = Polar.POSITIVE;
  //Polar polar = Polar.POSITIVE;

  Cumulative type = Cumulative.CUMULATIVE;
  MeasurementOfficerModel measurementOfficer;
  //int pointerTarget = 0;
  MeasurementCycle measurementCycleDefoult;

  Map<MeasurementCycle, bool> pointerMCycle = {
    MeasurementCycle.JANUARY: false,
    MeasurementCycle.FEBRUARY: false,
    MeasurementCycle.MARCH: false,
    MeasurementCycle.APRIL: false,
    MeasurementCycle.MAY: false,
    MeasurementCycle.JUNE: false,
    MeasurementCycle.JULY: false,
    MeasurementCycle.AUGUST: false,
    MeasurementCycle.SEPTEMBER: false,
    MeasurementCycle.OCTOBER: false,
    MeasurementCycle.NOVEMBER: false,
    MeasurementCycle.DECEMBER: false,
  };

  UnitsModel unit;
  List<ExecuteDeptModel> executeDept = List<ExecuteDeptModel>();

  List<MeasurementCycle> mCycle=[];

  PointerModel({
    this.id,
    this.name,
    this.qty,
    this.type,
    this.status,
    this.startStop,
    this.endStop,
    this.idGoal,
    this.idUnitName,
    this.isNegitive,
    this.unit,
    this.executeDept,
    this.mCycle
  });

  factory PointerModel.fromJson(Map<String, dynamic> json) {
    String id = json['id'].toString();

    return PointerModel(
      id: id,
      name: json['name'] as String,
    );
  }

  static dynamic toJson(PointerModel model) {
    var body = {
      "name": model.name,
    };

    return body;
  }
}

enum Cumulative { CUMULATIVE, NON_CUMULATIVE }

extension CumulativeExt on Cumulative {
  String get name => describeEnum(this);

  String get displayTitle {
    switch (this) {
      case Cumulative.CUMULATIVE:
        return 'تراكمي';
        break;
      case Cumulative.NON_CUMULATIVE:
        return 'غير تراكمي';
        break;
    }
    return '';
  }
}

enum MeasurementCycle {
  JANUARY,
  FEBRUARY,
  MARCH,
  APRIL,
  MAY,
  JUNE,
  JULY,
  AUGUST,
  SEPTEMBER,
  OCTOBER,
  NOVEMBER,
  DECEMBER,
}

extension MeasurementCycleExt on MeasurementCycle {
  String get name => describeEnum(this);

  String get displayTitle {
    switch (this) {
      case MeasurementCycle.JANUARY:
        return 'يناير';
        break;
      case MeasurementCycle.FEBRUARY:
        return 'فبراير';
        break;
      case MeasurementCycle.MARCH:
        return 'مارس';
        break;
      case MeasurementCycle.APRIL:
        return 'إبريل';
        break;
      case MeasurementCycle.MAY:
        return 'مايو';
        break;
      case MeasurementCycle.JUNE:
        return 'يونيو';
        break;
      case MeasurementCycle.JULY:
        return 'يوليو';
        break;
      case MeasurementCycle.AUGUST:
        return 'أغسطس';
        break;
      case MeasurementCycle.SEPTEMBER:
        return 'سبتمبر';
        break;
      case MeasurementCycle.OCTOBER:
        return 'أكتوبر';
        break;
      case MeasurementCycle.NOVEMBER:
        return 'نوفمبر';
        break;
      case MeasurementCycle.DECEMBER:
        return 'ديسمبر';
        break;
    }
    return '';
  }
}

enum Polar { POSITIVE, NEGATIVE }

extension PolarExt on Polar {
  String get name => describeEnum(this);

  String get displayTitle {
    switch (this) {
      case Polar.POSITIVE:
        return 'موجب';
        break;
      case Polar.NEGATIVE:
        return 'سالب';
        break;
    }
    return '';
  }
}
