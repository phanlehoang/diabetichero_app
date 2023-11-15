//tao form dien hoi co bi benh hypo_glycemia hay khong

import 'package:diabetichero_app/data/models/3.mouth/1.mouth_regimen.dart';
import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/second_ask_logic/hypo_glycemia_check.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class MouthSecondAskBloc extends FormBloc<String, String> {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  //1 list boolean field bloc từ hypo_glycemia_check

  // bool dialysis;
  // bool cirrhosis; //xo gan
  // bool metastaticCancer; //ung thư di can
  // bool heartFailureHyperTension; //suy tim xung huyết
  // bool stroke;
  // bool alcoholicDementia; //sang rượu
  // bool otherSeriousDisease;
  final cognitiveImpairment = BooleanFieldBloc();
  final dialysis = BooleanFieldBloc();
  final cirrhosis = BooleanFieldBloc();
  final metastaticCancer = BooleanFieldBloc();
  final heartFailureHyperTension = BooleanFieldBloc();
  final stroke = BooleanFieldBloc();
  final alcoholicDementia = BooleanFieldBloc();
  final otherSeriousDisease = BooleanFieldBloc();

  //5 bien con lai
  //bool bathDisfunction;
  // bool dressingDisfunction;
  // bool personalHygieneDisfunction;
  // bool eatingDisfunction;
  // bool mobileDisfunction;
  final bathDisfunction = BooleanFieldBloc();
  final dressingDisfunction = BooleanFieldBloc();
  final personalHygieneDisfunction = BooleanFieldBloc();
  final eatingDisfunction = BooleanFieldBloc();
  final mobileDisfunction = BooleanFieldBloc();

  MouthSecondAskBloc({required this.mouthProcedureOnlineCubit}) {
    addFieldBlocs(fieldBlocs: [
      dialysis,
      cirrhosis,
      metastaticCancer,
      heartFailureHyperTension,
      stroke,
      alcoholicDementia,
      otherSeriousDisease,
      cognitiveImpairment,
      bathDisfunction,
      dressingDisfunction,
      personalHygieneDisfunction,
      eatingDisfunction,
      mobileDisfunction,
    ]);
  }
  //submit
  @override
  void onSubmitting() async {
    final hypoGlycemiaCheck = HypoGlycemiaCheck(
      dialysis: dialysis.value,
      cirrhosis: cirrhosis.value,
      metastaticCancer: metastaticCancer.value,
      heartFailureHyperTension: heartFailureHyperTension.value,
      stroke: stroke.value,
      alcoholicDementia: alcoholicDementia.value,
      otherSeriousDisease: otherSeriousDisease.value,
      cognitiveImpairment: cognitiveImpairment.value,
      bathDisfunction: bathDisfunction.value,
      dressingDisfunction: dressingDisfunction.value,
      personalHygieneDisfunction: personalHygieneDisfunction.value,
      eatingDisfunction: eatingDisfunction.value,
      mobileDisfunction: mobileDisfunction.value,
    );
    if (hypoGlycemiaCheck.ishypoGlycemiaRisk) {
      MouthRegimen mouthRegimen = MouthRegimen(
        name: 'Hypo Glycemia',
        beginTime: DateTime.now(),
        weight: mouthProcedureOnlineCubit.profile.weight,
        symptoms: hypoGlycemiaCheck.toMap(),
        medicalActions: [],
        healthConditions: [], status: MouthProcedureStatus.hypoGlycemia ,
      );
      //b2: gửi regimen acute hyper glycemia lên server
      mouthProcedureOnlineCubit.addMouthRegimen(mouthRegimen);
      mouthProcedureOnlineCubit
          .updateProcedureStatus(MouthProcedureStatus.hypoGlycemia);

      emitSuccess();
    } else {
      mouthProcedureOnlineCubit
          .updateProcedureStatus(MouthProcedureStatus.thirdAsk);
      emitSuccess();
    }

    emitSuccess();
  }
}
