import 'package:diabetichero_app/data/models/3.mouth/2.mouth_procedure.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_slow_insulin_guide.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_slow_insulin_logic.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/mouth_take_slow_insulin_bloc.dart';
import 'package:diabetichero_app/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/1.sonde_screens/sonde_fast_insulin/2_1_1_check_glucose_widget.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/1_nice_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import mouth range
//import 'C:\Users\HoangPhan\Desktop\test\diabetichero_app\lib\data\models\time_controller\4_mouth_range.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/4_mouth_range.dart';
import '../../../../../../data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'mouth_guide_slow_insulin.dart';
import 'mouth_real_slow_insulin.dart';

class InSlowMouthRangeCubit extends Cubit<int?> {
  InSlowMouthRangeCubit()
      : super(MouthSlowInsulinRange().rangeContain(DateTime.now()));
}

class MouthSlowInsulin extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  final InSlowMouthRangeCubit inSlowMouthRangeCubit = InSlowMouthRangeCubit();
  MouthSlowInsulin({
    super.key,
    required this.mouthProcedureOnlineCubit,
  });
  @override
  Widget build(BuildContext context) {
    return SimpleContainer(
      child: Column(
        children: [
          BlocBuilder<TimeCheckCubit, int>(
            builder: (context, state) {
              int? index = MouthSlowInsulinRange().rangeContain(DateTime.now());
              inSlowMouthRangeCubit.emit(index);
              return Container();
            },
          ),
          BlocBuilder(
            bloc: inSlowMouthRangeCubit,
            builder: (context, state) {
              if (state == null) {
                return Text(
                    MouthSlowInsulinRange().waitingMessage(DateTime.now()));
              }
              final MouthProcedure mouthProcedure =
                  mouthProcedureOnlineCubit.state;
              final logic =
                  MouthSlowInsulinLogic(mouthProcedure: mouthProcedure);
              if (logic.isDone)
                return Column(
                  children: [
                    //in ra các regimen của mouth procedure đang được thực hiện
                    // Text(mouthProcedure.regimens.toString()),
                    // Text(MouthSlowInsulinIsDone(mouthProcedure: mouthProcedure)
                    //     .lastSlowInsulinTime
                    //     .toString()),
                    Text(
                        MouthSlowInsulinRange().waitingMessage(DateTime.now())),
                  ],
                );

              if (logic.isGlucoseDone)
                return Column(
                  children: [
                    Text(MouthSlowInsulinLogic(mouthProcedure: mouthProcedure)
                        .lastSlowInsulinTime
                        .toString()),
                    MouthGuideSlowInsulin(
                      mouthProcedureOnlineCubit: mouthProcedureOnlineCubit,
                    ),
                    MouthRealSlowInsulin(
                      mouthProcedureOnlineCubit: mouthProcedureOnlineCubit,
                    ),
                  ],
                );
              return Column(
                children: [
                  //check glucose
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
