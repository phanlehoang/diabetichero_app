import 'package:diabetichero_app/data/models/4.fasting/2.fasting_procedure.dart';

import '../enum/enums.dart';
import '../0.medical/4_regimen.dart';
import '../0.medical/6_procedure_state.dart';
import '../0.medical/7_medical_procedure.dart';

class FastingProcedureInit {
  static FastingProcedure noInsulin(num weight) {
    return FastingProcedure(
        beginTime: DateTime.now(),
        state:
            ProcedureState(status: ProcedureStatus.noInsulin, weight: weight),
        regimens: [
          Regimen(
            beginTime: DateTime.now(),
            name: 'No Insulin',
            medicalActions: [],
          )
        ]);
  }

  static FastingProcedure firstAsk(num weight) {
    return FastingProcedure(
      beginTime: DateTime.now(),
      state: ProcedureState(
        status: ProcedureStatus.firstAsk,
        weight: weight,
      ),
      regimens: [],
    );
  }

  static FastingProcedure yesInsulin(num weight) {
    return FastingProcedure(
        beginTime: DateTime.now(),
        state: ProcedureState(
          status: ProcedureStatus.yesInsulin,
          weight: weight,
        ),
        regimens: [
          Regimen(
            beginTime: DateTime.now(),
            name: 'yesInsulin',
            medicalActions: [],
          )
        ]);
  }
}
