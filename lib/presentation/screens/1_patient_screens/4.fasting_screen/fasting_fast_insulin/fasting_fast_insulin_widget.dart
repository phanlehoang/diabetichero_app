// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:diabetichero_app/logic/status_cubit/time_check/time_check_cubit.dart';
// import 'package:diabetichero_app/presentation/screens/1_patient_screens/4.fasting_screen/fasting_fast_insulin/fasting_give_fast_insulin_widget.dart';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:diabetichero_app/data/data_provider/regimen_provider.dart';
// import 'package:diabetichero_app/data/models/manager/models_export.dart';
// import 'package:diabetichero_app/presentation/widgets/nice_widgets/0_nice_screen.dart';

// import '../../../../../data/models/4.fasting/3.fasting_procedure_online.dart';
// import '../../../../../data/models/manager/2.3_current_profile_cubit.dart';
// import '../../../../../data/models/enum/enums.dart';


// import '../../../../../data/models/time_controller/4_fasting_range.dart';
// import '../../../../widgets/nice_widgets/1_nice_container.dart';
// import '../../1.sonde_screens/sonde_fast_insulin/2_1_1_check_glucose_widget.dart';

// class FastingFastInsulinWidget extends StatelessWidget {
//   final FastingProcedureOnlineCubit procedureOnlineCubit;
//   const FastingFastInsulinWidget({
//     Key? key,
//     required this.procedureOnlineCubit,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Profile profile = context.read<CurrentProfileCubit>().state;
//     return SimpleContainer(
//       child: BlocBuilder(
//         bloc: procedureOnlineCubit,
//         builder: (context, state) {
//           switch (procedureOnlineCubit.state.fastStatus) {
//             case RegimenStatus.checkingGlucose:
//               return CheckGlucoseWidget(
//                 procedureOnlineCubit: procedureOnlineCubit,
//               );
//             case RegimenStatus.givingInsulin:
//               return FastingGiveFastInsulinWidget(
//                   fastingProcedureOnlineCubit: procedureOnlineCubit);

//             case RegimenStatus.done:
//               {
//                 if (procedureOnlineCubit.state.isFull50 &&
//                     procedureOnlineCubit.state.slowStatus ==
//                         RegimenStatus.done) {
//                   procedureOnlineCubit.goToNextStatus();
//                 }
//                 return Column(
//                   children: [
//                     Text('Đã xong.'),
//                     Text(ActrapidRange().waitingMessage(DateTime.now())),
//                   ],
//                 );
//               }

//             default:
//               return Text('default');
//           }
//         },
//       ),
//     );
//   }
// }
