import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../data/models/4.fasting/3.fasting_procedure_online.dart';
import '../../../data/models/enum/enums.dart';
import '../../../data/models/0.medical/6_procedure_state.dart';
import '../../../presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';

class FastingFirstAskBloc extends FormBloc<String, String> {
  final FastingProcedureOnlineCubit procedureOnlineCubit;
  final yesOrNoInsulin = SelectFieldBloc(
    items: ['Có', 'Không'],
    validators: [VietnameseFieldBlocValidators.required],
  );

  FastingFirstAskBloc({
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
    );
    //update fasting status
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
