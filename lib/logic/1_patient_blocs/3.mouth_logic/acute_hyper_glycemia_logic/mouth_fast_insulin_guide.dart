import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/medical/medical_action/3_medical_take_insulin.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/3.mouth/2.mouth_procedure.dart';
import '../../../../data/models/enum/enums.dart';
import '../../../../data/models/glucose-insulin_controller/glucose_solve.dart';
import '../../../../data/models/medical/medical_action/2_medical_check_glucose.dart';

class MouthFastInsulinGuide {
  GlucoseEvaluation eval(num glucose) {
    if (glucose < 3.9) {
      return GlucoseEvaluation.low;
    }
    if (glucose <= 8.3) {
      return GlucoseEvaluation.normal;
    }
    if (glucose <= 11.1) {
      return GlucoseEvaluation.high;
    }
    if (glucose < 19.5) return GlucoseEvaluation.superHigh;
    return GlucoseEvaluation.extremelyHigh;
  }

  final MouthProcedure mouthProcedure;

  MouthFastInsulinGuide(this.mouthProcedure);
  static num insulinUI(num weight) {
    return (weight * 0.05).round();
  }

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
        break;
      case GlucoseEvaluation.normal:
        bonus = 0;
        break;
      case GlucoseEvaluation.high:
        bonus = 1;
        break;
      case GlucoseEvaluation.superHigh:
        bonus = 2;
        break;
      case GlucoseEvaluation.extremelyHigh:
        bonus = 4;
        break;
      default:
    }
    return MedicalTakeInsulin(
      insulinType: InsulinType.Fast,
      time: DateTime.now(),
      insulinUI: insulinUI(mouthProcedure.regimens.last.weight) + bonus,
    );
  }

  Widget get guide {
    MedicalTakeInsulin medicalTakeInsulin = medicalTakeInsulinGuide;
    switch (eval(lastGlucoseAmount)) {
      case GlucoseEvaluation.low:
        return Text('Ngừng tiêm insulin. Xử trí hạ đường huyết');
      case GlucoseEvaluation.normal:
        return Text(
            'Không thay đổi liều. Tiêm ${medicalTakeInsulin.insulinUI} UI insulin tác dụng nhanh(Actrapid, NovoRapid)');
      case GlucoseEvaluation.high:
        return Text(
            'Tiêm ${medicalTakeInsulin.insulinUI} UI insulin tác dụng nhanh(Actrapid, NovoRapid)');
      case GlucoseEvaluation.superHigh:
        return Text(
            'Tiêm ${medicalTakeInsulin.insulinUI} UI insulin tác dụng nhanh(Actrapid, NovoRapid)');
      case GlucoseEvaluation.extremelyHigh:
        return Text(
            'Tiêm ${medicalTakeInsulin.insulinUI} UI insulin tác dụng nhanh(Actrapid, NovoRapid)');
      default:
        return Container();
    }
  }
}
