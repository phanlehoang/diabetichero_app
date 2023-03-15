import 'package:diabetichero_app/data/data_provider/patient_provider.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/logic/status_cubit/reference_warning_cubit.dart';
import 'package:diabetichero_app/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/2.tpn_screens/0_tpn_screen.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:diabetichero_app/presentation/widgets/status/reference_warning_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../data/models/1.sonde/7.2_sonde_procedure_online_cubit.dart';
import '../../../data/models/manager/2.3_current_profile_cubit.dart';
import '../../../data/models/manager/2_profile.dart';
import '../../../data/models/2.TPN/3_TPN_procedure_online_cubit.dart';
import '../../../data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import '../../widgets/bars/bottom_navitgator_bar.dart';
import '../../widgets/bars/patient_navigator_bar.dart';
import '../../widgets/nice_widgets/0.1_nice_internet_screen.dart';
import '../../widgets/status/loading_dialog.dart';
import '1.sonde_screens/0_sonde_screen.dart';
import '3.mouth_screens/0_mouth_screen.dart';

class PatientMedicalScreen extends StatelessWidget {
  const PatientMedicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: PatientNavigatorBar(),
      ),
      body: NiceInternetScreen(
        child: Column(
          children: [
            BlocBuilder<CurrentProfileCubit, Profile>(builder: (ct, st) {
              //sonde procedure bloc
              String sondeProcedureId = st.currentProcedureId;
              switch (st.procedureType) {
                case ProcedureType.Sonde:
                  return SondeScreen(
                    sondeProcedureOnlineCubit: SondeProcedureOnlineCubit(
                      profile: context.read<CurrentProfileCubit>().state,
                      procedureId: sondeProcedureId,
                    ),
                  );
                case ProcedureType.TPN:
                  return TPNScreen(
                    tPNProcedureOnlineCubit: TPNProcedureOnlineCubit(
                      profile: context.read<CurrentProfileCubit>().state,
                      procedureId: sondeProcedureId,
                    ),
                  );
                case ProcedureType.Mouth:
                  return MouthScreen(
                    mouthProcedureOnlineCubit: MouthProcedureOnlineCubit(
                      profile: context.read<CurrentProfileCubit>().state,
                      procedureId: sondeProcedureId,
                    ),
                  );
                case ProcedureType.Unknown:
                  return Text('Unknown');

                default:
                  return Container();
              }
            }),
            SizedBox(
              height: 30,
            ),

            //cuối màn hình in cảnh báo
            BlocBuilder(
              bloc: context.read<ReferenceWarningCubit>(),
              builder: (context, state) {
                if (state == true) {
                  return ReferenceWarningWidget();
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}
