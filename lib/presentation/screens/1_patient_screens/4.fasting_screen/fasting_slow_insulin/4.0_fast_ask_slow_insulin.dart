import 'package:diabetichero_app/logic/1_patient_blocs/4.fasting_logic/choose_slow_insulin_fasting_bloc.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/2_nice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../../data/models/4.fasting/3.fasting_procedure_online.dart';

class FastingAskSlowInsulin extends StatelessWidget {
  final FastingProcedureOnlineCubit fastingProcedureOnlineCubit;
  const FastingAskSlowInsulin({
    Key? key,
    required this.fastingProcedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChooseSlowInsulinFastingFormBloc(
          fastingProcedureOnlineCubit: fastingProcedureOnlineCubit),
      child: Builder(
        builder: (ct) {
          final ChooseSlowInsulinFastingFormBloc chooseSlowInsulinFormBloc =
              ct.read<ChooseSlowInsulinFastingFormBloc>();
          return BlocBuilder(
            bloc: chooseSlowInsulinFormBloc,
            builder: (ct1, st1) {
              return Column(
                children: [
                  //Text('Chon loai tiem cham'),
                  FormBlocListener(
                    formBloc: chooseSlowInsulinFormBloc,
                    onSubmitting: (ct, st) {
                      //LoadingDialog.show(ct);
                    },
                    onSuccess: (ct, st) {
                      // LoadingDialog.hide(ct);
                      ScaffoldMessenger.of(ct).showSnackBar(
                        SnackBar(
                          content: Text('Success'),
                        ),
                      );
                    },
                    onFailure: (ct, st) => {
                      // LoadingDialog.hide(ct),
                      ScaffoldMessenger.of(ct).showSnackBar(
                        SnackBar(
                          content: Text('Failure'),
                        ),
                      ),
                    },
                    child: Column(children: [
                      RadioButtonGroupFieldBlocBuilder(
                        selectFieldBloc: chooseSlowInsulinFormBloc.slowInsulin,
                        itemBuilder: (context, value) =>
                            FieldItem(child: Text(value)),
                        decoration: const InputDecoration(
                            labelText: 'Loai insulin', prefixIcon: SizedBox()),
                      ),
                      NiceButton(
                        onTap: chooseSlowInsulinFormBloc.submit,
                        text: 'Xác nhận',
                      ),
                    ]),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
