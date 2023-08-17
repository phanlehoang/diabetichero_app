//tạo 1 class có tên là HyoGlycemiaYesOrNoInsulinBloc kế thừa từ FormBloc
import 'package:diabetichero_app/data/models/3.mouth/1.mouth_regimen.dart';
import 'package:diabetichero_app/data/models/3.mouth/3.mouth_procedure_cubit.dart';
import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class ChronicDibatesYesOrNoInsulinBloc extends FormBloc<String, String> {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  final yesOrNoInsulin = SelectFieldBloc(
    items: [
      'ĐTĐ Tuyp 1 hoặc ĐTĐ Tuyp 2 tiêm insulin',
      'ĐTĐ Tuyp 2 không tiêm insulin',
    ],
    validators: [VietnameseFieldBlocValidators.required],
  );
  ChronicDibatesYesOrNoInsulinBloc({
    required this.mouthProcedureOnlineCubit,
  }) {
    addFieldBlocs(fieldBlocs: [
      yesOrNoInsulin,
    ]);
  }
  //submit
  @override
  void onSubmitting() async {
    try {
      switch (yesOrNoInsulin.value) {
        case 'ĐTĐ Tuyp 1 hoặc ĐTĐ Tuyp 2 tiêm insulin':
          //b1: tạo regimen tên là HypoGlycemiaYesOrNoInsulin
          MouthRegimen mouthRegimen = MouthRegimen(
            name: 'Phác đồ type 1 hoặc type 2 tiêm insulin',
            beginTime: DateTime.now(),
            weight: mouthProcedureOnlineCubit.profile.weight,
            symptoms: {},
            medicalActions: [],
            healthConditions: [],
          );
          //b2: gửi regimen acute hyper glycemia lên server
          mouthProcedureOnlineCubit.addMouthRegimen(mouthRegimen);
          mouthProcedureOnlineCubit.updateProcedureStatus(
              MouthProcedureStatus.in_or_out_patient_ask);
          emitSuccess();
          break;
        case 'ĐTĐ Tuyp 2 không tiêm insulin':
          //làm tương tự như trên nhưng thay YesInsulin thành NoInsulin
          MouthRegimen mouthRegimen = MouthRegimen(
            name: 'phác đồ type 2 không tiêm insulin',
            beginTime: DateTime.now(),
            weight: mouthProcedureOnlineCubit.profile.weight,
            symptoms: {},
            medicalActions: [],
            healthConditions: [],
          );
          //b2: gửi regimen acute hyper glycemia lên server
          mouthProcedureOnlineCubit.addMouthRegimen(mouthRegimen);
          mouthProcedureOnlineCubit.updateProcedureStatus(
              MouthProcedureStatus.in_or_out_patient_ask);
          emitSuccess();
          break;
        default:
      }
    } catch (e) {
      emitFailure();
    }
  }
}
