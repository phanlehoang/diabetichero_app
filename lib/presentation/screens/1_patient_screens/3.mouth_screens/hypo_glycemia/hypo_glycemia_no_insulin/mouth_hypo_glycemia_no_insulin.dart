import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MouthHypoGlycemiaNoInsulin extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  MouthHypoGlycemiaNoInsulin({
    super.key,
    required this.mouthProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('BN không tiêm insulin'),
      ],
    );
  }
}
