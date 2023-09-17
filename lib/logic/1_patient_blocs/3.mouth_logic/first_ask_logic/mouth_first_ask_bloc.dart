//tao mouth first ask bloc từ form bloc
import 'package:diabetichero_app/data/models/3.mouth/1.mouth_regimen.dart';
import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'acute_hyper_glycemia_check.dart';

class MouthFirstAskBloc extends FormBloc<String, String> {
  //cubit
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  //field bloc
  final fastingGlucose = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final casualGlucose = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final hba1c = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final thirsty = BooleanFieldBloc(
    // validators: [FieldBlocValidators.required],
    initialValue: false,
  );
  final polyuria = BooleanFieldBloc(
    // validators: [FieldBlocValidators.required],
    initialValue: false,
  );
  final polydipsia = BooleanFieldBloc();
  final weightLoss = BooleanFieldBloc();

  MouthFirstAskBloc({required this.mouthProcedureOnlineCubit}) {
    addFieldBlocs(
      fieldBlocs: [
        fastingGlucose,
        casualGlucose,
        hba1c,
        thirsty,
        polyuria,
        polydipsia,
        weightLoss,
      ],
    );
  }

  @override
  void onSubmitting() async {
    AcuteHyperGlycemiaCheck acuteHyperGlycemiaCheck = AcuteHyperGlycemiaCheck(
      fastingGlucose: num.parse(fastingGlucose.value),
      casualGlucose: num.parse(casualGlucose.value),
      hba1c: num.parse(hba1c.value),
      thirsty: thirsty.value,
      polyuria: polyuria.value,
      polydipsia: polydipsia.value,
      weightLoss: weightLoss.value,
    );
    try {
      if (acuteHyperGlycemiaCheck.isAcuteHyperGlycemia) {
        //b1: tạo regimen acute hyper glycemia
        MouthRegimen mouthRegimen = MouthRegimen(
          name: 'acuteHyperglycemia',
          beginTime: DateTime.now(),
          weight: mouthProcedureOnlineCubit.profile.weight,
          symptoms: acuteHyperGlycemiaCheck.toMap(),
          medicalActions: [],
          healthConditions: [],
        );
        //b2: gửi regimen acute hyper glycemia lên server
        mouthProcedureOnlineCubit.addMouthRegimen(mouthRegimen);
        mouthProcedureOnlineCubit
            .updateProcedureStatus(MouthProcedureStatus.acuteHyperglycemia);

        emitSuccess();
      } else {
        mouthProcedureOnlineCubit
            .updateProcedureStatus(MouthProcedureStatus.secondAsk);

        emitSuccess();
      }
    } catch (e) {
      emitFailure();
    }
  }
}
