import 'package:diabetichero_app/data/models/3.mouth/2.mouth_procedure.dart';
import 'package:diabetichero_app/data/models/0.medical/medical_action/2_medical_check_glucose.dart';

class MouthAcuteHyperGlycemiaIsFull50Logic {
  final MouthProcedure mouthProcedure;

  MouthAcuteHyperGlycemiaIsFull50Logic(this.mouthProcedure);
  //lấy ra các MedicalCheckGlucoses của láast regimen

  List<MedicalCheckGlucose> get lastRegimenGlucoses {
    if (mouthProcedure.regimens.length == 0) {
      return [];
    }
    return mouthProcedure.regimens.last.medicalActions
        .where((element) => element is MedicalCheckGlucose)
        .map((e) => e as MedicalCheckGlucose)
        .toList();
  }

  bool get isFull50 {
    int counter = 0;
    for (MedicalCheckGlucose x in lastRegimenGlucoses) {
      if (x.glucoseUI > 10 || x.glucoseUI < 4) counter++;
    }
    return counter >= 4;
  }
}
