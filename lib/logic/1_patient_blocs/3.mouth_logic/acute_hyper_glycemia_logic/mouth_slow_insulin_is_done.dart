import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/4_mouth_range.dart';

import '../../../../data/models/3.mouth/2.mouth_procedure.dart';
import '../../../../data/models/medical/medical_action/3_medical_take_insulin.dart';

class MouthSlowInsulinIsDone {
  List<InsulinType> slowInsulinTypes = [
    InsulinType.Levemir,
    InsulinType.Lantus,
    InsulinType.Insulatard,
  ];
  final MouthProcedure mouthProcedure;

  MouthSlowInsulinIsDone({required this.mouthProcedure});

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

  bool get isDone {
    return MouthSlowInsulinRange().isHot(this.lastSlowInsulinTime);
  }
}
