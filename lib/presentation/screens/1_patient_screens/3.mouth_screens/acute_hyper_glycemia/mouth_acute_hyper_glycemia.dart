import 'package:diabetichero_app/data/models/3.mouth/2.mouth_procedure.dart';
import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_fast_insulin_is_done.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/acute_hyper_glycemia/mouth_meal/mouth_meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mouth_fast_insulin/mouth_fast_insulin.dart';
import 'mouth_slow_insulin/mouth_slow_insulin.dart';

class MouthAcuteHyperGlycemia extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const MouthAcuteHyperGlycemia({
    super.key,
    required this.mouthProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: mouthProcedureOnlineCubit,
      builder: (context, state) {
        //biến bool kiểm tra đã ăn xong
        final MouthProcedure mouthProcedure = mouthProcedureOnlineCubit.state;

        final logicIsDone =
            MouthFastInsulinIsDone(mouthProcedure: mouthProcedure);

        if (mouthProcedureOnlineCubit.state.isFull50 &&
            logicIsDone.isMealDone) {
          mouthProcedureOnlineCubit
              .updateProcedureStatus(MouthProcedureStatus.endocrineConference);
        }
        return Column(
          children: [
            Text('Acute Hyper Glycemia'),
            MouthSlowInsulin(
                mouthProcedureOnlineCubit: mouthProcedureOnlineCubit),
            MouthFastInsulin(
                mouthProcedureOnlineCubit: mouthProcedureOnlineCubit),
            //  MouthMeal(mouthProcedureOnlineCubit: mouthProcedureOnlineCubit),
          ],
        );
      },
    );
  }
}
