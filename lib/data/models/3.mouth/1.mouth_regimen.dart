// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../medical/4_regimen.dart';

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
  }) : super(
          beginTime: beginTime,
          name: name,
          medicalActions: medicalActions,
        );
  factory MouthRegimen.fromMap(Map<String, dynamic> map) {
    return MouthRegimen(
      symptoms: map['symptoms'],
      weight: map['weight'],
      beginTime: map['beginTime'].toDate(),
      name: map['name'],
      medicalActions: List<dynamic>.from(map['medicalActions']),
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
