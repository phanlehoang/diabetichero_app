import 'package:diabetichero_app/presentation/screens/1_patient_screens/4.fasting_screen/fasting_slow_insulin/4.0_fast_ask_slow_insulin.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/4.fasting_screen/fasting_slow_insulin/4.1_fast_give_NPH.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/4.fasting_screen/fasting_slow_insulin/4.2_fast_give_Glargine.dart';

import 'package:diabetichero_app/presentation/widgets/nice_widgets/2_nice_button.dart';
import 'package:diabetichero_app/presentation/widgets/status/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../../data/models/4.fasting/3.fasting_procedure_online.dart';
import '../../../../../data/models/enum/enums.dart';
import '../../../../widgets/nice_widgets/1_nice_container.dart';

class FastSlowInsulinWidget extends StatelessWidget {
  final FastingProcedureOnlineCubit fastingProcedureOnlineCubit;
  const FastSlowInsulinWidget({
    Key? key,
    required this.fastingProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleContainer(
      child: Column(
        children: [
          //  Text('Tiem cham'),
          BlocBuilder(
              bloc: fastingProcedureOnlineCubit,
              builder: (ct, st) {
                switch (
                    fastingProcedureOnlineCubit.state.state.slowInsulinType) {
                  case InsulinType.Unknown:
                    return Column(
                      children: [
                        Text('chọn loại insulin'),
                        FastingAskSlowInsulin(
                          fastingProcedureOnlineCubit:
                              fastingProcedureOnlineCubit,
                        ),
                      ],
                    );
                  case InsulinType.NPH:
                    return FastGiveNPH(
                      fastingProcedureOnlineCubit: fastingProcedureOnlineCubit,
                    );
                  case InsulinType.Glargine:
                    return FastGiveGlargine(
                        fastProcedureOnlineCubit: fastingProcedureOnlineCubit);
                  default:
                    return Text('Chua biet');
                }
              })
        ],
      ),
    );
  }
}
