//lam trang hoi chan noi tiet
import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/0.medical/medical_action/3_medical_take_insulin.dart';
import 'package:flutter/material.dart';

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
        Text('Hội chận nội tiết'),
        //tao nut bam
        Text('Tiếp tục điều trị bệnh nhân'),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: Text('Có')),
            SizedBox(
              width: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  //  hiển thị thông báo :"Kết thúc điều trị bệnh nhân"//
                  showDialog(
                      context: context,
                      builder: (BuildContext) {
                        return AlertDialog(
                          title: Text('Kết thúc điều trị bệnh nhân'),
                          content: Text(
                              'Bạn có chắc chắn muốn kết thúc điều trị bệnh nhân này không?'),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  // hiển thị thông báo :"Kết thúc điều trị bệnh nhân"//
                                  // kết thúc phác đồ
                                  Navigator.of(context).pop();
                                },
                                child: Text('Có')),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Không')),
                          ],
                        );
                      });
                },
                child: Text('Không')),
          ],
        ),
      ],
    );
  }
}
