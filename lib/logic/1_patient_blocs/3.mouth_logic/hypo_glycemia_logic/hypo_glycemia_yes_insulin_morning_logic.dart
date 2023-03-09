import 'package:diabetichero_app/data/models/3.mouth/2.mouth_procedure.dart';
import 'package:diabetichero_app/data/models/time_controller/0_check_time_in_range.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/day_segment_range.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_fast_insulin_logic.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_slow_insulin_logic.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_take_meal_logic.dart';

class HypoGlycemiaYesInsulinMorningLogic {
  final MouthProcedure mouthProcedure;

  HypoGlycemiaYesInsulinMorningLogic(this.mouthProcedure);
  //lấy isMealDone từ logic
  bool get isMealDone {
    final mealLogic = MouthTakeMealLogic(mouthProcedure: mouthProcedure);
    return mealLogic.isMealDone;
  }

  //last fast insulin time
  DateTime get lastFastInsulinTime {
    final fastInsulinLogic =
        MouthFastInsulinLogic(mouthProcedure: mouthProcedure);
    return fastInsulinLogic.lastFastInsulinTime;
  }

  //bool isWaiting
  bool get isWaitingForMeal {
    final fastInsulinLogic =
        MouthFastInsulinLogic(mouthProcedure: mouthProcedure);
    DateTime lastFastInsulinTime = fastInsulinLogic.lastFastInsulinTime;
    //nếu last fast insulin time + 10 phút >= now
    return lastFastInsulinTime
        .add(Duration(minutes: 30))
        .isAfter(DateTime.now());
  }

  //lastFastInsulinTime
  DateTime get lastSlowInsulinTime {
    final slowInsulinLogic =
        MouthSlowInsulinLogic(mouthProcedure: mouthProcedure);
    return slowInsulinLogic.lastSlowInsulinTime;
  }

  //bool fastInsulinDone
  bool get isFastInsulinDone {
    final fastInsulinLogic =
        MouthFastInsulinLogic(mouthProcedure: mouthProcedure);
    return fastInsulinLogic.isFastInsulinDone;
  }

  //bool slowInsulinDone
  bool get isSlowInsulinDone {
    final slowInsulinLogic =
        MouthSlowInsulinLogic(mouthProcedure: mouthProcedure);
    Range lantusMorningRange = DaySegmentRange().ranges[0];
    return inRangeToday(DateTime.now(), lantusMorningRange) &&
        inRangeToday(lastSlowInsulinTime, lantusMorningRange);
  }

  //bool isGlucoseDone
  bool get isGlucoseDone {
    final fastInsulinLogic =
        MouthFastInsulinLogic(mouthProcedure: mouthProcedure);
    return fastInsulinLogic.isGlucoseDone;
  }
}
