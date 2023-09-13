import 'dart:async';

import 'package:diabetichero_app/data/models/4.fasting/3.fasting_procedure_online.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';

class ChooseSlowInsulinFastingFormBloc extends FormBloc<String, String> {
  final FastingProcedureOnlineCubit fastingProcedureOnlineCubit;
  final slowInsulin = SelectFieldBloc(
    items: ['NPH', 'Glargine'],
    validators: [VietnameseFieldBlocValidators.required],
  );
  //add field bloc
  @override
  ChooseSlowInsulinFastingFormBloc({
    required this.fastingProcedureOnlineCubit,
  }) {
    addFieldBlocs(fieldBlocs: [
      slowInsulin,
    ]);
  }

  @override
  Future<void> onSubmitting() async {
    try {
      await fastingProcedureOnlineCubit.procedureRef.update({
        'slowInsulinType': slowInsulin.value,
      });
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    emitSuccess();
  }
}
