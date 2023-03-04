import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetichero_app/data/models/medical/2_medical_check_glucose.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../data/models/models_export.dart';

class CheckGlucoseForm extends FormBloc<String, String> {
  @override
  void emit(dynamic state) {
    try {
      super.emit(state);
    } catch (e) {
      if (e == StateError('Cannot emit new states after calling close')) {
        return;
      }
    }
  }

  final procedureOnlineCubit;
  final glucose = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  CheckGlucoseForm({
    required this.procedureOnlineCubit,
  }) {
    addFieldBlocs(
      fieldBlocs: [
        glucose,
      ],
    );
  }
  @override
  Future<void> onSubmitting() async {
    MedicalCheckGlucose medicalCheckGlucose = MedicalCheckGlucose(
      time: DateTime.now(),
      glucoseUI: num.parse(glucose.value),
    );

    try {
      await procedureOnlineCubit.addMedicalAction(medicalCheckGlucose);
    } catch (e) {
      emitFailure(failureResponse: e.toString());
      return;
    }
    emitSuccess();
  }
}
