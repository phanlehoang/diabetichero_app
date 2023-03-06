import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range.dart';

import '../../../../data/models/3.mouth/2.mouth_procedure.dart';
import '../../../../data/models/medical/medical_action/2_medical_check_glucose.dart';
import '../../../../data/models/medical/medical_action/3_medical_take_insulin.dart';
import 'mouth_take_meal_guide.dart';

class MouthFastInsulinIsDone {
  List<InsulinType> FastInsulinTypes = [
    //Actrapid và novorapid
    InsulinType.Actrapid,
    InsulinType.NovoRapid,
  ];
  final MouthProcedure mouthProcedure;

  MouthFastInsulinIsDone({required this.mouthProcedure});

  DateTime get lastFastInsulinTime {
    dynamic lastTime = DateTime(1999);
    int regimensLength = mouthProcedure.regimens.length;
    for (int i = regimensLength - 1; i >= 0; i--) {
      for (dynamic x in mouthProcedure.regimens[i].medicalActions.reversed) {
        if (!(x is MedicalTakeInsulin)) continue;
        if (!(FastInsulinTypes.contains(x.insulinType))) continue;
        return x.time;
      }
    }
    return lastTime;
  }

  //last glucose time
  DateTime get lastGlucoseTime {
    dynamic lastTime = DateTime(1999);
    int regimensLength = mouthProcedure.regimens.length;
    for (int i = regimensLength - 1; i >= 0; i--) {
      for (dynamic x in mouthProcedure.regimens[i].medicalActions.reversed) {
        if (!(x is MedicalCheckGlucose)) continue;
        return x.time;
      }
    }
    return lastTime;
  }

  bool isMealDone() {
    //lấy last meal time từ mouth take meal guide
    final logicTakeMeal = MouthTakeMealGuide(mouthProcedure: mouthProcedure);
    return logicTakeMeal.isDone;
  }

  bool get isGlucoseDone {
    return MouthFastInsulinRange().isHot(this.lastGlucoseTime);
  }

  bool get isDone {
    return MouthFastInsulinRange().isHot(this.lastFastInsulinTime);
  }
}
