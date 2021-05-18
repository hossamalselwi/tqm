import 'MeasurCycleMounth.dart';
import 'Pointer.dart';

class OverloadModel {
  int id;
  String type;
  double qty;
  int idBrch;
  int idExecuteDept;

  String nameBrch;

  OverloadModel(
      {this.id,
      this.type,
      this.qty,
      this.idBrch,
      this.nameBrch,
      this.measurCycleMounthModel,
        this.branchMCycle,
      this.finishMCycle = false});

  List<MeasurCycleMounthModel> measurCycleMounthModel =
      List<MeasurCycleMounthModel>();

  List<BranchMCycle> branchMCycle = [];
  bool finishMCycle;
}

class BranchMCycle {
  String id;
  String year;
  List<MCycleTarget> mCycleTarget = [];

  BranchMCycle(this.id, this.year, this.mCycleTarget);

  @override
  String toString() {
    return 'BranchMCycle{id: $id, year: $year, mCycleTarget: ${mCycleTarget.toString()}}';
  }
}

class MCycleTarget {
  String id;
  MeasurementCycle measurementCycle;
  int cycleTarget = 0;
  int cTargetActual = 0;

  MCycleTarget(this.id, this.measurementCycle, this.cycleTarget);

  @override
  String toString() {
    return 'MCycleTarget{id: $id, measurementCycle: ${measurementCycle.displayTitle}, cycleTarget: $cycleTarget}';
  }
}
