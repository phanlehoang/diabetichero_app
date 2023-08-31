import 'package:diabetichero_app/logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_fast_insulin_guide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../../../data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import '../../../../../../logic/1_patient_blocs/3.mouth_logic/acute_hyper_glycemia_logic/mouth_slow_insulin_guide.dart';
import '../../../../../../logic/1_patient_blocs/3.mouth_logic/mouth_take_fast_insulin_bloc.dart';
import '../../../../../../logic/1_patient_blocs/3.mouth_logic/mouth_take_slow_insulin_bloc.dart';
import '../../../../../widgets/nice_widgets/2_nice_button.dart';

class MouthRealFastInsulin extends StatelessWidget {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  final logicGuide;
  const MouthRealFastInsulin({
    super.key,
    required this.logicGuide,
    required this.mouthProcedureOnlineCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Thực tế tiêm'),
        //1 form điền từ mouth take slow insulin bloc
        BlocProvider(
          create: (_) => MouthTakeFastInsulinBloc(
            logicGuide: logicGuide,
            mouthProcedureOnlineCubit: mouthProcedureOnlineCubit,
          ),
          child: Builder(builder: (ct) {
            final formBloc = BlocProvider.of<MouthTakeFastInsulinBloc>(ct);
            return FormBlocListener(
              formBloc: formBloc,
              onSuccess: (context, state) {
                //
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Success'),
                  ),
                );
              },
              onFailure: (context, state) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failure'),
                  ),
                );
              },
              child: Column(
                children: [
                  TextFieldBlocBuilder(
                    textFieldBloc: formBloc.insulinUI,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Insulin UI',
                      prefixIcon: Icon(Icons.medical_services),
                    ),
                  ),
                  //lựa chọn ở dạng cuốn
                  DropdownFieldBlocBuilder(
                    selectFieldBloc: formBloc.insulinType,
                    itemBuilder: (context, value) => FieldItem(
                      child: Text(value),
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Chọn loại insulin nhanh',
                      prefixIcon: Icon(Icons.medical_services_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  NiceButton(
                    onTap: formBloc.submit,
                    text: 'Tiếp tục',
                  ),
                ],
              ),
            );
          }),
        )
      ],
    );
  }
}
