//lam trang hoi chan noi tiet
import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/0.medical/medical_action/3_medical_take_insulin.dart';
import 'package:flutter/material.dart';

class EndocrineConferenceScreen extends StatelessWidget {
  //them procedure online cubit
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const EndocrineConferenceScreen({
    Key? key,
    required this.mouthProcedureOnlineCubit,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('hoi chan noi tiet'),
        //tao nut bam
        Text('Tiep tuc dieu tri benh nhan'),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: Text('Co')),
            SizedBox(
              width: 20,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Khong')),
          ],
        ),
      ],
    );
  }
}
