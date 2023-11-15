//tạo 1 class có tên là HyoGlycemiaYesOrNoInsulinBloc kế thừa từ FormBloc
import 'package:diabetichero_app/data/models/3.mouth/1.mouth_regimen.dart';
import 'package:diabetichero_app/data/models/3.mouth/3.mouth_procedure_cubit.dart';
import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:diabetichero_app/presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class HypoGlycemiaYesOrNoInsulinBloc extends FormBloc<String, String> {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  final yesOrNoInsulin = SelectFieldBloc(
    items: [
      'ĐTĐ Tuyp 1 hoặc ĐTĐ Tuyp 2 tiêm insulin',
      'ĐTĐ Tuyp 2 không tiêm insulin',
    ],
    validators: [VietnameseFieldBlocValidators.required],
  );
  HypoGlycemiaYesOrNoInsulinBloc({
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
            name:
                'Phác đồ dành cho BN có nguy cơ hạ đường huyết, có tiền sử tiêm insulin',
            beginTime: DateTime.now(),
            weight: mouthProcedureOnlineCubit.profile.weight,
            symptoms: {},
            medicalActions: [],
            healthConditions: [], status: MouthProcedureStatus.hypoGlycemiaYesInsulin ,
          );
          //b2: gửi regimen acute hyper glycemia lên server
          mouthProcedureOnlineCubit.addMouthRegimen(mouthRegimen);
          mouthProcedureOnlineCubit.updateProcedureStatus(
              MouthProcedureStatus.hypoGlycemiaYesInsulin);
          emitSuccess();
          break;
        case 'ĐTĐ Tuyp 2 không tiêm insulin':
          //làm tương tự như trên nhưng thay YesInsulin thành NoInsulin
          MouthRegimen mouthRegimen = MouthRegimen(
            name:
                'Phác đồ dành cho BN có nguy cơ hạ đường huyết, không có tiền sử tiêm insulin',
            beginTime: DateTime.now(),
            weight: mouthProcedureOnlineCubit.profile.weight,
            symptoms: {},
            medicalActions: [],
            healthConditions: [], status: MouthProcedureStatus.hypoGlycemiaNoInsulin,
          );
          //b2: gửi regimen acute hyper glycemia lên server
          mouthProcedureOnlineCubit.addMouthRegimen(mouthRegimen);
          mouthProcedureOnlineCubit.updateProcedureStatus(
              MouthProcedureStatus.hypoGlycemiaNoInsulin);
          emitSuccess();
          break;
        default:
      }
    } catch (e) {
      emitFailure();
    }
  }
}
