import 'dart:async';

import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EndocrineConferenceBloc extends FormBloc<String, String> {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  final yesNo = SelectFieldBloc(
    items: ['Có', 'Không'],
  );


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
    if (yesNo.value == 'Có') {
      //b1: update medicalTakeInsulin
      final mouthProcedure = mouthProcedureOnlineCubit.state;
      //lay ra cai regimen last
      final lastRegimen = mouthProcedure.regimens.last;
      // Cập nhật trạng thái MouthProcedure Online Cubit
      dynamic lastStatus = mouthProcedure.regimens.last.status;
      // Sửa startingPointonline trên firebase

      mouthProcedure.regimens.last.startingPoint = lastRegimen.medicalActions.length ;

      // cập nhật trạng thái
      mouthProcedureOnlineCubit.updateProcedureStatus(lastStatus);      

    } else {
      emitSuccess();
    }
  }
}
