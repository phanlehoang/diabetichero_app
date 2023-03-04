import 'package:diabetichero_app/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/login_screen/1_login_screen.dart';
import '../../logic/status_cubit/navigator_bar_cubit.dart';
import '../screens/1_patient_screens/medical_screen.dart';
import '../screens/1_patient_screens/procedures_screens/patient_procedures_screen.dart';
import '../screens/1_patient_screens/patient_profile_screen.dart';
import '../screens/2_doctor_screens/doctor_profile_screen.dart';
import '../screens/2_doctor_screens/doctor_screen.dart';
import '../screens/3_setting_screens/setting_screen.dart';
import '../screens/export_screen.dart';

class AppRouter {
  //time check cubit

  final DoctorNavigatorBarCubit doctorNavigatorBarCubit =
      DoctorNavigatorBarCubit();
  MaterialPageRoute? onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
//home
      case ('/'):
        {
          return MaterialPageRoute(
            builder: (_) => HomeScreen(),
          );
        }
      case '/patient':
        {
          return MaterialPageRoute(
            builder: (_) => PatientMedicalScreen(),
          );
        }
      case ('/patient/procedures'):
        {
          return MaterialPageRoute(
            builder: (_) => PatientProceduresScreen(),
          );
        }
      case ('/patient/profile'):
        {
          return MaterialPageRoute(
            builder: (_) => PatientProfileScreen(),
          );
        }
      //doctor case
      case ('/doctor'):
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: doctorNavigatorBarCubit,
            child: DoctorScreen(),
          ),
        );
      case ('/doctor/profile'):
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: doctorNavigatorBarCubit,
            child: DoctorProfileScreen(),
          ),
        );
//settings
      case ('/settings'):
        return MaterialPageRoute(
          builder: (context) => SettingScreen(),
        );
//login
      case ('/login'):
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );

      default:
        return null;
    }
  }
}
//viết code
