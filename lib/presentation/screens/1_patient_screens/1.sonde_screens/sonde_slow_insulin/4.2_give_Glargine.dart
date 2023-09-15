import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/glucose-insulin_controller/sonde_slow_insulin_solve.dart';
import 'package:diabetichero_app/data/models/0.medical/medical_action/3_medical_take_insulin.dart';
import 'package:diabetichero_app/data/models/time_controller/2_sonde_range.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/1.sonde_logic/check_insulin_submit_bloc.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/2_nice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../../data/models/1.sonde/7.2_sonde_procedure_online_cubit.dart';
import '../../../../../data/models/0.medical/6_procedure_state.dart';

class GiveGlargine extends StatelessWidget {
  //add sondeProcedureOnlineCubit
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  const GiveGlargine({
    Key? key,
    required this.sondeProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    int? range = GlargineRange().rangeContainToday(DateTime.now());
    if (range != null) {
      switch (sondeProcedureOnlineCubit.state.slowStatus) {
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
            sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
          );
        default:
      }
    }
    return Text(GlargineRange().waitingMessage(DateTime.now()));
  }
}

class GuideGlargine extends StatelessWidget {
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  const GuideGlargine({
    Key? key,
    required this.sondeProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProcedureState sondeState = sondeProcedureOnlineCubit.state.state;
    num insulinAmount =
        GlargineInsulinSolve().insulinAmount(sondeState: sondeState);
    String guide = GlargineInsulinSolve().guide(sondeState: sondeState);

    final CheckedInsulinSubmit checkedInsulinSubmitBloc = CheckedInsulinSubmit(
        procedureOnlineCubit: sondeProcedureOnlineCubit,
        medicalTakeInsulin: MedicalTakeInsulin(
          insulinType: InsulinType.Glargine,
          time: DateTime.now(),
          insulinUI: insulinAmount,
          // recommendedInsulinUI: insulinAmount,
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
