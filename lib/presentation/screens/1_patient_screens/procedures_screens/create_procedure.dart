//create procedure screen
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetichero_app/data/models/manager/2_profile.dart';
import 'package:diabetichero_app/data/models/manager/2.3_current_profile_cubit.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/2_nice_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../logic/1_patient_blocs/create_procedure_bloc.dart';
import '../../../widgets/nice_widgets/0_nice_screen.dart';
import '../../../widgets/status/loading_dialog.dart';

class CreateProcedure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NiceScreen(
      child: BlocProvider<CreateProcedureFormBloc>(
        create: (context) => CreateProcedureFormBloc(
            profile: BlocProvider.of<CurrentProfileCubit>(context).state),
        child: CreateProcedureForm(),
      ),
    );
  }
}

class CreateProcedureForm extends StatelessWidget {
  const CreateProcedureForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBlocListener<CreateProcedureFormBloc, String, String>(
        onSubmitting: (context, state) => LoadingDialog.show(context),
        onSubmissionFailed: (context, state) => LoadingDialog.hide(context),
        onSuccess: (context, state) {
          LoadingDialog.hide(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tạo phác đồ thành công'),
            ),
          );
        },
        onFailure: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failure'),
            ),
          );
        },
        child: Column(
          children: [
            //choice
            DropdownFieldBlocBuilder(
              selectFieldBloc: context.watch<CreateProcedureFormBloc>().method,
              itemBuilder: (context, value) => FieldItem(
                child: Text(value),
              ),
              decoration: const InputDecoration(
                labelText: 'Chọn phương pháp điều trị',
                prefixIcon: Icon(Icons.medical_services_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            //submit button
            NiceButton(
              text: 'Tạo phác đồ',
              onTap: () => context.read<CreateProcedureFormBloc>().submit(),
            ),
          ],
        ));
  }
}
