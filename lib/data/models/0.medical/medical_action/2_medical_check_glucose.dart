import '1_medical_action.dart';

class MedicalCheckGlucose extends MedicalAction {
  num glucoseUI = 0;
  MedicalCheckGlucose({
    required super.time,
    required this.glucoseUI,
  });
  // @override
  // List<Object?> get props => [this.time, this.glucoseUI];
  MedicalCheckGlucose clone() {
    return MedicalCheckGlucose(time: time, glucoseUI: glucoseUI);
  }
  //props
  @override
  List<Object?> get props => [this.time, this.glucoseUI];
  //toMap
  Map<String, dynamic> toMap() {
    return {
      'name': 'MedicalCheckGlucose',
      'time': time,
      'glucoseUI': glucoseUI,
    };
  }

  //fromMap
  factory MedicalCheckGlucose.fromMap(Map<String, dynamic>? map) {
    try {
      if (map == null) return errorMedicalCheckGlucose;
      return MedicalCheckGlucose(
        time: map['time'].toDate(),
        glucoseUI: map['glucoseUI'],
      );
    } catch (e) {
      return errorMedicalCheckGlucose;
    }
  }

  @override
  String toString() {
    return '($glucoseUI glucose at $time)';
  }

  String toNiceString() {
    String amount = this.glucoseUI.toString();
    return '$amount mol/l';
  }
}

//error Medical Check Glucose
MedicalCheckGlucose errorMedicalCheckGlucose = MedicalCheckGlucose(
  time: DateTime(1999),
  glucoseUI: 0,
);