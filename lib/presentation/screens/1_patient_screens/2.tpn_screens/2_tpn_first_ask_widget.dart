import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../data/models/medical/6_procedure_state.dart';
import '../../../../logic/1_patient_blocs/2.tpn_logic/tpn_first_ask_bloc.dart';
import '../../../widgets/nice_widgets/1_nice_container.dart';
import '../../../widgets/nice_widgets/2_nice_button.dart';

class TPNFirstAskWidget extends StatelessWidget {
  final procedureOnlineCubit;
  const TPNFirstAskWidget({
    Key? key,
    required this.procedureOnlineCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // BlocBuilder(
        //   bloc: sondeProcedureOnlineCubit,
        //   builder: (context, state) {
        //     return Text(state.toString());
        //   },
        // ),
        //first ask form
        BlocProvider<TPNFirstAskBloc>(
            create: (context) => TPNFirstAskBloc(
                  procedureOnlineCubit: procedureOnlineCubit,
                ),
            child: Builder(
              builder: (context) {
                final formBloc = context.read<TPNFirstAskBloc>();
                return FormBlocListener<TPNFirstAskBloc, String, String>(
                  onSubmitting: (context, state) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  //fail
                  onFailure: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('error'),
                      ),
                    );
                  },
                  onSuccess: (context, state) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('success'),
                      ),
                    );
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('BN có tiền sử tiêm insulin không?'),
                        RadioButtonGroupFieldBlocBuilder(
                          selectFieldBloc: formBloc.yesOrNoInsulin,
                          itemBuilder: (context, value) =>
                              FieldItem(child: Text(value)),
                        ),
                        NiceButton(
                          onTap: formBloc.submit,
                          text: 'Tiếp tục',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ))
      ],
    );
  }
}
