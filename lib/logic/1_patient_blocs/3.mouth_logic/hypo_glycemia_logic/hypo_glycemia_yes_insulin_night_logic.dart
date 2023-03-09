import 'package:diabetichero_app/data/models/3.mouth/2.mouth_procedure.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_fast_insulin_logic.dart';

class HypoGlycemiaYesInsulinNightLogic {
  final MouthProcedure mouthProcedure;

  HypoGlycemiaYesInsulinNightLogic(this.mouthProcedure);

  //bool isGlucoseDone
  bool get isGlucoseDone {
    final fastInsulinLogic =
        MouthFastInsulinLogic(mouthProcedure: mouthProcedure);
    return fastInsulinLogic.isGlucoseDone;
  }
}
