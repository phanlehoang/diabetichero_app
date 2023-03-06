import 'package:diabetichero_app/presentation/screens/1_patient_screens/1.sonde_screens/sonde_fast_insulin/2_1_1_check_glucose_widget.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/1_nice_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/3.mouth/2.mouth_procedure.dart';
import '../../../../../../data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import '../../../../../../data/models/time_controller/4_mouth_range.dart';
import '../../../../../../logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_fast_insulin_is_done.dart';
import '../../../../../../logic/status_cubit/time_check/time_check_cubit.dart';

class InFastMouthRangeCubit extends Cubit<int?> {
  InFastMouthRangeCubit()
      : super(MouthFastInsulinRange().rangeContain(DateTime.now()));
}

class MouthFastInsulin extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  final InFastMouthRangeCubit inFastMouthRangeCubit = InFastMouthRangeCubit();
  MouthFastInsulin({super.key, required this.mouthProcedureOnlineCubit});
  @override
  Widget build(BuildContext context) {
    return SimpleContainer(
      child: Column(
        children: [
          Text('Tiêm nhanh'),
          BlocBuilder<TimeCheckCubit, int>(
            builder: (context, state) {
              int? index = MouthFastInsulinRange().rangeContain(DateTime.now());
              inFastMouthRangeCubit.emit(index);
              return Container();
            },
          ),
          BlocBuilder(
            bloc: inFastMouthRangeCubit,
            builder: (context, state) {
              if (state == null) {
                return Text(
                    MouthFastInsulinRange().waitingMessage(DateTime.now()));
              }
              final MouthProcedure mouthProcedure =
                  mouthProcedureOnlineCubit.state;

              final logicIsDone =
                  MouthFastInsulinIsDone(mouthProcedure: mouthProcedure);

              if (logicIsDone.isDone)
                return Column(
                  children: [
                    Text(
                        MouthFastInsulinRange().waitingMessage(DateTime.now())),
                  ],
                );
              if (logicIsDone.isGlucoseDone) {
                return Column(
                  children: [
                    Text('nhập insulin'),
                  ],
                );
              }

              return Column(
                children: [
                  Text('nhập glucose'),
                  CheckGlucoseWidget(
                    procedureOnlineCubit: mouthProcedureOnlineCubit,
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
