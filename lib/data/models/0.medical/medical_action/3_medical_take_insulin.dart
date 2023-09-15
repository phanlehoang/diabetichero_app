// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';

import '1_medical_action.dart';

class MedicalTakeInsulin extends MedicalAction {
  InsulinType insulinType;
  num insulinUI;
  // num recommendedInsulinUI;
  MedicalTakeInsulin({
    required this.insulinType,
    required super.time,
    required this.insulinUI,
    // required this.recommendedInsulinUI,
  });

  List<Object?> get props => [this.time, this.insulinType, this.insulinUI];
  MedicalTakeInsulin clone() {
    return MedicalTakeInsulin(
      insulinType: insulinType,
      time: time,
      insulinUI: insulinUI,
      // recommendedInsulinUI: recommendedInsulinUI,
    );
  }

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'name': 'MedicalTakeInsulin',
      'time': time,
      'insulinType': EnumToString.enumToString(insulinType),
      'insulinUI': insulinUI,
      // 'recommendedInsulinUI': recommendedInsulinUI,
    };
  }

  //fromMap
  factory MedicalTakeInsulin.fromMap(Map<String, dynamic>? map) {
    if (map == null) return errorMedicalTakeInsulin;
    try {
      return MedicalTakeInsulin(
        insulinType: StringToEnum.stringToInsulinType(map['insulinType']),
        time: map['time'].toDate(),
        insulinUI: map['insulinUI'],
        // recommendedInsulinUI: map['recommendedInsulinUI'],
      );
    } catch (e) {
      return errorMedicalTakeInsulin;
    }
  }

  @override
  String toString() {
    return '(${this.insulinUI} ${this.insulinType} lúc ${this.time})';
  }

  String toNiceString() {
    String insulinType = EnumToString.enumToString(this.insulinType);
    String amount = this.insulinUI.toString();
    return '$amount $insulinType UI';
  }
}

//error MedicalTakeInsulin
MedicalTakeInsulin errorMedicalTakeInsulin = MedicalTakeInsulin(
  insulinType: InsulinType.Actrapid,
  time: DateTime(1999),
  insulinUI: 0,
  // recommendedInsulinUI: 0,
);
