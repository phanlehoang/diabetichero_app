import 'package:diabetichero_app/data/models/3.mouth/2.mouth_procedure.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/day_segment_range.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/hypo_glycemia_logic/hypo_glycemia_yes_insulin_logic.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/hypo_glycemia_logic/hypo_glycemia_yes_insulin_morning_logic.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/hypo_glycemia_logic/mouth_hypo_glycemia_fast_insulin_guide.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/1.sonde_screens/sonde_fast_insulin/2_1_1_check_glucose_widget.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/acute_hyper_glycemia/mouth_fast_insulin/mouth_real_fast_insulin.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/acute_hyper_glycemia/mouth_meal/meal_submit.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/acute_hyper_glycemia/mouth_slow_insulin/mouth_real_slow_insulin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class MouthHypoGlycemiaYesInsulinMiddle extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;

  const MouthHypoGlycemiaYesInsulinMiddle({
    Key? key,
    required this.mouthProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder(
            bloc: mouthProcedureOnlineCubit,
            builder: (ct, st) {
              final MouthProcedure mouthProcedure = st as MouthProcedure;
              final morningLogic =
                  HypoGlycemiaYesInsulinMorningLogic(mouthProcedure);
              if (morningLogic.isMealDone) {
                final goNextLogic = HypoGlycemiaYesInsulinLogic(mouthProcedure);
                if (goNextLogic.isFull50) {
                  mouthProcedureOnlineCubit.updateProcedureStatus(
                      MouthProcedureStatus.endocrineConference);
                }
                return Column(
                  children: [
                    Text('Đã xong'),
                    Text(DaySegmentRange().waitingMessage(DateTime.now())),
                  ],
                );
              }
              if (morningLogic.isFastInsulinDone) {
                DateTime eatingTime =
                    morningLogic.lastFastInsulinTime.add(Duration(minutes: 10));

                return Column(
                  children: [
                    Text(
                        'Nếu không bị hạ đường huyết thì BN phải đợi đến ${eatingTime.hour}:${eatingTime.minute} để bắt đầu bữa ăn.'),
                    MealSubmit(
                        mouthProcedureOnlineCubit: mouthProcedureOnlineCubit),
                  ],
                );
              }
              if (morningLogic.isGlucoseDone) {
                final fastInsulinLogic = MouthHypoGlycemiaFastInsulinGuide(
                    mouthProcedureOnlineCubit.state);
                return Column(
                  children: [
                    fastInsulinLogic.guide,
                    MouthRealFastInsulin(
                        logicGuide: fastInsulinLogic,
                        mouthProcedureOnlineCubit: mouthProcedureOnlineCubit),
                  ],
                );
              }

              return Column(
                children: [
                  Text('Đo đường huyết'),
                  CheckGlucoseWidget(
                      procedureOnlineCubit: mouthProcedureOnlineCubit),
                ],
              );
            })
      ],
    );
  }
}
