import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetichero_app/authentication/login_screen/1_login_screen.dart';
import 'package:diabetichero_app/logic/status_cubit/navigator_bar_cubit.dart';
import 'package:diabetichero_app/presentation/screens/3_setting_screens/remember_login_cubit.dart';
import 'package:diabetichero_app/presentation/screens/3_setting_screens/warning_reference_form.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:diabetichero_app/presentation/widgets/status/loading_dialog.dart';
import 'package:diabetichero_app/presentation/widgets/status/reference_warning_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/manager/doctor/current_doctor.dart';
import '../../widgets/bars/bottom_navitgator_bar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RememberLoginCubit rememberLoginCubit =
        context.read<RememberLoginCubit>();
    final oldContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cài đặt'),
      ),
      body: Column(
        children: [
          // ReferenceWarningWidget(),
          WarningReferenceForm(),
        ],
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}
