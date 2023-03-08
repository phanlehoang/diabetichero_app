import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/medical/medical_action/2_medical_check_glucose.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/4_mouth_range.dart';

import '../../../../data/models/3.mouth/2.mouth_procedure.dart';
import '../../../../data/models/medical/medical_action/3_medical_take_insulin.dart';

class MouthSlowInsulinLogic {
  List<InsulinType> slowInsulinTypes = [
    InsulinType.Levemir,
    InsulinType.Lantus,
    InsulinType.Insulatard,
    InsulinType.Slow,
  ];
  final MouthProcedure mouthProcedure;

  MouthSlowInsulinLogic({required this.mouthProcedure});

  DateTime get lastSlowInsulinTime {
    dynamic lastTime = DateTime(1999);
    int regimensLength = mouthProcedure.regimens.length;
    for (int i = 0; i < regimensLength; i++) {
      for (dynamic x in mouthProcedure.regimens[i].medicalActions) {
        if (!(x is MedicalTakeInsulin)) continue;
        if (!(slowInsulinTypes.contains(x.insulinType))) continue;
        if (x.time.isAfter(lastTime)) lastTime = x.time;
      }
    }
    return lastTime;
  }

  //last glucose time
  DateTime get lastGlucoseTime {
    DateTime t = DateTime(1999);
    //regimenLength
    for (int i = mouthProcedure.regimens.length - 1; i >= 0; i--) {
      for (dynamic x in mouthProcedure.regimens[i].medicalActions.reversed) {
        if (x is MedicalCheckGlucose) {
          return x.time;
        }
      }
    }
    return t;
  }

  bool get isGlucoseDone {
    return MouthSlowInsulinRange().isHot(this.lastGlucoseTime);
  }

  bool get isDone {
    return MouthSlowInsulinRange().isHot(this.lastSlowInsulinTime);
  }
}
