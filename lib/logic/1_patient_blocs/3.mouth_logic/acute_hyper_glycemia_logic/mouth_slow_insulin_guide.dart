import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/medical/3_medical_take_insulin.dart';

import '../../../../data/models/enum/enums.dart';

class MouthSlowInsulinGuide {
  static num insulinUI(num weight) {
    return (weight * 0.2).round();
  }

  static MedicalTakeInsulin medicalTakeInsulin(num weight) {
    return MedicalTakeInsulin(
      insulinUI: insulinUI(weight),
      insulinType: InsulinType.levemir,
      time: DateTime.now(),
    );
  }
}
