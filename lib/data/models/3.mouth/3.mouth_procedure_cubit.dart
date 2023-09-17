import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetichero_app/data/models/0.medical/medical_action/2_medical_check_glucose.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/2_profile.dart';
import '../enum/enums.dart';
import '1.mouth_regimen.dart';
import '2.mouth_procedure.dart';

class MouthProcedureCubit extends Cubit<MouthProcedure> {
  final Profile profile;
  String procedureId;

  MouthProcedureCubit({
    required this.profile,
    required this.procedureId,
  }) : super(MouthProcedure(
          beginTime: DateTime.tryParse(procedureId) != null
              ? DateTime.parse(procedureId)
              : DateTime.now(),
          status: MouthProcedureStatus.loading,
          name: 'MouthProcedure',
          regimens: [],
        ));
  DocumentReference get procedureRef {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(profile.room)
        .collection('patients')
        .doc(profile.id)
        .collection('procedures')
        .doc(procedureId);
  }

  Future<DocumentReference?> get lastRegimenRef async {
    CollectionReference regimensRef = procedureRef.collection('regimens');
    List<QueryDocumentSnapshot> docs = (await regimensRef.get()).docs;
    if (docs.isEmpty) {
      return null;
    }
    return regimensRef.doc(docs.last.id);
  }

  Future<void> addMouthRegimen(MouthRegimen regimen) async {
    CollectionReference regimensRef = procedureRef.collection('regimens');
    try {
      await regimensRef.doc(regimen.beginTime.toString()).set(regimen.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<void> addMedicalAction(dynamic medicalAction) async {
    DocumentReference? lastRegimenRef = await this.lastRegimenRef;
    if (lastRegimenRef == null) {
    } else {
      try {
        await lastRegimenRef.update({
          'medicalActions': FieldValue.arrayUnion([medicalAction.toMap()])
        });
      } catch (e) {
        print(e);
      }
    }
    //neu la medical check glucose thi update evalCounter
    if (medicalAction is MedicalCheckGlucose) {
      //neu eval < 8 thi update evalCounter
      num evalCounter = state.regimens.last.evalCounter;
      if (evalCounter < 8) {
        try {
          await procedureRef.update({
            'evalCounter': FieldValue.increment(1),
          });
        } catch (e) {
          print(e);
        }
      }
    }
  }

  Future<void> updateProcedureStatus(MouthProcedureStatus status) async {
    try {
      await procedureRef.update({'status': EnumToString.enumToString(status)});
    } catch (e) {
      print(e);
    }
  }
}
