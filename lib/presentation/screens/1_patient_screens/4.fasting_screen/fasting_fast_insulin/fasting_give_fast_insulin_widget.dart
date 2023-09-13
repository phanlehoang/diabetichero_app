// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:diabetichero_app/data/models/0.medical/medical_action/3_medical_take_insulin.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_form_bloc/flutter_form_bloc.dart';

// import 'package:diabetichero_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
// import 'package:diabetichero_app/presentation/widgets/nice_widgets/2_nice_button.dart';

// import '../../../../../data/data_provider/regimen_provider.dart';
// import '../../../../../data/models/4.fasting/3.fasting_procedure_online.dart';
// import '../../../../../data/models/enum/enums.dart';
// import '../../../../../data/models/glucose-insulin_controller/glucose_solve.dart';

// import '../../../../../data/models/manager/models_export.dart';
// import '../../../../../logic/1_patient_blocs/1.sonde_logic/check_insulin_submit_bloc.dart';

// import '../../../../widgets/nice_widgets/1_nice_container.dart';

// class FastingGiveFastInsulinWidget extends StatelessWidget {
//   //sonde cubit
//   final FastingProcedureOnlineCubit fastingProcedureOnlineCubit;
//   const FastingGiveFastInsulinWidget({
//     Key? key,
//     required this.fastingProcedureOnlineCubit,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         BlocBuilder(
//           bloc: fastingProcedureOnlineCubit,
//           builder: (ct, st) {
//             final fastingProcedure = fastingProcedureOnlineCubit.state;
//             switch (fastingProcedure.fastStatus) {
//               case RegimenStatus.givingInsulin:
//                 {
//                   num glu = fastingProcedure.regimens.last.lastGluAmount;
//                   String guide = fastingGlucoseSolve.insulinGuideString(
//                     regimen: fastingProcedure.regimens.last,
//                     procedureState: fastingProcedureOnlineCubit.state.state,
//                   );

//                   num insulin = GlucoseSolve.insulinGuide(
//                     regimen: fastingProcedure.regimens.last,
//                     sondeState: fastingProcedureOnlineCubit.state.state,
//                   );
//                   return Column(
//                     children: [
//                       Text('Tạm ngừng thuốc hạ đường máu'),
//                       Text(guide),
//                       BlocProvider<CheckedInsulinSubmit>(
//                           create: (context) => CheckedInsulinSubmit(
//                                 procedureOnlineCubit:
//                                     fastingProcedureOnlineCubit,
//                                 medicalTakeInsulin: MedicalTakeInsulin(
//                                   time: DateTime.now(),
//                                   insulinType: InsulinType.Actrapid,
//                                   insulinUI: insulin,
//                                 ),
//                               ),
//                           child: Builder(builder: (_) {
//                             return FormBlocListener<CheckedInsulinSubmit,
//                                 String, String>(
//                               onSuccess: (cc, state) {},
//                               onFailure: (cc, state) {
//                                 ScaffoldMessenger.of(cc).showSnackBar(
//                                   SnackBar(
//                                     content: Text('Failure'),
//                                   ),
//                                 );
//                               },
//                               child: NiceButton(
//                                 text: 'Tiếp tục',
//                                 onTap: () {
//                                   _.read<CheckedInsulinSubmit>().submit();
//                                 },
//                               ),
//                             );
//                           }))
//                     ],
//                   );
//                 }

//               default:
//                 {
//                   return Text('Co loi xay ra');
//                 }
//             }
//           },
//         )
//       ],
//     );
//   }
// }
