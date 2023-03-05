import 'package:diabetichero_app/data/models/2.TPN/3_TPN_procedure_online_cubit.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/medical_blocs/sonde_blocs/choose_slow_insulin_form_bloc.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/2_nice_button.dart';
import 'package:diabetichero_app/presentation/widgets/status/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../../data/models/enum/enums.dart';
import '../../../../widgets/nice_widgets/1_nice_container.dart';
import 'give_lantus.dart';

class TPNSlowInsulinWidget extends StatelessWidget {
  final TPNProcedureOnlineCubit procedureOnlineCubit;
  const TPNSlowInsulinWidget({
    Key? key,
    required this.procedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleContainer(
      child: Column(
        children: [
          //   Text('Tiem cham'),
          BlocBuilder(
              bloc: procedureOnlineCubit,
              builder: (ct, st) {
                switch (procedureOnlineCubit.state.state.slowInsulinType) {
                  case InsulinType.Lantus:
                    return GiveLantus(
                      tpnProcedureOnlineCubit: procedureOnlineCubit,
                    );
                  default:
                    return Text('Chua biet');
                }
              })
        ],
      ),
    );
  }
}
