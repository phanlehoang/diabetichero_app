import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/2_mouth_first_ask_widget.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/3_mouth_second_ask_widget.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/hypo_glycemia/3.1_mouth_hypo_glycemia.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/hypo_glycemia/hypo_glycemia_no_insulin/mouth_hypo_glycemia_no_insulin.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/hypo_glycemia/hypo_glycemia_yes_insulin/mouth_hypo_glycemia_yes_insulin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/3.mouth/2.mouth_procedure.dart';
import 'acute_hyper_glycemia/mouth_acute_hyper_glycemia.dart';

class MouthStatusWidget extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const MouthStatusWidget({
    super.key,
    required this.mouthProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: mouthProcedureOnlineCubit,
      builder: (context, state) {
        final st = state as MouthProcedure;
        switch (st.status) {
          case MouthProcedureStatus.firstAsk:
            return MouthFirstAskWidget(
                mouthProcedureOnlineCubit: mouthProcedureOnlineCubit);
          case MouthProcedureStatus.acuteHyperglycemia:
            return MouthAcuteHyperGlycemia(
                mouthProcedureOnlineCubit: mouthProcedureOnlineCubit);
          case MouthProcedureStatus.secondAsk:
            return MouthSecondAskWidget(
                mouthProcedureOnlineCubit: mouthProcedureOnlineCubit);
          //hypo
          case MouthProcedureStatus.hypoGlycemia:
            return MouthHypoGlycemia(
                mouthProcedureOnlineCubit: mouthProcedureOnlineCubit);
          //hypo yes insulin
          case MouthProcedureStatus.hypoGlycemiaYesInsulin:
            return MouthHypoGlycemiaYesInsulin(
                mouthProcedureOnlineCubit: mouthProcedureOnlineCubit);
          //hypo no insulin
          case MouthProcedureStatus.hypoGlycemiaNoInsulin:
            return MouthHypoGlycemiaNoInsulin(
                mouthProcedureOnlineCubit: mouthProcedureOnlineCubit);
          case MouthProcedureStatus.endocrineConference:
            return Text('Hội chẩn nội tiết');
          default:
            return Text('chua lam');
        }
      },
    );
  }
}
