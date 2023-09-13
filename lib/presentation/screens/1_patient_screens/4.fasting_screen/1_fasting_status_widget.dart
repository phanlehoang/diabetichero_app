// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:diabetichero_app/data/models/enum/enums.dart';
// import 'package:diabetichero_app/presentation/screens/1_patient_screens/4.fasting_screen/2_0_fasting_firstAsk_widget.dart';

// import 'package:diabetichero_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../data/models/4.fasting/2.fasting_procedure.dart';
// import '../../../../data/models/4.fasting/3.fasting_procedure_online.dart';
// import '../../../../data/models/manager/2.3_current_profile_cubit.dart';
// import '../../../../data/models/0.medical/7_medical_procedure.dart';
// import '../../../../data/models/manager/models_export.dart';
// import '../../../widgets/nice_widgets/0.1_nice_internet_screen.dart';

// class FastingStatusWidget extends StatelessWidget {
//   final FastingProcedureOnlineCubit fastingProcedureOnlineCubit;
//   FastingStatusWidget({
//     super.key,
//     required this.fastingProcedureOnlineCubit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final Profile profile = context.read<CurrentProfileCubit>().state;

//     return NiceInternetScreen(
//       child: Column(children: [
//         BlocBuilder(
//           bloc: fastingProcedureOnlineCubit,
//           builder: (ct, st) {
//             final FastingProcedure fastingProcedure = st as FastingProcedure;
//             switch (fastingProcedure.state.status) {
//               case ProcedureStatus.firstAsk:
//                 return FastingFirstAskWidget(
//                     procedureOnlineCubit: FastingProcedureOnlineCubit);
//               case ProcedureStatus.noInsulin:
//                 return FastInsulinWidget(
//                   FastingProcedureOnlineCubit: FastingProcedureOnlineCubit,
//                 );
//               case ProcedureStatus.yesInsulin:
//                 return Column(
//                   children: [
//                     SlowInsulinWidget(
//                       fastingProcedureOnlineCubit: fastingProcedureOnlineCubit,
//                     ),
//                     FastInsulinWidget(
//                       fastingProcedureOnlineCubit: fastingProcedureOnlineCubit,
//                     ),
//                   ],
//                 );
//               case ProcedureStatus.highInsulin:
//                 return Column(
//                   children: [
//                     SlowInsulinWidget(
//                       sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
//                     ),
//                     FastInsulinWidget(
//                       sondeProcedureOnlineCubit: sondeProcedureOnlineCubit,
//                     ),
//                   ],
//                 );
//               case ProcedureStatus.finish:
//                 return Text('Chuyển sang phác đồ bơm điện');
//               default:
//                 return Container();
//             }
//           },
//         ),
//       ]),
//     );
//   }
// }
