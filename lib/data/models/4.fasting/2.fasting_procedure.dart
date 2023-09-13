import 'package:flutter/material.dart';

import '../0.medical/7_medical_procedure.dart';

class FastingProcedure extends MedicalProcedure {
  String status;
  FastingProcedure(
      {this.status = 'ok',
      required super.beginTime,
      required super.state,
      required super.regimens})
      : super(
          name: 'FastingProcedure',
        );
  static Widget get officialName {
    return Text('Phác đồ cho bệnh nhân ĐTĐ nhịn ăn hoàn toàn',
        //bôi đậm
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
  }
  //1. attributes
}
