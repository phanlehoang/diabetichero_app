// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:diabetichero_app/data/models/enum/enums.dart';

import '../0.medical/4_regimen.dart';
import '../0.medical/medical_action/2.5_list_medical_from_list_map.dart';

class MouthRegimen extends Regimen {
  List<String> healthConditions;
  Map<String, dynamic> symptoms;
  num weight;
  
  MouthRegimen({
    required this.symptoms,
    required DateTime beginTime,
    required String name,
    required List<dynamic> medicalActions,
    required this.healthConditions,
    required this.weight, 
    required MouthProcedureStatus status,
  }) : super(
          beginTime: beginTime,
          name: name,
          medicalActions: medicalActions,
        );
  //toString
  @override
  String toString() {
    return '''
     MouthRegimen{symptoms: $symptoms,
      weight: $weight, beginTime: $beginTime, 
      name: $name,
       medicalActions: $medicalActions,
       healthConditions: $healthConditions}''';
  }

  factory MouthRegimen.fromMap(Map<String, dynamic> map) {
    return MouthRegimen(
      symptoms: map['symptoms'],
      weight: map['weight'],
      beginTime: map['beginTime'].toDate(),
      name: map['name'],
      status: map['status'] == null
          ? MouthProcedureStatus.baseBolus
          : StringToEnum.stringToMouthProcedureStatus(map['status'])  ,
      medicalActions:
          ListMedicalFromListMap.medicalActions(map['medicalActions']),
      healthConditions: List<String>.from(map['healthConditions']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'symptoms': symptoms,
      'weight': weight,
      'beginTime': beginTime,
      'name': name,
      'medicalActions': medicalActions,
      'healthConditions': healthConditions,
    };
  }
}
