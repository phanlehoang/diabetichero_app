import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/medical/medical_action/3_medical_take_insulin.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'acute_hyper_glycemia_logic/mouth_fast_insulin_guide.dart';
import 'acute_hyper_glycemia_logic/mouth_slow_insulin_guide.dart';

class MouthTakeFastInsulinBloc extends FormBloc<String, String> {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  final logicGuide;
  final insulinUI = TextFieldBloc();
  final insulinType = SelectFieldBloc(
    items: ['Actrapid', 'NovoRapid'],
    // validators: [FieldBlocValidators.required],
  );

  MouthTakeFastInsulinBloc(
      {required this.logicGuide, required this.mouthProcedureOnlineCubit}) {
    addFieldBlocs(
      fieldBlocs: [
        insulinUI,
        insulinType,
      ],
    );
  }
  //submit
  @override
  void onSubmitting() async {
    try {
      //b1: update medicalTakeInsulin
      final mouthProcedure = mouthProcedureOnlineCubit.state;
      MedicalTakeInsulin medicalTakeInsulin =
          logicGuide.medicalTakeInsulinGuide;
      medicalTakeInsulin.insulinUI = num.tryParse(insulinUI.value) != null
          ? num.parse(insulinUI.value)
          : medicalTakeInsulin.insulinUI;
      dynamic insulinTypeString =
          insulinType.value != null ? insulinType.value : 'Fast';
      medicalTakeInsulin.insulinType =
          StringToEnum.stringToInsulinType(insulinTypeString);

      //b2: update database
      await mouthProcedureOnlineCubit.addMedicalAction(medicalTakeInsulin);
      //b3: update UI
      emitSuccess();
    } catch (e) {
      emitFailure();
    }
  }
}
