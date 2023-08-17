import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/hypo_glycemia_logic/hypo_glycemia_yes_or_no_insulin_bloc.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/2_nice_button.dart';
import 'package:diabetichero_app/presentation/widgets/status/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../../logic/1_patient_blocs/3.mouth_logic/third_ask_logic/mouth_third_ask_bloc.dart';

class ThirdAskScreen extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const ThirdAskScreen({
    super.key,
    required this.mouthProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: mouthProcedureOnlineCubit,
        builder: (ct, st) {
          final formBloc = ChronicDibatesYesOrNoInsulinBloc(
              mouthProcedureOnlineCubit: mouthProcedureOnlineCubit);
          return FormBlocListener(
              formBloc: formBloc,
              onFailure: (context, state) {
                showToast('có lỗi xảy ra');
              },
              child: Column(children: [
                Text('Tiền sử ĐTĐ'),
                RadioButtonGroupFieldBlocBuilder(
                  selectFieldBloc: formBloc.yesOrNoInsulin,
                  itemBuilder: (context, value) =>
                      FieldItem(child: Text(value)),
                ),
                NiceButton(
                  text: 'Tiếp tục',
                  onTap: () {
                    formBloc.submit();
                  },
                )
              ]));
        });
  }
}
