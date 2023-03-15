import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/0.medical/medical_action/3_medical_take_insulin.dart';

class HypoGlycemiaLantusGuide {
  final num weight;
  HypoGlycemiaLantusGuide(this.weight);
  MedicalTakeInsulin get medicalTakeInsulin {
    return MedicalTakeInsulin(
      time: DateTime.now(),
      insulinUI: 0.2 * weight,
      insulinType: InsulinType.Lantus,
    );
  }
}
