import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../../data/models/3.mouth/4.mouth_procedure_online_cubit.dart';

class MouthFastInsulin extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const MouthFastInsulin({super.key, required this.mouthProcedureOnlineCubit});
  @override
  Widget build(BuildContext context) {
    return Text('Tiêm nhanh');
  }
}
