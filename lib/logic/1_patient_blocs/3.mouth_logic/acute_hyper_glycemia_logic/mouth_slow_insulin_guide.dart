import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';

import '../../../../data/models/enum/enums.dart';
import '../../../../data/models/0.medical/medical_action/3_medical_take_insulin.dart';

class MouthSlowInsulinGuide {
  static num insulinUI(num weight) {
    return (weight * 0.2).round();
  }

  MedicalTakeInsulin medicalTakeInsulin(num weight) {
    return MedicalTakeInsulin(
      insulinUI: insulinUI(weight),
      insulinType: InsulinType.Slow,
      time: DateTime.now(),
      recommendedInsulinUI: insulinUI(weight),
    );
  }
}
