import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../../../logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_take_meal_bloc.dart';

class MealSubmit extends StatelessWidget {
  const MealSubmit({
    super.key,
    required this.mouthProcedureOnlineCubit,
  });

  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocProvider(
            create: (ct2) => MouthTakeMealBloc(
                  mouthProcedureOnlineCubit: mouthProcedureOnlineCubit,
                ),
            child: Builder(
              builder: (ct3) {
                final bloc = BlocProvider.of<MouthTakeMealBloc>(ct3);
                return FormBlocListener<MouthTakeMealBloc, String, String>(
                  onSubmitting: (ct4, st4) => CircularProgressIndicator(),
                  onSuccess: (ct4, st4) => Text('Đã lưu'),
                  onFailure: (ct4, st4) => Text('Lỗi'),
                  child: Column(
                    children: [
                      TextFieldBlocBuilder(
                        // bổ sung thêm text cố định 'Luogwj ăn'
                        textFieldBloc: bloc.description,
                        decoration: InputDecoration(
                          labelText: 'Mô tả lượng ăn',
                          prefixText: 'Lượng ăn ',
                          prefixIcon: Icon(Icons.food_bank),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          bloc.submit();
                        },
                        child: Text('Bắt đầu ăn'),
                      ),
                    ],
                  ),
                );
              },
            )),
      ],
    );
  }
}
