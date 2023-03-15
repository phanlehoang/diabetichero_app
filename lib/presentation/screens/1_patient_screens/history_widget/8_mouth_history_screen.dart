//tao 1 trang history có attribute la MouthProcedureOnlineCubit

//import material
import 'package:diabetichero_app/data/models/0.medical/4_regimen.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/history_widget/7_glucose_chart_widget.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/history_widget/nice_date_time.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/3.mouth/2.mouth_procedure.dart';
import '../../../../data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import '../../../widgets/nice_widgets/6_nice_item.dart';
import '../../../widgets/nice_widgets/nice_export.dart';
import '7.1_glucose_extract.dart';
import 'medical_action_item.dart';
import 'regimen_item.dart';

class MouthHistoryScreen extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const MouthHistoryScreen({
    super.key,
    required this.mouthProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: NiceInternetScreen(
        child: BlocBuilder(
            bloc: mouthProcedureOnlineCubit,
            builder: (context, state) {
              final st = mouthProcedureOnlineCubit.state;
              String first = NiceDateTime.dayMonthYear(st.beginTime);
              String last = NiceDateTime.dayMonthYear(st.lastTime);
              return NiceInternetScreen(
                child: Column(
                  children: [
                    //tat ca regimen
                    NiceContainer(
                        child: Column(
                      children: [
                        MouthProcedure.officialName,
                        Text(' $first - $last'),
                        Text(
                            'Cân nặng bệnh nhân: ${mouthProcedureOnlineCubit.profile.weight} kg'),
                        //Text('debug Mouths: ${st.toString()}'),
                      ],
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    GlucoseChartWidget(
                        medicalCheckGlucoses:
                            GlucoseExtract.fromMedicalProcedure(st)),
                    for (var regimen
                        in mouthProcedureOnlineCubit.state.regimens.reversed)
                      RegimenItem(regimen: regimen),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
