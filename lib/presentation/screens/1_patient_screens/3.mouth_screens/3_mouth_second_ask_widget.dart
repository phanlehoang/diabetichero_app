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
                        Text('Ki???m tra c??c ti??u chu???n nguy c?? h??? ???????ng huy???t'),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.cognitiveImpairment,
                            body: Text('Sa s??t tr?? tu???')),
                        Text('M???c b???nh n???i khoa n???ng ho???c b???nh giai ??o???n cu???i'),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.dialysis,
                            body: Text('B???nh th???n m???n c?? ch??? ?????nh l???c m??u')),

                        // bool cirrhosis; //x?? gan
                        // bool metastaticCancer; //ung th?? di c??n
                        // bool heartFailureHyperTension; //suy tim xung huy???t
                        // bool stroke;
                        // bool alcoholicDementia; //s???ng r?????u
                        // bool otherSeriousDisease; //benh khac
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.cirrhosis,
                            body: Text('X?? gan')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.metastaticCancer,
                            body: Text('Ung th?? di c??n')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.heartFailureHyperTension,
                            body: Text('Suy tim xung huy???t')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.stroke,
                            body: Text('Tai bi???n m???ch m??u n??o')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.alcoholicDementia,
                            body: Text('S???ng r?????u')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.otherSeriousDisease,
                            body: Text('B???nh kh??c')),
                        Text(
                            'BN tr??n 65 tu???i c?? r???i lo???n >=2/5 c??c ho???t ?????ng c?? b???n h???ng ng??y'),
                        //t???m r???a, ??n u???ng, v??? sinh c?? nh??n, di chuy???n, ??i l???i, v???n ?????ng, n??i chuy???n, gi???i tr??
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.bathDisfunction,
                            body: Text('T???m r???a')),
                        //thay qu???n ??o
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.dressingDisfunction,
                            body: Text('Thay qu???n ??o')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.eatingDisfunction,
                            body: Text('??n u???ng')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc:
                                formBloc.personalHygieneDisfunction,
                            body: Text('V??? sinh c?? nh??n')),
                        CheckboxFieldBlocBuilder(
                            booleanFieldBloc: formBloc.mobileDisfunction,
                            body: Text('Di chuy???n')),

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
