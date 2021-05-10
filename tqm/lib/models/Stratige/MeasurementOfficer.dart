class MeasurementOfficerModel {
  String id;
  String name;

  MeasurementOfficerModel();

  MeasurementOfficerModel.build(this.id, this.name);

  static List<MeasurementOfficerModel> _allMeasurementOfficers = [
    MeasurementOfficerModel.build('1', 'الإستراتيجية'),
    MeasurementOfficerModel.build('2', 'الشئون المالية'),
    MeasurementOfficerModel.build('3', 'مراجع خارجية'),
  ];

  static List<MeasurementOfficerModel> get allMeasurementOfficers =>
      _allMeasurementOfficers;

  static addMeasurementOfficer(
          MeasurementOfficerModel measurementOfficerModel) =>
      _allMeasurementOfficers.add(measurementOfficerModel);
}
