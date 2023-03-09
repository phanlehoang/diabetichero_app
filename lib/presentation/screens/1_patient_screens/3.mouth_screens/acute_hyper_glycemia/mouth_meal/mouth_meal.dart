import 'package:diabetichero_app/data/models/3.mouth/2.mouth_procedure.dart';
import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_take_meal_bloc.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_take_meal_logic.dart';
import 'package:diabetichero_app/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/1_nice_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'meal_submit.dart';

class MouthMeal extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const MouthMeal({
    super.key,
    required this.mouthProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeCheckCubit, int>(builder: (ct, st) {
      return Column(
        children: [
          BlocBuilder(
              bloc: mouthProcedureOnlineCubit,
              builder: (ct2, st2) {
                final logicMeal = MouthTakeMealLogic(
                    mouthProcedure: mouthProcedureOnlineCubit.state);
                if (logicMeal.isMealDone) return Text('BN đã bắt đầu ăn');
                if (logicMeal.isWaitingForMeal) {
                  DateTime eatingTime =
                      logicMeal.lastFastInsulinTime.add(Duration(minutes: 10));
                  return Column(
                    children: [
                      Text(
                          'Nếu không bị hạ đường huyết thì BN phải đợi đến ${eatingTime.hour}:${eatingTime.minute} để bắt đầu bữa ăn.'),
                      MealSubmit(
                          mouthProcedureOnlineCubit: mouthProcedureOnlineCubit),
                    ],
                  );
                } else
                  return MealSubmit(
                      mouthProcedureOnlineCubit: mouthProcedureOnlineCubit);
              }),
          //tạo form với medical take meal bloc
        ],
      );
    });
  }
}
