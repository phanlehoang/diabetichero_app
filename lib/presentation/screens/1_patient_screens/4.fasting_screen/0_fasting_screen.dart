// import 'package:diabetichero_app/data/models/enum/enums.dart';

// import 'package:diabetichero_app/logic/status_cubit/range_cubit.dart';
// import 'package:diabetichero_app/logic/status_cubit/time_check/time_check_cubit.dart';

// import 'package:diabetichero_app/presentation/widgets/images/doctor_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nice_buttons/nice_buttons.dart';

// import '../../../../data/models/4.fasting/2.fasting_procedure.dart';
// import '../../../../data/models/4.fasting/3.fasting_procedure_online.dart';
// import '../../../../data/models/time_controller/4_fasting_range.dart';
// import '../../../widgets/nice_widgets/nice_export.dart';

// import '../history_widget/9_fasting_history_screen.dart';
// import '1_fasting_status_widget.dart';

// class FastingScreen extends StatelessWidget {
//   final FastingProcedureOnlineCubit fastingProcedureOnlineCubit;
//   final RangeCubit rangeCubit;
//   const FastingScreen({
//     required this.rangeCubit,
//     super.key,
//     required this.fastingProcedureOnlineCubit,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return NiceScreen(
//       child: Column(
//         children: [
//           FastingProcedure.officialName,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               DoctorImage(),
//               //button to history
//               NiceButtons(
//                 onTap: (f) {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => FastingHistoryScreen(
//                                 fastingProcedureOnlineCubit:
//                                     fastingProcedureOnlineCubit,
//                               )));
//                 },
//                 stretch: false,
//                 width: 50,
//                 endColor: Colors.yellow,
//                 startColor: Colors.yellow.shade200,
//                 // tạo icon history
//                 child: Icon(Icons.history),
//               ),
//             ],
//           ),
//           BlocBuilder<TimeCheckCubit, int>(
//             builder: (context, state) {
//               rangeCubit
//                   .emit(ActrapidRange().rangeContainToday(DateTime.now()));
//               return Container();
//             },
//           ),
//           BlocBuilder(
//             bloc: fastingProcedureOnlineCubit,
//             builder: (context, state) {
//               return BlocBuilder(
//                 bloc: rangeCubit,
//                 builder: (ct2, st2) {
//                   if (state != null)
//                     return FastingStatusWidget(
//                       fastingProcedureOnlineCubit: fastingProcedureOnlineCubit,
//                     );
//                   else {
//                     if (fastingProcedureOnlineCubit.state.state.status ==
//                         ProcedureStatus.finish)
//                       return Text("Chuyển sang phác đồ bơm điện");
//                     else
//                       return Column(
//                         children: [
//                           Text(fastingProcedureOnlineCubit.state.toString()),
//                           Text(ActrapidRange().waitingMessage(DateTime.now())),
//                         ],
//                       );
//                   }
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
