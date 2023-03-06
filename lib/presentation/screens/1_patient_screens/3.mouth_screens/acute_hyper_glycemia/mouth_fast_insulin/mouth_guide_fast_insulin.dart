import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import '../../../../../../logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_fast_insulin_guide.dart';
import '../../../../../../logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_slow_insulin_guide.dart';

class MouthGuideFastInsulin extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const MouthGuideFastInsulin({
    super.key,
    required this.mouthProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: mouthProcedureOnlineCubit,
        builder: (context, state) {
          final logicInsulin =
              MouthFastInsulinGuide(mouthProcedureOnlineCubit.state);

          return Column(
            children: [
              Text('Hướng dẫn tiêm'),
              logicInsulin.guide,
            ],
          );
        });
  }
}
