import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/0.medical/medical_action/2_medical_check_glucose.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/4_mouth_range.dart';

import '../../../../data/models/3.mouth/2.mouth_procedure.dart';
import '../../../../data/models/0.medical/medical_action/3_medical_take_insulin.dart';

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
    //for reverse
    for (int i = regimensLength - 1; i >= 0; i--) {
      int medicalActionsLength =
          mouthProcedure.regimens[i].medicalActions.length;
      //for reverse
      for (int j = medicalActionsLength - 1; j >= 0; j--) {
        dynamic x = mouthProcedure.regimens[i].medicalActions[j];
        if (x is MedicalTakeInsulin) {
          if (slowInsulinTypes.contains(x.insulinType)) {
            return x.time;
          }
        }
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

  bool get isSlowInsulinDone {
    return MouthSlowInsulinRange().isHot(this.lastSlowInsulinTime);
  }
}
