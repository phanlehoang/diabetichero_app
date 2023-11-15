import 'dart:async';

import 'package:diabetichero_app/data/models/3.mouth/4.mouth_procedure_online_cubit.dart';
import 'package:diabetichero_app/data/models/enum/enums.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EndocrineConferenceBloc extends FormBloc<String, String> {
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  final yesNo = SelectFieldBloc(
    items: ['Có', 'Không'],
  );


  EndocrineConferenceBloc({required this.mouthProcedureOnlineCubit}) : super() {
    addFieldBlocs(
      fieldBlocs: [
        yesNo,
      ],
    );
  }
  //2 lua chon co hoac khong
@override
FutureOr<void> onSubmitting() async {
  // Nếu yes
  if (yesNo.value == 'Có') {
    // B1: Lấy thông tin regimen cuối cùng từ Cubit
    final mouthProcedure = mouthProcedureOnlineCubit.state;
    final lastRegimen = mouthProcedure.regimens.last;

    // B2: Tính toán startingPoint mới
    final startingPoint = lastRegimen.medicalActions.length;

    // B3: Cập nhật startingPoint và trạng thái qua Cubit
    // Đảm bảo rằng mouthProcedureOnlineCubit có phương thức để cập nhật startingPoint
    await mouthProcedureOnlineCubit.updateStartingPoint(startingPoint);

    // B4: Nếu cần thiết, cập nhật trạng thái
    final lastStatus = lastRegimen.status ?? MouthProcedureStatus.baseBolus; // Giả sử trạng thái mặc định
    await mouthProcedureOnlineCubit.updateProcedureStatus(lastStatus);

    // B5: Thông báo thành công cho FormBloc để hoàn tất quy trình
    emitSuccess(canSubmitAgain: true); // canSubmitAgain có thể được set thành true hoặc false tùy vào logic của bạn
  } else {
    // Nếu không, thông báo thành công mà không cần thực hiện thay đổi nào
    emitSuccess(canSubmitAgain: false);
  }
}

}

