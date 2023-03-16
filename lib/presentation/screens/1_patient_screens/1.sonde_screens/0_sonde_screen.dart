import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/time_controller/2_sonde_range.dart';
import 'package:diabetichero_app/logic/status_cubit/range_cubit.dart';
import 'package:diabetichero_app/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/1.sonde_screens/1_sonde_status_widget.dart';
import 'package:diabetichero_app/presentation/widgets/images/doctor_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../../../../data/models/1.sonde/7.2_sonde_procedure_online_cubit.dart';
import '../../../../data/models/1.sonde/7_sonde_procedure.dart';
import '../../../widgets/nice_widgets/nice_export.dart';
import '../history_widget/5_sonde_history_screen.dart';

class SondeScreen extends StatelessWidget {
  final SondeProcedureOnlineCubit sondeProcedureOnlineCubit;
  final RangeCubit rangeCubit;
  const SondeScreen({
    required this.rangeCubit,
    super.key,
    required this.sondeProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return NiceScreen(
      child: Column(
        children: [
          SondeProcedure.officialName,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DoctorImage(),
              //button to history
              NiceButtons(
                onTap: (f) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => SondeHistoryScreen(
                                sondeProcedureOnlineCubit:
                                    sondeProcedureOnlineCubit,
                              )));
                },
                stretch: false,
                width: 50,
                endColor: Colors.yellow,
                startColor: Colors.yellow.shade200,
                // tạo icon history
                child: Icon(Icons.history),
              ),
            ],
          ),
          BlocBuilder<TimeCheckCubit, int>(
            builder: (context, state) {
              rangeCubit
                  .emit(ActrapidRange().rangeContainToday(DateTime.now()));
              return Container();
            },
          ),
          BlocBuilder(
            bloc: sondeProcedureOnlineCubit,
            builder: (context, state) {
              return BlocBuilder(
                bloc: rangeCubit,
                builder: (ct2, st2) {
                  if (state != null)
                    return SondeStatusWidget(
                      sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
                    );
                  else {
                    if (sondeProcedureOnlineCubit.state.state.status ==
                        ProcedureStatus.finish)
                      return Text("Chuyển sang phác đồ bơm điện");
                    else
                      return Column(
                        children: [
                          Text(sondeProcedureOnlineCubit.state.toString()),
                          Text(ActrapidRange().waitingMessage(DateTime.now())),
                        ],
                      );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
