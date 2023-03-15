import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/0.medical/medical_action/4_medical_meal.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/4_mouth_range.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/mouth_meal_range.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_fast_insulin_logic.dart';

import '../../../../data/models/3.mouth/2.mouth_procedure.dart';
import '../../../../data/models/0.medical/medical_action/3_medical_take_insulin.dart';
import 'mouth_fast_insulin_guide.dart';

class MouthTakeMealLogic {
  final MouthProcedure mouthProcedure;

  MouthTakeMealLogic({required this.mouthProcedure});

  DateTime get lastMealTime {
    dynamic lastTime = DateTime(1999);
    int regimensLength = mouthProcedure.regimens.length;
    for (int i = regimensLength - 1; i >= 0; i--) {
      for (dynamic x in mouthProcedure.regimens[i].medicalActions.reversed) {
        if (!(x is MedicalMeal)) continue;
        return x.time;
      }
    }
    return lastTime;
  }

  DateTime get lastFastInsulinTime {
    final logicFastInsulin =
        MouthFastInsulinLogic(mouthProcedure: mouthProcedure);
    return logicFastInsulin.lastFastInsulinTime;
  }

  bool get isWaitingForMeal {
    DateTime lastFastInsulinTime = this.lastFastInsulinTime;
    //nếu last fast insulin time + 10 phút >= now
    return lastFastInsulinTime
        .add(Duration(minutes: 10))
        .isAfter(DateTime.now());
  }

  bool get isMealDone {
    return MouthMealRange().isHot(this.lastMealTime);
  }
}
