import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/first_ask_logic/mouth_first_ask_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

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
                            'Kiểm tra các tiêu chuẩn tăng đường huyết cấp tính'),
                        TextFieldBlocBuilder(
                            textFieldBloc: formBloc.fastingGlucose,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Lượng glucose lúc đói (mmol/L)',
                              prefixIcon:
                                  //icon for giọt nước
                                  Icon(Icons.water_drop),
                            )),
                        TextFieldBlocBuilder(
                            textFieldBloc: formBloc.casualGlucose,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Lượng glucose máu bất kì (mmol/L)',
                              prefixIcon:
                                  //icon for giọt nước
                                  Icon(Icons.water_drop_sharp),
                            )),
                        TextFieldBlocBuilder(
                            textFieldBloc: formBloc.hba1c,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'HbA1c (%)',
                              prefixIcon:
                                  //icon for xét nghiệm
                                  Icon(Icons.medical_services),
                            )),
                        Text('Các triệu chứng lâm sàng'),
                        //tạo ở dạng checkbox
                        CheckboxFieldBlocBuilder(
                          booleanFieldBloc: formBloc.thirsty,
                          body: Text('Khát nước'),
                          //mac dinh la false
                        ),
                        CheckboxFieldBlocBuilder(
                          booleanFieldBloc: formBloc.polyuria,
                          body: Text('Tiểu nhiều'),
                        ),
                        CheckboxFieldBlocBuilder(
                          booleanFieldBloc: formBloc.polydipsia,
                          body: Text('Uống nhiều'),
                        ),
                        CheckboxFieldBlocBuilder(
                          booleanFieldBloc: formBloc.weightLoss,
                          body: Text('Sụt cân'),
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
