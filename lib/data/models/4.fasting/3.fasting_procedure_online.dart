import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/enums.dart';
import '../0.medical/4_regimen.dart';
import '../manager/2_profile.dart';
import '../0.medical/6_procedure_state.dart';
import '../0.medical/7.1_medical_procedure_cubit.dart';
import '2.fasting_procedure.dart';

class FastingProcedureOnlineCubit extends MedicalProcedureCubit {
  late StreamSubscription? regimensSubscription;
  late StreamSubscription? procedureStateSubscription;

  FastingProcedureOnlineCubit({
    required Profile profile,
    required String procedureId,
  }) : super(
          profile: profile,
          procedureId: procedureId,
        ) {
    regimensSubscription =
        procedureRef.collection('regimens').snapshots().listen((event) {
      List<Regimen> regimens = [];
      List<dynamic> list = event.docs.map((e) => e.data()).toList();
      for (dynamic x in list) {
        regimens.add(Regimen.fromMap(x));
      }
      emit(FastingProcedure(
        beginTime: state.beginTime,
        state: state.state,
        regimens: regimens,
      ));
    });
    procedureStateSubscription = procedureRef.snapshots().listen((event) {
      //event error
      if (event.data() == null) {
        emit(FastingProcedure(
          beginTime: state.beginTime,
          state: ProcedureState(
            status: ProcedureStatus.firstAsk,
          ),
          regimens: state.regimens,
        ));
        return;
      }
      ProcedureState FastingState =
          ProcedureState.fromMap(event.data() as Map<String, dynamic>);
      emit(FastingProcedure(
        beginTime: state.beginTime,
        state: FastingState,
        regimens: state.regimens,
      ));
    });
  }
  //emit
  @override
  Future<void> close() {
    regimensSubscription?.cancel();
    procedureStateSubscription?.cancel();
    return super.close();
  }
}

//init
FastingProcedure FastingProcedureOnlineInitial() {
  return FastingProcedure(
    status: 'Đang tải',
    beginTime: DateTime.now(),
    state: ProcedureState(
      status: ProcedureStatus.firstAsk,
    ),
    regimens: [],
  );
}
