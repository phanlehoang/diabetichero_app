import 'package:diabetichero_app/data/models/enum/enums.dart';

import 'package:diabetichero_app/data/models/0.medical/medical_action/3_medical_take_insulin.dart';

import 'package:diabetichero_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../../data/models/0.medical/6_procedure_state.dart';
import '../../../../../data/models/4.fasting/3.fasting_procedure_online.dart';
import '../../../../../data/models/glucose-insulin_controller/fasting_slow_insulin_solve.dart';
import '../../../../../data/models/time_controller/4_fasting_range.dart';
import '../../../../../logic/1_patient_blocs/4.fasting_logic/fast_check_insulin_submit_bloc.dart';
import '../../../../widgets/nice_widgets/2_nice_button.dart';

class FastGiveNPH extends StatelessWidget {
  //add fastingProcedureOnlineCubit
  final FastingProcedureOnlineCubit fastingProcedureOnlineCubit;
  const FastGiveNPH({
    Key? key,
    required this.fastingProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    int? range = NPHRange().rangeContainToday(DateTime.now());
    if (range != null) {
      switch (fastingProcedureOnlineCubit.state.slowStatus) {
        case RegimenStatus.done:
          return Column(
            children: [
              Text('Đã tiêm xong NPH.'),
              //message next time
              Text(NPHRange().waitingMessage(DateTime.now())),
            ],
          );
        case RegimenStatus.givingInsulin:
          return GuideNPH(
            fastingProcedureOnlineCubit: fastingProcedureOnlineCubit,
          );
        default:
      }
    }
    return Text(NPHRange().waitingMessage(DateTime.now()));
  }
}

class GuideNPH extends StatelessWidget {
  final FastingProcedureOnlineCubit fastingProcedureOnlineCubit;
  const GuideNPH({
    Key? key,
    required this.fastingProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProcedureState fastingState = fastingProcedureOnlineCubit.state.state;
    num insulinAmount =
        NPHInsulinSolve().insulinAmount(fastingState: fastingState);
    String guide = NPHInsulinSolve().guide(fastingState: fastingState);

    final FastCheckedInsulinSubmit checkedInsulinSubmitBloc =
        FastCheckedInsulinSubmit(
            procedureOnlineCubit: fastingProcedureOnlineCubit,
            medicalTakeInsulin: MedicalTakeInsulin(
              insulinType: InsulinType.NPH,
              time: DateTime.now(),
              insulinUI: insulinAmount,
              // recommendedInsulinUI: insulinAmount
            ));

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
