import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../data/models/0.medical/6_procedure_state.dart';

class SondeFirstAskBloc extends FormBloc<String, String> {
  final procedureOnlineCubit;
  final yesOrNoInsulin = SelectFieldBloc(
    items: ['Có', 'Không'],
    validators: [VietnameseFieldBlocValidators.required],
  );
  final getCHO = TextFieldBloc(
    validators: [VietnameseFieldBlocValidators.required],
  );

  SondeFirstAskBloc({
    required this.procedureOnlineCubit,
  }) {
    addFieldBlocs(
      fieldBlocs: [
        yesOrNoInsulin,
        getCHO,
      ],
    );
  }

  @override
  void onSubmitting() async {
    print('onSubmitting');
    ProcedureStatus sondeStatus = yesOrNoInsulin.value == 'Yes'
        ? ProcedureStatus.yesInsulin
        : ProcedureStatus.noInsulin;
    //update sonde status
    try {
      await procedureOnlineCubit.updateProcedureStateStatus(ProcedureState(
        status: sondeStatus,
        cho: num.parse(getCHO.value),
        weight: procedureOnlineCubit.profile.weight,
      ));
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    emitSuccess();
  }
}
