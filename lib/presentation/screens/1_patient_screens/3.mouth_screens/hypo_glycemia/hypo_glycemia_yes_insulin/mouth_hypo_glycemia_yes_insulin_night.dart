import 'package:diabetichero_app/data/models/3.mouth/2.mouth_procedure.dart';
import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/day_segment_range.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/hypo_glycemia_logic/hypo_glycemia_yes_insulin_night_logic.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/1.sonde_screens/sonde_fast_insulin/2_1_1_check_glucose_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MouthHypoGlycemiaYesInsulinNight extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const MouthHypoGlycemiaYesInsulinNight(
      {super.key, required this.mouthProcedureOnlineCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: mouthProcedureOnlineCubit,
        builder: (ct, st) {
          final mouthProcedure = st as MouthProcedure;
          final nightLogic = HypoGlycemiaYesInsulinNightLogic(mouthProcedure);
          if (nightLogic.isGlucoseDone) {
            return Text(DaySegmentRange().waitingMessage(DateTime.now()));
          }
          return CheckGlucoseWidget(
              procedureOnlineCubit: mouthProcedureOnlineCubit);
        });
  }
}
