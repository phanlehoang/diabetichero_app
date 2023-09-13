import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetichero_app/data/models/0.medical/medical_action/3_medical_take_insulin.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class FastCheckedInsulinSubmit extends FormBloc<String, String> {
  final MedicalTakeInsulin medicalTakeInsulin;
  num plus;
  final procedureOnlineCubit;

  FastCheckedInsulinSubmit({
    required this.procedureOnlineCubit,
    required this.medicalTakeInsulin,
    this.plus: 0,
  });
  @override
  Future<void> onSubmitting() async {
    try {
      procedureOnlineCubit.addMedicalAction(medicalTakeInsulin);
      final profile = procedureOnlineCubit.profile;
      if (plus != 0)
        var updateBonus = await FirebaseFirestore.instance
            .collection('groups')
            .doc(profile.room)
            .collection('patients')
            .doc(profile.id)
            .collection('procedures')
            .doc(procedureOnlineCubit.procedureId)
            .update({'bonusInsulin': FieldValue.increment(plus)});
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    emitSuccess();
  }
}
