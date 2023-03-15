//tao 1 trang history có attribute la sondeProcedureOnlineCubit

//import material
import 'package:diabetichero_app/data/models/0.medical/4_regimen.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/history_widget/7.1_glucose_extract.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/history_widget/7_glucose_chart_widget.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/history_widget/nice_date_time.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/1.sonde/7.2_sonde_procedure_online_cubit.dart';
import '../../../../data/models/1.sonde/7_sonde_procedure.dart';
import '../../../widgets/nice_widgets/6_nice_item.dart';
import '../../../widgets/nice_widgets/nice_export.dart';
import 'medical_action_item.dart';
import 'regimen_item.dart';

class SondeHistoryScreen extends StatelessWidget {
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  const SondeHistoryScreen({
    super.key,
    required this.sondeProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: NiceInternetScreen(
        child: BlocBuilder(
            bloc: sondeProcedureOnlineCubit,
            builder: (context, state) {
              final st = sondeProcedureOnlineCubit.state;
              String first = NiceDateTime.dayMonthYear(st.beginTime);
              String last = NiceDateTime.dayMonthYear(st.lastTime);
              return NiceInternetScreen(
                child: Column(
                  children: [
                    //tat ca regimen
                    NiceContainer(
                        child: Column(
                      children: [
                        SondeProcedure.officialName,
                        Text(' $first - $last'),
                        Text('Cân nặng bệnh nhân: ${st.state.weight} kg'),
                        Text('Lượng cho: ${st.state.cho} g'),
                        //Text('debug sondes: ${st.toString()}'),
                      ],
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    GlucoseChartWidget(
                        medicalCheckGlucoses:
                            GlucoseExtract.fromMedicalProcedure(
                                sondeProcedureOnlineCubit.state)),
                    for (var regimen
                        in sondeProcedureOnlineCubit.state.regimens.reversed)
                      RegimenItem(regimen: regimen),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
