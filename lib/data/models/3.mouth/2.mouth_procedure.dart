// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:flutter/material.dart';

import '1.mouth_regimen.dart';

class MouthProcedure {
  String name = 'MouthProcedure';
  List<MouthRegimen> regimens;
  DateTime beginTime;
  MouthProcedureStatus status;
  MouthProcedure({
    required this.name,
    required this.regimens,
    required this.beginTime,
    required this.status,
  });
  DateTime get lastTime {
    if (regimens.length == 0) {
      return beginTime;
    }
    return regimens.last.lastTime;
  }

  bool get isFull50 {
    if (regimens.length == 0) {
      return false;
    }
    return regimens.last.isFull50;
  }

  //toString
  @override
  String toString() {
    return ''' MouthProcedure{name: $name, 
    regimens: $regimens, beginTime: $beginTime, status: $status}
    ''';
  }

  Map<String, dynamic> get toDataMap {
    final map1 = {
      'name': name,
      'beginTime': beginTime,
      'status': EnumToString.enumToString(status),
    };
    return map1;
  }

  static Widget get officialName {
    return Text('Phác đồ cho bệnh nhân ĐTĐ nuôi dưỡng qua đường miệng',
        //bôi đậm
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
  }
}
