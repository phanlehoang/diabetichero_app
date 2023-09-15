import 'package:diabetichero_app/logic/global/current_group/current_group_id_cubit.dart';
import 'package:diabetichero_app/presentation/widgets/status/loading_dialog.dart';
import 'package:diabetichero_app/presentation/widgets/status/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../logic/0_home_blocs.dart/0.0.find_and_create_group_blocs/group_form_bloc.dart';

class FindGroup extends StatelessWidget {
  const FindGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupFormBloc>(
      create: (context) => GroupFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = context.watch<GroupFormBloc>();
          final currentGroupId = context.read<CurrentGroupIdCubit>();
          //value in field
          //nếu ô thay đôi thì mới update
          if (formBloc.groupId.value != '') {
            if (formBloc.state.isValid()) {
              currentGroupId.update(formBloc.groupId.value);
            } else
              currentGroupId.update('Unknown');
          }

          return FormBlocListener<GroupFormBloc, String, String>(
            onSubmitting: (context, state) {
              LoadingDialog.show(context);
            },
            onLoading: (context, state) {
              LoadingDialog.show(context);
            },
            onSuccess: (context, state) {
              LoadingDialog.hide(context);
              showToast('Đã tìm thấy nhóm');
            },
            onFailure: (context, state) {
              LoadingDialog.hide(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Có lỗi xảy ra. Vui lòng kiểm tra lại mạng.'),
                ),
              );
            },
            child: Column(
              children: [
                TextFieldBlocBuilder(
                  textFieldBloc: formBloc.groupId,
                  decoration: InputDecoration(
                    labelText: 'Tên phòng khám',
                    //hint text
                    hintText: currentGroupId.state,
                    prefixIcon: Icon(Icons.search),
                    // Create recommend button search các nhóm có sẵn
                    suffixIcon: PopupMenuButton(
                      icon: Icon(Icons.arrow_drop_down),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text('BSNT'),
                          value: 'BSNT',
                        ),
                        PopupMenuItem(
                          child: Text('Phòng 14'),
                          value: 'Phòng 14',
                        ),
                        PopupMenuItem(
                          child: Text('1234'),
                          value: '1234',
                        ),
                      ],
                      onSelected: (value) {
                        formBloc.groupId.updateValue(value);
                        currentGroupId.update(value);
                      },
                    ),
                  ),
                ),
                Text('Mã nhóm hiện tại là: ' + currentGroupId.state),
              ],
            ),
          );
        },
      ),
    );
  }
}
