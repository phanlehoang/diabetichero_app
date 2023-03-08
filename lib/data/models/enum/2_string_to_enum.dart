import 'enums.dart';

class StringToEnum {
  //gender
  static Gender stringToGender(String g) {
    switch (g) {
      case 'Nam':
        return Gender.Male;
      default:
        return Gender.Female;
    }
  }

  //procedureType
  static ProcedureType stringToProcedureType(String m) {
    switch (m) {
      case 'TPN':
        return ProcedureType.TPN;
      case 'Sonde':
        return ProcedureType.Sonde;
      case 'Mouth':
        return ProcedureType.Mouth;
      default:
        return ProcedureType.Unknown;
    }
  }

  //sondeStatus
  static ProcedureStatus stringToSondeStatus(String s) {
    switch (s) {
      case 'firstAsk':
        return ProcedureStatus.firstAsk;
      case 'noInsulin':
        return ProcedureStatus.noInsulin;

      case 'yesInsulin':
        return ProcedureStatus.yesInsulin;

      case 'highInsulin':
        return ProcedureStatus.highInsulin;
      case 'finish':
        return ProcedureStatus.finish;

      default:
        return ProcedureStatus.firstAsk;
    }
  }

  //insulinType
  static InsulinType stringToInsulinType(String i) {
    switch (i) {
      //slow
      case 'Slow':
        return InsulinType.Slow;
      case 'Glargine':
        return InsulinType.Glargine;
      case 'Levemir':
        return InsulinType.Levemir;
      case 'Lantus':
        return InsulinType.Lantus;
      case 'NPH':
        return InsulinType.NPH;
      case 'Insulatard':
        return InsulinType.Insulatard;
      //fast
      case 'Fast':
        return InsulinType.Fast;

      case 'Actrapid':
        return InsulinType.Actrapid;
      case 'NovoRapid':
        return InsulinType.NovoRapid;

      default:
        return InsulinType.Unknown;
    }
  }

  //mouthProcedureStatus
  static MouthProcedureStatus stringToMouthProcedureStatus(String s) {
    switch (s) {
      case 'loading':
        return MouthProcedureStatus.loading;
      //ca 1
      case 'firstAsk':
        return MouthProcedureStatus.firstAsk;
      case 'acuteHyperglycemia':
        return MouthProcedureStatus.acuteHyperglycemia;
      //ca 2
      case 'secondAsk':
        return MouthProcedureStatus.secondAsk;
      case 'hypoGlycemia':
        return MouthProcedureStatus.hypoGlycemia;
      case 'hypoGlycemiaNoInsulin':
        return MouthProcedureStatus.hypoGlycemiaNoInsulin;
      case 'hypoGlycemiaYesInsulin':
        return MouthProcedureStatus.hypoGlycemiaYesInsulin;
      //ca 3
      case 'thirdAsk':
        return MouthProcedureStatus.thirdAsk;
      case 'baseBolus':
        return MouthProcedureStatus.baseBolus;
      case 'endocrineConference':
        return MouthProcedureStatus.endocrineConference;
      case 'finish':
        return MouthProcedureStatus.finish;
      default:
        return MouthProcedureStatus.firstAsk;
    }
  }
}
