//taạo mouth screen gioôống sonde screen
import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/3.mouth_screens/1_mouth_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../../../../data/models/3.mouth/2.mouth_procedure.dart';
import '../../../widgets/images/doctor_image.dart';

class MouthScreen extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const MouthScreen({
    super.key,
    required this.mouthProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MouthProcedure.officialName,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DoctorImage(),
            //button to history
            NiceButtons(
              onTap: (f) {},
              stretch: false,
              width: 50,
              endColor: Colors.yellow,
              startColor: Colors.yellow.shade200,
              // tạo icon history
              child: Icon(Icons.history),
            ),
          ],
        ),
        //in ra trạng thái của bệnh nhân
        // BlocBuilder(
        //     bloc: mouthProcedureOnlineCubit,
        //     builder: (ct, state) {
        //       return Text(
        //         'Trạng thái: ${mouthProcedureOnlineCubit.state.toString()}',
        //       );
        //     }),
        MouthStatusWidget(mouthProcedureOnlineCubit: mouthProcedureOnlineCubit)
      ],
    );
  }
}
