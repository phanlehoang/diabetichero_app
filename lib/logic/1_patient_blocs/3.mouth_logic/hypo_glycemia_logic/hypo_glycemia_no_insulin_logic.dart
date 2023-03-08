import 'package:diabetichero_app/data/models/3.mouth/2.mouth_procedure.dart';
import 'package:diabetichero_app/data/models/medical/4_regimen.dart';
import 'package:diabetichero_app/data/models/medical/medical_action/2_medical_check_glucose.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/day_segment_range.dart';

class HypoGlycemiaNoInsulinLogic {
  final MouthProcedure mouthProcedure;

  HypoGlycemiaNoInsulinLogic(this.mouthProcedure);
  //last glucose time
  DateTime get lastGlucoseTime {
    DateTime t = DateTime(1999);
    //regimenLength
    for (Regimen regimen in mouthProcedure.regimens.reversed) {
      for (dynamic x in regimen.medicalActions.reversed) {
        if (x is MedicalCheckGlucose) {
          return x.time;
        }
      }
    }
    return t;
  }

  bool get isDone {
    //isHot lastGlucoseTime
    return DaySegmentRange().isHot(lastGlucoseTime);
  }

  bool get isFull50 {
    //b1: lấy hết MedicalCheckGlucose ở last regimen
    int count = 0;
    if (mouthProcedure.regimens.length == 0) return false;
    for (dynamic x in mouthProcedure.regimens.last.medicalActions) {
      if (x is MedicalCheckGlucose) {
        if (x.glucoseUI > 14) count++;
      }
    }
    return count >= 4;
  }
}
