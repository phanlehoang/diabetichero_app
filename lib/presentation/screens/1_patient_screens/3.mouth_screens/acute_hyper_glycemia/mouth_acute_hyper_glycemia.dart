import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:flutter/material.dart';

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
    return Column(
      children: [
        Text('acute hyper glycemia'),
        MouthSlowInsulin(mouthProcedureOnlineCubit: mouthProcedureOnlineCubit),
        MouthFastInsulin(mouthProcedureOnlineCubit: mouthProcedureOnlineCubit),
      ],
    );
  }
}
