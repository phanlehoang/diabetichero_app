import 'dart:async';

import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EndocrineConferenceBloc extends FormBloc<String, String> {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  final yesNo = BooleanFieldBloc();

  EndocrineConferenceBloc({required this.mouthProcedureOnlineCubit}) : super() {
    addFieldBlocs(
      fieldBlocs: [
        yesNo,
      ],
    );
  }
  //2 lua chon co hoac khong

  @override
  FutureOr<void> onSubmitting() async {
    //neu yes
    if (yesNo.value == true) {
      //b1: update medicalTakeInsulin
      final mouthProcedure = mouthProcedureOnlineCubit.state;
      //lay ra cai regimen last
      final lastRegimen = mouthProcedure.regimens.last;
      //if name is AcuteHyperglycemia
      if (lastRegimen.name == 'Acute Hyper Glycemia') {
        //b2: update database
        //update procedure status
        mouthProcedureOnlineCubit
            .updateProcedureStatus(MouthProcedureStatus.acuteHyperglycemia);
        await mouthProcedureOnlineCubit
            .addMedicalAction(lastRegimen.medicalActions.last);
        //b3: update UI
        emitSuccess();
      } else if (lastRegimen.name == 'Hypo Glycemia') {
        //b2: update database
        //update procedure status
        mouthProcedureOnlineCubit
            .updateProcedureStatus(MouthProcedureStatus.hypoGlycemia);
        await mouthProcedureOnlineCubit
            .addMedicalAction(lastRegimen.medicalActions.last);
        //b3: update UI
        emitSuccess();
      } else if (lastRegimen.name == 'Phác đồ nội trú') {
        emitFailure();
      }
    } else {
      emitSuccess();
    }
  }
}
