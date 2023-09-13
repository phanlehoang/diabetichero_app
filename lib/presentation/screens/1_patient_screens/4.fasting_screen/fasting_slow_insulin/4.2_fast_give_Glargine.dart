import 'package:diabetichero_app/data/models/enum/enums.dart';

import 'package:diabetichero_app/data/models/0.medical/medical_action/3_medical_take_insulin.dart';

import 'package:diabetichero_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/2_nice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../../data/models/0.medical/6_procedure_state.dart';
import '../../../../../data/models/4.fasting/3.fasting_procedure_online.dart';
import '../../../../../data/models/glucose-insulin_controller/fasting_slow_insulin_solve.dart';
import '../../../../../data/models/time_controller/4_fasting_range.dart';
import '../../../../../logic/1_patient_blocs/4.fasting_logic/fast_check_insulin_submit_bloc.dart';

class FastGiveGlargine extends StatelessWidget {
  //add fastProcedureOnlineCubit
  final FastingProcedureOnlineCubit fastProcedureOnlineCubit;
  const FastGiveGlargine({
    Key? key,
    required this.fastProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    int? range = GlargineRange().rangeContainToday(DateTime.now());
    if (range != null) {
      switch (fastProcedureOnlineCubit.state.slowStatus) {
        case RegimenStatus.done:
          return Column(
            children: [
              Text('Bạn đã tiêm xong Glargine.'),
              //message
              Text(GlargineRange().waitingMessage(DateTime.now())),
            ],
          );
        case RegimenStatus.givingInsulin:
          return GuideGlargine(
            fastProcedureOnlineCubit: fastProcedureOnlineCubit,
          );
        default:
      }
    }
    return Text(GlargineRange().waitingMessage(DateTime.now()));
  }
}

class GuideGlargine extends StatelessWidget {
  final FastingProcedureOnlineCubit fastProcedureOnlineCubit;
  const GuideGlargine({
    Key? key,
    required this.fastProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProcedureState fastState = fastProcedureOnlineCubit.state.state;
    num insulinAmount =
        GlargineInsulinSolve().insulinAmount(fastingState: fastState);
    String guide = GlargineInsulinSolve().guide(fastingState: fastState);

    final FastCheckedInsulinSubmit checkedInsulinSubmitBloc =
        FastCheckedInsulinSubmit(
            procedureOnlineCubit: fastProcedureOnlineCubit,
            medicalTakeInsulin: MedicalTakeInsulin(
                insulinType: InsulinType.Glargine,
                time: DateTime.now(),
                insulinUI: insulinAmount));

    return FormBlocListener(
      formBloc: checkedInsulinSubmitBloc,
      onFailure: (ct, st) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Ko cap nhat duoc database')));
      },
      child: NiceScreen(
          child: Column(
        children: [
          Text('Hướng dẫn: $guide'),
          NiceButton(
              text: 'Tiêm xong',
              onTap: () {
                checkedInsulinSubmitBloc.submit();
              }),
        ],
      )),
    );
  }
}
