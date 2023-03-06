import 'package:diabetichero_app/data/models/medical/medical_action/2.1_medical_mixing.dart';
import 'package:diabetichero_app/data/models/medical/medical_action/4_medical_meal.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/medical/medical_action/2_medical_check_glucose.dart';
import '../../../../data/models/medical/medical_action/3_medical_take_insulin.dart';
import '../../../widgets/nice_widgets/nice_export.dart';
import 'medical_check_glucose_item.dart';
import 'medical_meal_item.dart';
import 'medical_mixing_item.dart';
import 'medical_take_insulin_item.dart';

class MedicalActionItem extends StatelessWidget {
  final medicalAction;
  const MedicalActionItem({
    Key? key,
    required this.medicalAction,
  }) : super(key: key);
  //build
  @override
  Widget build(BuildContext context) {
    switch (medicalAction.runtimeType) {
      case MedicalCheckGlucose:
        return MedicalCheckGlucoseItem(medicalCheckGlucose: medicalAction);
      case MedicalTakeInsulin:
        return MedicalTakeInsulinItem(medicalTakeInsulin: medicalAction);
      case MedicalMixing:
        return MedicalMixingItem(medicalMixing: medicalAction);
      case MedicalMeal:
        return MedicalMealItem(medicalMeal: medicalAction);
      default:
        return Text('chua lam');
    }
  }
}
