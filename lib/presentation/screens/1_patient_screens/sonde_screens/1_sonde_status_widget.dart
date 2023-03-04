import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetichero_app/data/data_provider/sonde_provider/sonde_state_provider.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/1.sonde/7.2_sonde_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/1.sonde/sonde_lib.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/sonde_screens/2_0_firstAsk_widget.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/sonde_screens/sonde_fast_insulin/fast_insulin_widget.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/sonde_screens/sonde_slow_insulin/4_sonde_slow_insulin.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/2.3_current_profile_cubit.dart';
import '../../../../data/models/medical/7_medical_procedure.dart';
import '../../../../data/models/models_export.dart';
import '../../../../data/models/1.sonde/7_sonde_procedure.dart';
import '../../../widgets/nice_widgets/0.1_nice_internet_screen.dart';

class SondeStatusWidget extends StatelessWidget {
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  SondeStatusWidget({
    super.key,
    required this.sondeProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    final Profile profile = context.read<CurrentProfileCubit>().state;

    return NiceInternetScreen(
      child: Column(children: [
        BlocBuilder(
          bloc: sondeProcedureOnlineCubit,
          builder: (ct, st) {
            final SondeProcedure sondeProcedure = st as SondeProcedure;
            switch (sondeProcedure.state.status) {
              case ProcedureStatus.firstAsk:
                return FirstAskWidget(
                    procedureOnlineCubit: sondeProcedureOnlineCubit);
              case ProcedureStatus.noInsulin:
                return FastInsulinWidget(
                  sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
                );
              case ProcedureStatus.yesInsulin:
                return Column(
                  children: [
                    SlowInsulinWidget(
                      sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
                    ),
                    FastInsulinWidget(
                      sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
                    ),
                  ],
                );
              case ProcedureStatus.highInsulin:
                return Column(
                  children: [
                    SlowInsulinWidget(
                      sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
                    ),
                    FastInsulinWidget(
                      sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
                    ),
                  ],
                );
              case ProcedureStatus.finish:
                return Text('Chuyển sang phác đồ bơm điện');
              default:
                return Container();
            }
          },
        ),
      ]),
    );
  }
}
