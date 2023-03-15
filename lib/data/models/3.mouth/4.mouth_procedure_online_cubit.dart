import 'dart:async';

import '../manager/2_profile.dart';
import '../enum/enums.dart';
import '1.mouth_regimen.dart';
import '2.mouth_procedure.dart';
import '3.mouth_procedure_cubit.dart';

class MouthProcedureOnlineCubit extends MouthProcedureCubit {
  late StreamSubscription? regimensSubscription;
  late StreamSubscription? procedureStateSubscription;

  MouthProcedureOnlineCubit({
    required Profile profile,
    required String procedureId,
  }) : super(
          profile: profile,
          procedureId: procedureId,
        ) {
    regimensSubscription =
        procedureRef.collection('regimens').snapshots().listen((event) {
      List<MouthRegimen> regimens = [];
      List<dynamic> list = event.docs.map((e) => e.data()).toList();
      for (dynamic x in list) {
        regimens.add(MouthRegimen.fromMap(x));
      }
      emit(MouthProcedure(
        beginTime: state.beginTime,
        status: state.status,
        regimens: regimens,
        name: state.name,
      ));
    });
    procedureStateSubscription = procedureRef.snapshots().listen((event) {
      //event error
      final data = event.data() as Map<String, dynamic>;
      if (data == null) {
        emit(MouthProcedure(
          beginTime: state.beginTime,
          status: MouthProcedureStatus.loading,
          regimens: state.regimens,
          name: 'không có data',
        ));
        return;
      }
      MouthProcedureStatus status =
          StringToEnum.stringToMouthProcedureStatus(data['status']);
      emit(MouthProcedure(
        beginTime: state.beginTime,
        status: status,
        name: data['name'],
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
