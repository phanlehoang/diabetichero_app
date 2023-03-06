import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/first_ask_logic/mouth_first_ask_bloc.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/second_ask_logic/mouth_second_ask_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../data/models/medical/6_procedure_state.dart';
import '../../../../logic/1_patient_blocs/2.tpn_logic/tpn_first_ask_bloc.dart';
import '../../../widgets/nice_widgets/1_nice_container.dart';
import '../../../widgets/nice_widgets/2_nice_button.dart';

class MouthSecondAskWidget extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const MouthSecondAskWidget({
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
        BlocProvider<MouthSecondAskBloc>(
            create: (context) => MouthSecondAskBloc(
                  mouthProcedureOnlineCubit: mouthProcedureOnlineCubit,
                ),
            child: Builder(
              builder: (context) {
                final formBloc = context.read<MouthSecondAskBloc>();
                return FormBlocListener<MouthSecondAskBloc, String, String>(
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
                        Text('Kiểm tra các tiêu chuẩn nguy cơ hạ đường huyết'),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.cognitiveImpairment,
                            body: Text('Sa sút trí tuệ')),
                        Text('Mắc bệnh nội khoa nặng hoặc bệnh giai đoạn cuối'),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.dialysis,
                            body: Text('Bệnh thận mạn có chỉ định lọc máu')),

                        // bool cirrhosis; //xơ gan
                        // bool metastaticCancer; //ung thư di căn
                        // bool heartFailureHyperTension; //suy tim xung huyết
                        // bool stroke;
                        // bool alcoholicDementia; //sảng rượu
                        // bool otherSeriousDisease; //benh khac
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.cirrhosis,
                            body: Text('Xơ gan')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.metastaticCancer,
                            body: Text('Ung thư di căn')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.heartFailureHyperTension,
                            body: Text('Suy tim xung huyết')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.stroke,
                            body: Text('Tai biến mạch máu não')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.alcoholicDementia,
                            body: Text('Sảng rượu')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.otherSeriousDisease,
                            body: Text('Bệnh khác')),
                        Text(
                            'BN trên 65 tuổi có rối loạn >=2/5 các hoạt động cơ bản hằng ngày'),
                        //tắm rửa, ăn uống, vệ sinh cá nhân, di chuyển, đi lại, vận động, nói chuyện, giải trí
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.bathDisfunction,
                            body: Text('Tắm rửa')),
                        //thay quần áo
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.dressingDisfunction,
                            body: Text('Thay quần áo')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.eatingDisfunction,
                            body: Text('Ăn uống')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc:
                                formBloc.personalHygieneDisfunction,
                            body: Text('Vệ sinh cá nhân')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.mobileDisfunction,
                            body: Text('Di chuyển')),

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
