import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetichero_app/data/models/manager/2.3_current_profile_cubit.dart';
import 'package:diabetichero_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/manager/2_profile.dart';
import '../../../logic/global/current_group/current_group_id_cubit.dart';
import '../../widgets/bars/bottom_navitgator_bar.dart';
import '../../widgets/bars/patient_navigator_bar.dart';
import '../../widgets/nice_widgets/0.1_nice_internet_screen.dart';
import 'medical_screen.dart';

// Tạo form để hiển thị thông tin của bệnh nhân
class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Các thông tin của AppBar
         flexibleSpace: PatientNavigatorBar(),
      ),
      body: NiceInternetScreen(
        child: BlocBuilder<CurrentProfileCubit, Profile>(
          builder: (context, profileState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    // Hiển thị ảnh đại diện của bệnh nhân
                    backgroundColor:  Colors.blue,
                    backgroundImage: Image.asset("assets/images/gentle_girl.jpg").image,),           
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        _buildInfoCard('Tên', profileState.name, Icons.person),
                        _buildInfoCard('Ngày sinh', shortBirthday(profileState.birthday), Icons.cake),
                        _buildInfoCard('Cân nặng', '${profileState.weight} kg', Icons.monitor_weight),
                        _buildInfoCard('Chiều cao', '${profileState.height} cm', Icons.height),
                        // Thêm các thông tin khác theo cùng một mẫu nếu cần
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }

  Widget _buildInfoCard(String title, String data, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text('$title: $data', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}


String shortBirthday(DateTime birthday) {
  String day = birthday.day.toString();
  String month = birthday.month.toString();
  String year = birthday.year.toString();
  return day + '/' + month + '/' + year;
}
