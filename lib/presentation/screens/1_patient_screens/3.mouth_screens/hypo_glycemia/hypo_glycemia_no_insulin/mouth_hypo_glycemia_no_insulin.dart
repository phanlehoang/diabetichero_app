import 'package:diabetichero_app/data/models/3.mouth/2.mouth_procedure.dart';
import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/day_segment_range.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/hypo_glycemia_logic/hypo_glycemia_no_insulin_logic.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/1.sonde_screens/sonde_fast_insulin/2_1_1_check_glucose_widget.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/1_nice_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MouthHypoGlycemiaNoInsulin extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  MouthHypoGlycemiaNoInsulin({
    super.key,
    required this.mouthProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleScreen(
      child: Column(
        children: [
          //Text bôi đậm: Phác đồ dành cho bệnh nhân có nguy cơ hđh, ĐTĐ tuyp 2
          Center(
            child: Text(
              mouthProcedureOnlineCubit.state.regimens.last.name,
              textAlign: TextAlign.center, //center
            ),
          ),
          Center(
            child: Text('Ngừng thuốc'),
          ),
          SimpleContainer(
            child: BlocBuilder(
              bloc: mouthProcedureOnlineCubit,
              builder: (ct, st) {
                final MouthProcedure mouthProcedure = st as MouthProcedure;
                final logic = HypoGlycemiaNoInsulinLogic(mouthProcedure);
                if (logic.isDone) {
                  return Column(
                    children: [
                      Text('Đã xong'),
                      Text(DaySegmentRange().waitingMessage(DateTime.now())),
                    ],
                  );
                }
                if (logic.isFull50) {
                  mouthProcedureOnlineCubit.updateProcedureStatus(
                      MouthProcedureStatus.endocrineConference);
                }
                return CheckGlucoseWidget(
                  procedureOnlineCubit: mouthProcedureOnlineCubit,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
