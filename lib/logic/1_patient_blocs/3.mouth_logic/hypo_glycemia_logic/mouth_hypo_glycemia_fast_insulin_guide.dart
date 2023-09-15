import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/0.medical/medical_action/3_medical_take_insulin.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/3.mouth/2.mouth_procedure.dart';
import '../../../../data/models/enum/enums.dart';
import '../../../../data/models/glucose-insulin_controller/glucose_solve.dart';
import '../../../../data/models/0.medical/medical_action/2_medical_check_glucose.dart';

class MouthHypoGlycemiaFastInsulinGuide {
  GlucoseEvaluation eval(num glucose) {
    if (glucose <= 7.8) {
      return GlucoseEvaluation.low;
    }

    if (glucose <= 14) {
      return GlucoseEvaluation.normal;
    }
    if (glucose < 19.5) return GlucoseEvaluation.high;
    return GlucoseEvaluation.superHigh;
  }

  final MouthProcedure mouthProcedure;

  MouthHypoGlycemiaFastInsulinGuide(this.mouthProcedure);

  num get lastGlucoseAmount {
    num glucose = 0;
    int regimensLength = mouthProcedure.regimens.length;
    for (int i = regimensLength - 1; i >= 0; i--) {
      for (dynamic x in mouthProcedure.regimens[i].medicalActions.reversed) {
        if (!(x is MedicalCheckGlucose)) continue;
        return x.glucoseUI;
      }
    }
    return glucose;
  }

  MedicalTakeInsulin get medicalTakeInsulinGuide {
    num bonus = 0;
    switch (eval(lastGlucoseAmount)) {
      case GlucoseEvaluation.low:
        bonus = 0;
        return MedicalTakeInsulin(
          insulinType: InsulinType.Fast,
          time: DateTime.now(),
          insulinUI: 0,
          // recommendedInsulinUI: 0,
        );
      case GlucoseEvaluation.normal:
        bonus = 0;
        break;
      case GlucoseEvaluation.high:
        bonus = 2;
        break;
      case GlucoseEvaluation.superHigh:
        bonus = 4;
        break;
      default:
    }

    return MedicalTakeInsulin(
      insulinType: InsulinType.Fast,
      time: DateTime.now(),
      insulinUI: bonus,
      // recommendedInsulinUI: bonus,
    );
  }

  Widget get guide {
    MedicalTakeInsulin medicalTakeInsulin = medicalTakeInsulinGuide;
    switch (eval(lastGlucoseAmount)) {
      case GlucoseEvaluation.low:
        return Text('Ngừng tiêm insulin. Xử trí hạ đường huyết');
      case GlucoseEvaluation.normal:
        return Text('Không tiêm insulin tác dụng nhanh.');
      case GlucoseEvaluation.high:
        return Text(
            'Tiêm ${medicalTakeInsulin.insulinUI} UI insulin tác dụng nhanh(Actrapid, NovoRapid, Humalog_kwikpen)');
      case GlucoseEvaluation.superHigh:
        return Text(
            'Tiêm ${medicalTakeInsulin.insulinUI} UI insulin tác dụng nhanh(Actrapid, NovoRapid, Humalog_kwikpen)');
      case GlucoseEvaluation.extremelyHigh:
        return Text(
            'Tiêm ${medicalTakeInsulin.insulinUI} UI insulin tác dụng nhanh(Actrapid, NovoRapid, Humalog_kwikpen)');
      default:
        return Container();
    }
  }
}
