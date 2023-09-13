import 'package:diabetichero_app/data/models/enum/enums.dart';

import '../0.medical/6_procedure_state.dart';

class FastingSlowInsulinSolve {
  final InsulinType insulinType;
  FastingSlowInsulinSolve({required this.insulinType});
}

class NPHInsulinSolve extends FastingSlowInsulinSolve {
  NPHInsulinSolve() : super(insulinType: InsulinType.NPH);
  num insulinAmount({required ProcedureState fastingState}) {
    num init = fastingState.weight * 0.1;
    if (fastingState.status == ProcedureStatus.highInsulin) {
      return (init * 1.1).round();
    }
    return init.round();
  }

  String guide({required ProcedureState fastingState}) {
    return 'Tiem NPH ${insulinAmount(fastingState: fastingState)} UI';
  }
}

class GlargineInsulinSolve extends FastingSlowInsulinSolve {
  GlargineInsulinSolve() : super(insulinType: InsulinType.Glargine);
  num insulinAmount({required ProcedureState fastingState}) {
    num init = fastingState.weight * 0.2;
    if (fastingState.status == ProcedureStatus.highInsulin) {
      return (init * 1.1).round();
    }
    return init.round();
  }

  String guide({required ProcedureState fastingState}) {
    return 'Tiem Glargine ${insulinAmount(fastingState: fastingState)} UI';
  }
}

//Lantus Insulin Solve
class LantusInsulinSolve extends FastingSlowInsulinSolve {
  LantusInsulinSolve() : super(insulinType: InsulinType.Lantus);
  num insulinAmount({required ProcedureState fastingState}) {
    num init = fastingState.weight * 0.2;
    if (fastingState.status == ProcedureStatus.highInsulin) {
      return init = init + 2;
    }
    return init.round();
  }

  String guide({required ProcedureState fastingState}) {
    return 'Tiem Lantus ${insulinAmount(fastingState: fastingState)} UI';
  }
}
