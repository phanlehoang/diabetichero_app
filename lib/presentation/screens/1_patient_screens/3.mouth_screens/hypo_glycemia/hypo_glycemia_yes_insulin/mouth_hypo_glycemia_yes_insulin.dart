import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/day_segment_range.dart';
import 'package:diabetichero_app/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/hypo_glycemia/hypo_glycemia_yes_insulin/mouth_hypo_glycemia_yes_insulin_middle.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/nice_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mouth_hypo_glycemia_yes_insulin_morning.dart';
import 'mouth_hypo_glycemia_yes_insulin_night.dart';

class MouthHypoGlycemiaYesInsulin extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  final Cubit<int?> currentRangeCubit;
  const MouthHypoGlycemiaYesInsulin({
    super.key,
    required this.mouthProcedureOnlineCubit,
    required this.currentRangeCubit,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleContainer(
      child: Column(
        children: [
          BlocBuilder<TimeCheckCubit, int>(
            builder: (context, state) {
              currentRangeCubit
                  .emit(DaySegmentRange().rangeContain(DateTime.now()));
              return Container();
            },
          ),
          BlocBuilder(
              bloc: currentRangeCubit,
              builder: (ct, st) {
                int? currentRange = st as int?;
                switch (currentRange) {
                  case null:
                    return Text(
                        DaySegmentRange().waitingMessage(DateTime.now()));
                  case 0:
                    //breakfast
                    return Column(
                      children: [
                        Text('Bạn cần tiêm insulin trước bữa sáng 30-45 phút.'),
                        MouthHypoGlycemiaYesInsulinMorning(
                          mouthProcedureOnlineCubit: mouthProcedureOnlineCubit,
                        ),
                      ],
                    );
                  case 3:
                    //night
                    return Column(
                      children: [
                        Text('Đo đường huyết'),
                        MouthHypoGlycemiaYesInsulinNight(
                            mouthProcedureOnlineCubit:
                                mouthProcedureOnlineCubit),
                      ],
                    );
                  default:
                    return Column(
                      children: [
                        Text(
                            'Nếu tiêm insulin thì bạn phải chờ 10-30 phút sau khi tiêm để bắt đầu bữa ăn.'),
                        MouthHypoGlycemiaYesInsulinMiddle(
                            mouthProcedureOnlineCubit:
                                mouthProcedureOnlineCubit),
                      ],
                    );
                }
              }),
        ],
      ),
    );
  }
}
