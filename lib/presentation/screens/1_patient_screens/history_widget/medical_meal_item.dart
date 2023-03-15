import 'package:diabetichero_app/data/models/0.medical/medical_action/2_medical_check_glucose.dart';
import 'package:diabetichero_app/data/models/0.medical/medical_action/4_medical_meal.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/history_widget/nice_date_time.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/enum/1_enum_to_string.dart';
import '../../../widgets/nice_widgets/nice_export.dart';

class MedicalMealItem extends StatelessWidget {
  final MedicalMeal medicalMeal;
  const MedicalMealItem({
    Key? key,
    required this.medicalMeal,
  }) : super(key: key);
  //build
  @override
  Widget build(BuildContext context) {
    DateTime t = medicalMeal.time;
    String hm = NiceDateTime.hourMinute(t);
    String d = NiceDateTime.dayMonth(t);
    return SimpleContainer(
      child: ListTile(
          title: Text('Ăn'),
          trailing: Column(
            children: [
              Text(d),
              Text(hm),
            ],
          )),
    );
  }
}
