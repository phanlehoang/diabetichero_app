import 'dart:async';

import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/medical/medical_action/4_medical_meal.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class MouthTakeMealBloc extends FormBloc<String, String> {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  final description = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  MouthTakeMealBloc({
    required this.mouthProcedureOnlineCubit,
  }) {
    addFieldBlocs(
      fieldBlocs: [
        description,
      ],
    );
  }

  @override
  FutureOr<void> onSubmitting() {
    try {
      MedicalMeal medicalMeal = MedicalMeal(
        description: description.value,
        time: DateTime.now(),
      );
      mouthProcedureOnlineCubit.addMedicalAction(medicalMeal);
    } catch (e) {}
  }
}
