import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/day_segment_range.dart';
import 'package:diabetichero_app/logic/status_cubit/range_cubit.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/2_mouth_first_ask_widget.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/3_mouth_second_ask_widget.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/chronic_patient/in_or_out_patient_ask_screen.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/chronic_patient/in_patient_screen.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/chronic_patient/out_patient_screen.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/chronic_patient/third_ask_screen.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/endocrineConference_screen.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/hypo_glycemia/3.1_mouth_hypo_glycemia.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/hypo_glycemia/hypo_glycemia_no_insulin/mouth_hypo_glycemia_no_insulin.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/hypo_glycemia/hypo_glycemia_yes_insulin/mouth_hypo_glycemia_yes_insulin.dart';
import 'package:flutter/material.dart';

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
                currentRangeCubit:
                    RangeCubit(DaySegmentRange().rangeContain(DateTime.now())),
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
                mouthProcedureOnlineCubit: mouthProcedureOnlineCubit,
                currentRangeCubit:
                    RangeCubit(DaySegmentRange().rangeContain(DateTime.now())));
          //hypo no insulin
          case MouthProcedureStatus.hypoGlycemiaNoInsulin:
            return MouthHypoGlycemiaNoInsulin(
                mouthProcedureOnlineCubit: mouthProcedureOnlineCubit);
          case MouthProcedureStatus.endocrineConference:
            return EndocrineConferenceScreen(
                mouthProcedureOnlineCubit: mouthProcedureOnlineCubit);
          case MouthProcedureStatus.thirdAsk:
            return ThirdAskScreen(
                mouthProcedureOnlineCubit: mouthProcedureOnlineCubit);
          case MouthProcedureStatus.in_or_out_patient_ask:
            return InOrOutPatientAskScreen(
                mouthProcedureOnlineCubit: mouthProcedureOnlineCubit);
          case MouthProcedureStatus.outpatient:
            return OutPatientScreen(
                mouthProcedureOnlineCubit: mouthProcedureOnlineCubit);
          case MouthProcedureStatus.inpatient:
            return InPatientScreen(
                currentRangeCubit:
                    RangeCubit(DaySegmentRange().rangeContain(DateTime.now())),
                mouthProcedureOnlineCubit: mouthProcedureOnlineCubit);

          default:
            return Text('chua lam');
        }
      },
    );
  }
}
