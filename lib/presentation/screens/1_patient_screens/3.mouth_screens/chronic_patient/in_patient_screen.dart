import 'package:diabetichero_app/data/models/3.mouth/2.mouth_procedure.dart';
import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/day_segment_range.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_fast_insulin_logic.dart';
import 'package:diabetichero_app/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/acute_hyper_glycemia/mouth_meal/mouth_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../acute_hyper_glycemia/mouth_fast_insulin/mouth_fast_insulin.dart';
import '../acute_hyper_glycemia/mouth_slow_insulin/mouth_slow_insulin.dart';

class InPatientScreen extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  final Cubit<int?> currentRangeCubit;
  const InPatientScreen({
    required this.currentRangeCubit,
    super.key,
    required this.mouthProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<TimeCheckCubit, int>(
          builder: (context, state) {
            currentRangeCubit
                .emit(DaySegmentRange().rangeContain(DateTime.now()));
            return Container();
          },
        ),
        BlocBuilder(
          bloc: mouthProcedureOnlineCubit,
          builder: (context, state) {
            //biến bool kiểm tra đã ăn xong
            final MouthProcedure mouthProcedure =
                mouthProcedureOnlineCubit.state;

            final logicIsDone =
                MouthFastInsulinLogic(mouthProcedure: mouthProcedure);
            if (currentRangeCubit.state == 0) {}
            //logic sáng, trưa, chiều
            if (mouthProcedureOnlineCubit.state.isFull50 &&
                logicIsDone.isMealDone) {
              mouthProcedureOnlineCubit.updateProcedureStatus(
                  MouthProcedureStatus.endocrineConference);
            }

            return Column(
              children: [
                Text(
                  'Phác đồ base-bolus',
                  textAlign: TextAlign.center,
                ),
                MouthSlowInsulin(
                    mouthProcedureOnlineCubit: mouthProcedureOnlineCubit),
                MouthFastInsulin(
                    mouthProcedureOnlineCubit: mouthProcedureOnlineCubit),
                //  MouthMeal(mouthProcedureOnlineCubit: mouthProcedureOnlineCubit),
              ],
            );
          },
        ),
      ],
    );
  }
}
