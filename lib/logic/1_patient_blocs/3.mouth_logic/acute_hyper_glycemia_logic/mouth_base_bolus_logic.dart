import 'package:diabetichero_app/data/models/3.mouth/2.mouth_procedure.dart';
import 'package:diabetichero_app/data/models/0.medical/medical_action/2_medical_check_glucose.dart';

class MouthBaseBolusLogic {
  final MouthProcedure mouthProcedure;

  MouthBaseBolusLogic(this.mouthProcedure);
  //lấy ra các MedicalCheckGlucoses của last regimen

  List<MedicalCheckGlucose> get lastRegimenGlucoses {
    if (mouthProcedure.regimens.length == 0) {
      return [];
    }
    return mouthProcedure.regimens.last.medicalActions
        .where((element) => element is MedicalCheckGlucose)
        .map((e) => e as MedicalCheckGlucose)
        .toList()
        .reversed
        .toList();
  }

  bool get isFull50 {
    int counter = 0;
    num startingPoint = mouthProcedure.regimens.last.startingPoint; 
    num distance = lastRegimenGlucoses.length - startingPoint; 
    if (distance >= 8) {
        startingPoint = lastRegimenGlucoses.length - 8;
      }
        for(int y = startingPoint.toInt(); y < lastRegimenGlucoses.length; y++){
          num glucoseUI = lastRegimenGlucoses[y].glucoseUI; 
        if (glucoseUI > 10 || glucoseUI < 4) counter++;
    }
    return counter >= 4; 
    
  }
  
}
