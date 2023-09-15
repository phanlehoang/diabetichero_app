import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/4_mouth_range.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/mouth_meal_range.dart';

import '../../../../data/models/3.mouth/2.mouth_procedure.dart';
import '../../../../data/models/0.medical/medical_action/2_medical_check_glucose.dart';
import '../../../../data/models/0.medical/medical_action/3_medical_take_insulin.dart';
import 'mouth_take_meal_logic.dart';

class MouthFastInsulinLogic {
  List<InsulinType> FastInsulinTypes = [
    //Actrapid và novorapid
    InsulinType.Actrapid,
    InsulinType.NovoRapid,
    InsulinType.Humalog_kwikpen,
    InsulinType.Fast,
  ];
  final MouthProcedure mouthProcedure;

  MouthFastInsulinLogic({required this.mouthProcedure});

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

  bool get isMealDone {
    //lấy last meal time từ mouth take meal guide
    final logicTakeMeal = MouthTakeMealLogic(mouthProcedure: mouthProcedure);
    return logicTakeMeal.isMealDone;
  }

  bool get isGlucoseDone {
    return MouthMealRange().isHot(this.lastGlucoseTime);
  }

  bool get isFastInsulinDone {
    return MouthMealRange().isHot(this.lastFastInsulinTime);
  }
}
