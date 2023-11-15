//tạo 1 class có tên là HyoGlycemiaYesOrNoInsulinBloc kế thừa từ FormBloc
import 'package:diabetichero_app/data/models/3.mouth/1.mouth_regimen.dart';
import 'package:diabetichero_app/data/models/3.mouth/3.mouth_procedure_cubit.dart';
import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class InpatientOrOutpatientAskBloc extends FormBloc<String, String> {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  final inOrOutPatient = SelectFieldBloc(
    items: [
      'Nội trú',
      'Ngoại trú',
    ],
    validators: [VietnameseFieldBlocValidators.required],
  );
  InpatientOrOutpatientAskBloc({
    required this.mouthProcedureOnlineCubit,
  }) {
    addFieldBlocs(fieldBlocs: [
      inOrOutPatient,
    ]);
  }
  //submit
  @override
  void onSubmitting() async {
    try {
      switch (inOrOutPatient.value) {
        case 'Nội trú':
          //b1: tạo regimen tên là HypoGlycemiaYesOrNoInsulin
          MouthRegimen mouthRegimen = MouthRegimen(
            name: 'Phác đồ nội trú',
            beginTime: DateTime.now(),
            weight: mouthProcedureOnlineCubit.profile.weight,
            symptoms: {},
            medicalActions: [],
            healthConditions: [], status: MouthProcedureStatus.inpatient,
          );
          //b2: gửi regimen acute hyper glycemia lên server
          mouthProcedureOnlineCubit.addMouthRegimen(mouthRegimen);
          mouthProcedureOnlineCubit
              .updateProcedureStatus(MouthProcedureStatus.inpatient);
          emitSuccess();
          break;
        default:
          //làm tương tự như trên nhưng thay YesInsulin thành NoInsulin
          MouthRegimen mouthRegimen = MouthRegimen(
            name: 'Phác đồ ngoại trú',
            beginTime: DateTime.now(),
            weight: mouthProcedureOnlineCubit.profile.weight,
            symptoms: {},
            medicalActions: [],
            healthConditions: [], status: MouthProcedureStatus.outpatient,
          );
          //b2: gửi regimen acute hyper glycemia lên server
          mouthProcedureOnlineCubit.addMouthRegimen(mouthRegimen);
          mouthProcedureOnlineCubit
              .updateProcedureStatus(MouthProcedureStatus.outpatient);
          emitSuccess();
          break;
      }
    } catch (e) {
      emitFailure();
    }
  }
}
