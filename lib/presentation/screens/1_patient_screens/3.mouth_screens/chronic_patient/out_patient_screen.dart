import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/third_ask_logic/inpatient_or_outpatient_ask_block.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/2_nice_button.dart';
import 'package:diabetichero_app/presentation/widgets/status/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class OutPatientScreen extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;

  const OutPatientScreen({super.key, required this.mouthProcedureOnlineCubit});

  @override
  Widget build(BuildContext context) {
    return Text('Điều trị ngoại trú theo hưóng dẫn của bác sĩ');
  }
}
