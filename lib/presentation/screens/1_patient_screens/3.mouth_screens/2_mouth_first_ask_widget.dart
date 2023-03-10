import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/first_ask_logic/mouth_first_ask_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../data/models/medical/6_procedure_state.dart';
import '../../../../logic/1_patient_blocs/2.tpn_logic/tpn_first_ask_bloc.dart';
import '../../../widgets/nice_widgets/1_nice_container.dart';
import '../../../widgets/nice_widgets/2_nice_button.dart';

class MouthFirstAskWidget extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const MouthFirstAskWidget({
    Key? key,
    required this.mouthProcedureOnlineCubit,
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
        BlocProvider<MouthFirstAskBloc>(
            create: (context) => MouthFirstAskBloc(
                  mouthProcedureOnlineCubit: mouthProcedureOnlineCubit,
                ),
            child: Builder(
              builder: (context) {
                final formBloc = context.read<MouthFirstAskBloc>();
                return FormBlocListener<MouthFirstAskBloc, String, String>(
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
                        Text(
                            'Ki???m tra c??c ti??u chu???n t??ng ???????ng huy???t c???p t??nh'),
                        TextFieldBlocBuilder(
                            textFieldBloc: formBloc.fastingGlucose,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'L?????ng glucose l??c ????i (mmol/L)',
                              prefixIcon:
                                  //icon for gi???t n?????c
                                  Icon(Icons.water_drop),
                            )),
                        TextFieldBlocBuilder(
                            textFieldBloc: formBloc.casualGlucose,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'L?????ng glucose m??u b???t k?? (mmol/L)',
                              prefixIcon:
                                  //icon for gi???t n?????c
                                  Icon(Icons.water_drop_sharp),
                            )),
                        TextFieldBlocBuilder(
                            textFieldBloc: formBloc.hba1c,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'HbA1c (%)',
                              prefixIcon:
                                  //icon for x??t nghi???m
                                  Icon(Icons.medical_services),
                            )),
                        Text('C??c tri???u ch???ng l??m s??ng'),
                        //t???o ??? d???ng checkbox
                        CheckboxFieldBlocBuilder(
                          booleanFieldBloc: formBloc.thirsty,
                          body: Text('Kh??t n?????c'),
                          //mac dinh la false
                        ),
                        CheckboxFieldBlocBuilder(
                          booleanFieldBloc: formBloc.polyuria,
                          body: Text('Ti???u nhi???u'),
                        ),
                        CheckboxFieldBlocBuilder(
                          booleanFieldBloc: formBloc.polydipsia,
                          body: Text('U???ng nhi???u'),
                        ),
                        CheckboxFieldBlocBuilder(
                          booleanFieldBloc: formBloc.weightLoss,
                          body: Text('S???t c??n'),
                        ),
                        NiceButton(
                          onTap: formBloc.submit,
                          text: 'Ti???p t???c',
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
