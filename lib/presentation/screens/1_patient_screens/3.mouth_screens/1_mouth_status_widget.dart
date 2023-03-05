import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/3.mouth/2.mouth_procedure.dart';

class MouthStatusWidget extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const MouthStatusWidget({
    super.key,
    required this.mouthProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: mouthProcedureOnlineCubit,
      builder: (context, state) {
        final st = state as MouthProcedure;
        switch (st.status) {
          case MouthProcedureStatus.firstAsk:
            return Text('firstAsk');

          default:
            return Text('chua lam');
        }
      },
    );
  }
}
