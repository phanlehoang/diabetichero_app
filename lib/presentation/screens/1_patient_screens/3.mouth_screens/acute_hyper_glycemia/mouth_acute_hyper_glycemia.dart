import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/acute_hyper_glycemia/mouth_fast_insulin.dart';
import 'package:flutter/material.dart';

import 'mouth_slow_insulin/mouth_slow_insulin.dart';

class MouthAcuteHyperGlycemia extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const MouthAcuteHyperGlycemia({
    super.key,
    required this.mouthProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('acute hyper glycemia'),
        MouthSlowInsulin(mouthProcedureOnlineCubit: mouthProcedureOnlineCubit),
        MouthFastInsulin(mouthProcedureOnlineCubit: mouthProcedureOnlineCubit),
      ],
    );
  }
}
