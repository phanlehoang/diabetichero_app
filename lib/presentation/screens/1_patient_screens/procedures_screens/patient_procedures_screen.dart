import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetichero_app/data/models/manager/2_profile.dart';
import 'package:diabetichero_app/data/models/2.TPN/1_TPN_procedure.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/data/models/0.medical/4_regimen.dart';
import 'package:diabetichero_app/logic/status_cubit/navigator_bar_cubit.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/procedures_screens/TPN_procedure_item.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/procedures_screens/create_procedure.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/procedures_screens/fasting_procedures_item.dart';
import 'package:diabetichero_app/presentation/screens/1_patient_screens/procedures_screens/sonde_procedure_item.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/nice_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../../../../data/models/manager/2.3_current_profile_cubit.dart';
import '../../../../logic/global/current_group/current_group_id_cubit.dart';
import '../../../widgets/bars/bottom_navitgator_bar.dart';
import '../../../widgets/bars/patient_navigator_bar.dart';
import '../../../widgets/nice_widgets/0_nice_screen.dart';
import '../history_widget/nice_date_time.dart';
import 'mouth_procedure_item.dart';

class PatientProceduresScreen extends StatelessWidget {
  const PatientProceduresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: PatientNavigatorBar(),
      ),
      body: NiceInternetScreen(
        child: BlocBuilder<CurrentProfileCubit, Profile>(
          builder: (context, state) {
            if (state.id == '' || state.id == 'Unknown')
              return Text('Chưa chọn bệnh nhân');
            return Column(
              children: [
                //   ButtonToCreateProcedure(),
                CreateProcedure(),
                ListProcedures(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}

class ButtonToCreateProcedure extends StatelessWidget {
  const ButtonToCreateProcedure({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NiceButtons(
      stretch: false,
      width: 50,
      onTap: (_) {
        //navigator to create procedure screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (createProcedureContext) => CreateProcedure(),
          ),
        );
      },
      child: //icon to add a procedure
          Icon(Icons.add_box),
    );
  }
}

class ListProcedures extends StatelessWidget {
  const ListProcedures({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('groups')
          .doc(context.read<CurrentProfileCubit>().state.room)
          .collection('patients')
          .doc(context.read<CurrentProfileCubit>().state.id)
          .collection('procedures')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Text('No data');
        } else {
          final procedureRefs = snapshot.data!.docs.reversed;
          //remove procedures name != 'sonde'
          //procedures.removeWhere((element) => element['name'] != 'SondeProcedure');
          List<Widget> procedureItems = [];
          for (var procedureRef in procedureRefs)
            if (procedureRef['name'] == 'SondeProcedure')
              procedureItems.add(SondeProcedureItem(
                procedure: procedureRef.data(),
                procedureId: procedureRef.id,
              ));
            else if (procedureRef['name'] == 'TPNProcedure')
              procedureItems.add(TPNProcedureItem(
                procedure: procedureRef.data(),
                procedureId: procedureRef.id,
              ));
            else if (procedureRef['name'] == 'MouthProcedure')
              procedureItems.add(MouthProcedureItem(
                procedure: procedureRef.data(),
                procedureId: procedureRef.id,
              ));
            else if (procedureRef['name'] == 'FastingProcedure')
              procedureItems.add(FastingProcedureItem(
                procedure: procedureRef.data(),
                procedureId: procedureRef.id,
              ));
          return Column(
            children: [
              Text('Các phác đồ đã thực hiện'),
              ...procedureItems,
            ],
          );
        }
      },
    );
  }
}
