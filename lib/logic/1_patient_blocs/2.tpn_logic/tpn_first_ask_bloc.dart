import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../data/models/2.TPN/3_TPN_procedure_online_cubit.dart';
import '../../../data/models/enum/enums.dart';
import '../../../data/models/medical/6_procedure_state.dart';
import '../../../presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';

class TPNFirstAskBloc extends FormBloc<String, String> {
  final TPNProcedureOnlineCubit procedureOnlineCubit;
  final yesOrNoInsulin = SelectFieldBloc(
    items: ['Có', 'Khôngc'],
    validators: [VietnameseFieldBlocValidators.required],
  );

  TPNFirstAskBloc({
    required this.procedureOnlineCubit,
  }) {
    addFieldBlocs(
      fieldBlocs: [
        yesOrNoInsulin,
      ],
    );
  }

  @override
  void onSubmitting() async {
    print('onSubmitting');
    num weight = procedureOnlineCubit.profile.weight;
    ProcedureState procedureState = ProcedureState(
      status: yesOrNoInsulin.value == 'Yes'
          ? ProcedureStatus.yesInsulin
          : ProcedureStatus.noInsulin,
      slowInsulinType: InsulinType.Lantus,
      weight: weight,
    );
    //update sonde status
    try {
      await procedureOnlineCubit.updateProcedureStateStatus(
        procedureState,
      );
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    emitSuccess();
  }
}
