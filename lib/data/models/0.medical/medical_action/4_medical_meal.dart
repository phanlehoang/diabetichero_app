import '1_medical_action.dart';

class MedicalMeal extends MedicalAction {
  String description = '';
  MedicalMeal({
    required super.time,
    this.description = '',
  });
  //props
  @override
  List<Object?> get props => [this.time];

  // @override
  @override
  String toString() {
    return 'meal: ' + this.time.toString();
  }

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'name': 'MedicalMeal',
      'time': time,
      'description': description,
    };
  }

  //fromMap
  factory MedicalMeal.fromMap(Map<String, dynamic>? map) {
    try {
      if (map == null) return errorMedicalMeal;
      return MedicalMeal(
        time: map['time'].toDate(),
        description: map['description'],
      );
    } catch (e) {
      return errorMedicalMeal;
    }
  }
}

MedicalMeal errorMedicalMeal = MedicalMeal(
  time: DateTime(1999),
);
