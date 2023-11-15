//lam trang hoi chan noi tiet
import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/0.medical/medical_action/3_medical_take_insulin.dart';
import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/endocrine_conference_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../widgets/nice_widgets/2_nice_button.dart';

class EndocrineConferenceScreen extends StatelessWidget {
  //them procedure online cubit
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  const EndocrineConferenceScreen({
    Key? key,
    required this.mouthProcedureOnlineCubit,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Hội chẩn nội tiết'),
        //tao nut bam
        SizedBox(
          height: 20,
        ),
        // CHo endocrine conference logic bloc vào form bloc
        // tao nut bam
        BlocProvider<EndocrineConferenceBloc>(
            create: (context) => EndocrineConferenceBloc(
                  mouthProcedureOnlineCubit: mouthProcedureOnlineCubit,
                ),
            child: Builder(
              builder: (context) {
                final formBloc = context.read<EndocrineConferenceBloc>();
                return FormBlocListener<EndocrineConferenceBloc, String, String>(
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
                        Text('Tiếp tục điều trị bệnh nhân'),
                        RadioButtonGroupFieldBlocBuilder(
                        selectFieldBloc: formBloc.yesNo,
                        itemBuilder: (context, value) =>
                        FieldItem(child: Text(value)),
                        ),
                        // Thêm button xác nhận
                        NiceButton(
                        text: 'Xác nhận',
                        onTap: () {
                    formBloc.submit();
                  },
                )
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
