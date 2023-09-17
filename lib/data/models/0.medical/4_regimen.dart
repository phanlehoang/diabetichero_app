// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:equatable/equatable.dart';

import '../time_controller/1_medical_range.dart';
import '../time_controller/2_sonde_range.dart';

import 'medical_action/2.5_list_medical_from_list_map.dart';
import 'medical_action/2_medical_check_glucose.dart';
import 'medical_action/3_medical_take_insulin.dart';

class Regimen extends Equatable {
  //1. attributes
  String name;
  List<dynamic> medicalActions;
  DateTime beginTime;
  num evalCounter = 8;
  Regimen({
    required this.name,
    required this.medicalActions,
    required this.beginTime,
    this.evalCounter = 8,
  });
  //1.1. compare
  //props
  @override
  List<Object?> get props => [name, medicalActions];

  //2. methods add
  void addMedicalAction(dynamic medicalAction) {
    medicalActions.add(medicalAction.clone());
  }

  //3. print for debug
  @override
  String toString() {
    dynamic medicalActions_str = medicalActions.toString();
    return '''Regimen name: $name, 
              beginTime: $beginTime,
               ${medicalActions_str}
    ''';
  }
  //4. convert data
  //toMap

  Map<String, dynamic> toMap() {
    return {
      'medicalActions': [for (dynamic x in medicalActions) x.toMap()],
      'name': name,
      'beginTime': beginTime,
      'evalCounter': evalCounter,
    };
  }

  //fromMap
  factory Regimen.fromMap(Map<String, dynamic>? map) {
    if (map == null) return errorRegimen();
    return Regimen(
      medicalActions:
          ListMedicalFromListMap.medicalActions(map['medicalActions']),
      name: map['name'] != null ? map['name'] : 'Unknown',
      beginTime:
          map['beginTime'] != null ? map['beginTime'].toDate() : DateTime.now(),
      evalCounter: map['evalCounter'] != null ? map['evalCounter'] : 8,
    );
  }
  //from snapshot
  factory Regimen.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    return Regimen.fromMap(map);
  }
  Regimen clone() {
    return Regimen(
      medicalActions: [for (dynamic x in medicalActions) x.clone()],
      name: name,
      beginTime: beginTime,
      evalCounter: evalCounter,
    );
  }

  //6. get data
  List<MedicalCheckGlucose> get medicalCheckGlucoses {
    List<MedicalCheckGlucose> list = [];
    for (var x in medicalActions) {
      if (x is MedicalCheckGlucose) list.add(x);
    }
    return list;
  }

  List<MedicalTakeInsulin> get medicalTakeInsulins {
    List<MedicalTakeInsulin> list = [];
    for (var x in medicalActions) {
      if (x is MedicalTakeInsulin) list.add(x);
    }
    return list;
  }

  //medical take actrapid insulin
  List<MedicalTakeInsulin> get medicalTakeActrapidInsulins {
    List<MedicalTakeInsulin> list = [];
    for (var x in medicalActions) {
      if (x is MedicalTakeInsulin && x.insulinType == InsulinType.Actrapid)
        list.add(x);
    }
    return list;
  }

  //medical take not actrapid insulin
  List<MedicalTakeInsulin> get medicalTakeNotActrapidInsulins {
    List<MedicalTakeInsulin> list = [];
    for (var x in medicalActions) {
      if (x is MedicalTakeInsulin && x.insulinType != InsulinType.Actrapid)
        list.add(x);
    }
    return list;
  }

  get lastNotActrapidInsulinTime {
    if (medicalTakeNotActrapidInsulins.length == 0) return DateTime(1999);
    return medicalTakeNotActrapidInsulins.last.time;
  }

  //get last
  num get lastGluAmount {
    if (medicalCheckGlucoses.length == 0) return 0;
    return medicalCheckGlucoses.last.glucoseUI;
  }

  DateTime get lastGluTime {
    if (medicalCheckGlucoses.length == 0) return DateTime(1999);
    return medicalCheckGlucoses.last.time;
  }

  //get last actrapid insulin
  DateTime get lastActrapidInsulinTime {
    if (medicalTakeActrapidInsulins.length == 0) return DateTime(1999);
    return medicalTakeActrapidInsulins.last.time;
  }

  RegimenStatus regimenSlowStatus(MedicalRange medicalRange) {
    if (!medicalRange.isHot(lastNotActrapidInsulinTime))
      return RegimenStatus.givingInsulin;
    return RegimenStatus.done;
  }

  RegimenStatus regimenActrapidStatus(MedicalRange medicalRange) {
    if (!medicalRange.isHot(lastGluTime)) return RegimenStatus.checkingGlucose;
    if (!medicalRange.isHot(lastActrapidInsulinTime))
      return RegimenStatus.givingInsulin;
    return RegimenStatus.done;
  }

  bool get isFull50 {
    int counter = 0;
    for (var x in medicalCheckGlucoses) {
      if (x.glucoseUI > 8.3) counter++;
    }
    return counter >= 5;
  }

  DateTime get lastTime {
    if (medicalActions.length == 0) return beginTime;
    return medicalActions.last.time;
  }

  DateTime get firstTime {
    return beginTime;
  }
}

Regimen initialRegimen() {
  return Regimen(
    beginTime: DateTime.now(),
    medicalActions: [],
    name: 'Unknown',
  );
}

Regimen errorRegimen() {
  return Regimen(
    beginTime: DateTime.now(),
    medicalActions: [],
    name: 'Error',
  );
}
