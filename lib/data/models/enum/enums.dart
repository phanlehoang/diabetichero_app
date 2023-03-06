export '1_enum_to_string.dart';
export '3_enum_to_name.dart';
export '2_string_to_enum.dart';
export '4_medical_action_to_name.dart';

enum Gender {
  Male,
  Female,
}

enum ProcedureType {
  TPN,
  Sonde,
  Mouth,
  Unknown,
}

enum ProcedureStatus {
  firstAsk,
  noInsulin,
  yesInsulin,
  highInsulin,
  finish,
}

enum MouthProcedureStatus {
  loading,
  firstAsk,
  acuteHyperglycemia, //tăng đường huyết cấp tính
  secondAsk,
  hypoglycemia, //bị hạ đường huyết
  thirdAsk,
  baseBolus,
  endocrineConference, //hội chẩn nội tiết
  finish,
}

enum RegimenStatus {
  error,
  checkingGlucose,
  givingInsulin,
  guideMixing,
  done,
}

enum GlucoseEvaluation {
  normal,
  high,
  low,
  superHigh,
  extremelyHigh,
}

enum InsulinType {
  //slow
  Glargine,
  Levemir,
  Lantus,
  NPH,
  Insulatard,
  Slow,

  //fast
  Actrapid,
  NovoRapid,
  Fast,

  Unknown,
}
