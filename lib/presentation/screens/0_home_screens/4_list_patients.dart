import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetichero_app/data/models/manager/2.3_current_profile_cubit.dart';
import 'package:diabetichero_app/logic/status_cubit/navigator_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../../../data/models/manager/2_profile.dart';
import '../../../logic/global/current_group/current_group_id_cubit.dart';
import '../../widgets/nice_widgets/nice_export.dart';
import '../export_screen.dart';
import '4_1_delete_patient_button.dart';

class ListSyncPatients extends StatelessWidget {
  const ListSyncPatients({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentGroupIdCubit, String>(
      builder: (context, groupId) {
        if (groupId == 'Unknown') {
          return NiceScreen(
            child: Center(
              child: Text('Chưa có phòng nào được chọn'),
            ),
          );
        } else
          return ListPatients(
            groupId: groupId,
          );
      },
    );
  }
}

class ListPatients extends StatelessWidget {
  final groupId;
  const ListPatients({
    Key? key,
    this.groupId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NiceInternetScreen(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('groups')
            .doc(groupId)
            .collection('patients')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          } else {
            final patients = snapshot.data!.docs;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Phòng ${groupId} có ${patients.length} bệnh nhân'),
                      ButtonToCreatePatient(),
                    ],
                  ),
                  for (var i = 0; i < patients.length; i++)
                    NiceItem(
                      index: i,
                      title: patients[i]['profile']['name'],
                      subtitle: patients[i]['profile']['id'],
                      trailing: Column(
                        children: [
                          //icon rubbish
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: DeletePatientButton(
                                      groupId: groupId,
                                      patients: patients,
                                      i: i),
                                ),
                              ],
                            ),
                          ),
                          //edit Text
                          // SizedBox(
                          //   height: 15,
                          // ),
                          Text(
                            patients[i]['profile']['procedureType'],
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      onTap: () {
                        //go to patient screen
                        context.read<CurrentProfileCubit>().choose(
                              Profile.fromMap(patients[i]['profile']),
                            );
                        Navigator.of(context).pushReplacementNamed('/patient');
                        context.read<PatientNavigatorBarCubit>().update(0);
                        context.read<BottomNavigatorBarCubit>().update(1);
                      },
                    )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
