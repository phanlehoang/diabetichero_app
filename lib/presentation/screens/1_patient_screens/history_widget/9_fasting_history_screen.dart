//tao 1 trang history có attribute la FastingProcedureOnlineCubit

//import material
import 'package:diabetichero_app/data/models/0.medical/4_regimen.dart';
import 'package:diabetichero_app/data/models/4.fasting/3.fasting_procedure_online.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/history_widget/7_glucose_chart_widget.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/history_widget/nice_date_time.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/4.fasting/2.fasting_procedure.dart';

import '../../../../data/models/4.fasting/3.fasting_procedure_online.dart';
import '../../../widgets/nice_widgets/6_nice_item.dart';
import '../../../widgets/nice_widgets/nice_export.dart';
import '7.1_glucose_extract.dart';
import 'medical_action_item.dart';
import 'regimen_item.dart';

class FastingHistoryScreen extends StatelessWidget {
  final FastingProcedureOnlineCubit fastingProcedureOnlineCubit;
  const FastingHistoryScreen({
    super.key,
    required this.fastingProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: NiceInternetScreen(
        child: BlocBuilder(
            bloc: fastingProcedureOnlineCubit,
            builder: (context, state) {
              final st = fastingProcedureOnlineCubit.state;
              String first = NiceDateTime.dayMonthYear(st.beginTime);
              String last = NiceDateTime.dayMonthYear(st.lastTime);
              return NiceInternetScreen(
                child: Column(
                  children: [
                    //tat ca regimen
                    NiceContainer(
                        child: Column(
                      children: [
                        FastingProcedure.officialName,
                        Text(' $first - $last'),
                        Text('Cân nặng bệnh nhân: ${st.state.weight} kg'),
                        //Text('debug Fastings: ${st.toString()}'),
                      ],
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    GlucoseChartWidget(
                        medicalCheckGlucoses:
                            GlucoseExtract.fromMedicalProcedure(st)),
                    for (var regimen
                        in fastingProcedureOnlineCubit.state.regimens.reversed)
                      RegimenItem(regimen: regimen),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
