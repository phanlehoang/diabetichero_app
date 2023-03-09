import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/mouth_meal_range.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_fast_insulin_guide.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/1.sonde_screens/sonde_fast_insulin/2_1_1_check_glucose_widget.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/acute_hyper_glycemia/mouth_fast_insulin/mouth_real_fast_insulin.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/acute_hyper_glycemia/mouth_meal/mouth_meal.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/1_nice_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/3.mouth/2.mouth_procedure.dart';
import '../../../../../../data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import '../../../../../../data/models/time_controller/4_mouth_range/4_mouth_range.dart';
import '../../../../../../logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_fast_insulin_logic.dart';
import '../../../../../../logic/status_cubit/time_check/time_check_cubit.dart';
import 'mouth_guide_fast_insulin.dart';

class InFastMouthRangeCubit extends Cubit<int?> {
  InFastMouthRangeCubit()
      : super(MouthMealRange().rangeContain(DateTime.now()));
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
          // Text('Tiêm nhanh'),
          BlocBuilder<TimeCheckCubit, int>(
            builder: (context, state) {
              int? index = MouthMealRange().rangeContain(DateTime.now());
              inFastMouthRangeCubit.emit(index);
              return Container();
            },
          ),
          BlocBuilder(
            bloc: inFastMouthRangeCubit,
            builder: (context, state) {
              if (state == null) {
                return Text(MouthMealRange().waitingMessage(DateTime.now()));
              }
              String morning = 'sáng';
              switch (state) {
                case 0:
                  morning = 'sáng';
                  break;
                case 1:
                  morning = 'trưa';
                  break;
                case 2:
                  morning = 'chiều';
                  break;
                default:
              }
              final MouthProcedure mouthProcedure =
                  mouthProcedureOnlineCubit.state;

              final logic =
                  MouthFastInsulinLogic(mouthProcedure: mouthProcedure);

              if (logic.isMealDone)
                return Column(
                  children: [
                    Text(MouthMealRange().waitingMessage(DateTime.now())),
                  ],
                );
              if (logic.isFastInsulinDone)
                return MouthMeal(
                  mouthProcedureOnlineCubit: mouthProcedureOnlineCubit,
                );
              if (logic.isGlucoseDone) {
                return Column(
                  children: [
                    //Mouth Guide
                    Text(
                        'Bạn phải tiêm insulin trước bữa $morning 10-30 phút.'),

                    MouthGuideFastInsulin(
                      mouthProcedureOnlineCubit: mouthProcedureOnlineCubit,
                    ),
                    MouthRealFastInsulin(
                      logicGuide: MouthFastInsulinGuide(
                        mouthProcedureOnlineCubit.state,
                      ),
                      mouthProcedureOnlineCubit: mouthProcedureOnlineCubit,
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  Text('Bạn phải tiêm insulin trước bữa $morning 10-30 phút.'),
                  CheckGlucoseWidget(
                    procedureOnlineCubit: mouthProcedureOnlineCubit,
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
