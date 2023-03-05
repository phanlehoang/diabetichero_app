import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import '../../../../../../logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_slow_insulin_guide.dart';

class MouthGuideSlowInsulin extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const MouthGuideSlowInsulin({
    super.key,
    required this.mouthProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: mouthProcedureOnlineCubit,
        builder: (context, state) {
          num weight = mouthProcedureOnlineCubit.profile.weight;
          num insulin = MouthSlowInsulinGuide.insulinUI(weight);
          return Column(
            children: [
              Text('Hướng dẫn tiêm'),
              Text('Tiêm $insulin UI insulin chậm (lantus/levemir/Insulatard)'),
            ],
          );
        });
  }
}
