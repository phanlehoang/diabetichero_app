
//tao mouth first ask bloc từ form bloc
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../data/models/3.mouth/4.mouth_procedure_online_cubit.dart';


class MouthFirstAskBloc extends FormBloc<String, String> {
  //cubit
  final MouthProcedureOnlineCubit mouthProcedureOnlineCubit;
  //field bloc
  final fastingGlucose = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final casualGlucose = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final hba1c = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final clinicalSymptoms = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  final thirsty = SelectFieldBloc(
  );
  final polyuria = SelectFieldBloc(
  );
  final polydipsia = SelectFieldBloc(
  );
  final weightLoss = TextFieldBloc(
  );

  MouthFirstAskBloc(this.mouthProcedureOnlineCubit){
    addFieldBlocs(
      fieldBlocs: [
        fastingGlucose,
        casualGlucose,
        hba1c,
        clinicalSymptoms,
        thirsty,
        polyuria,
        polydipsia,
        weightLoss,
      ],
    );
  }
 

  @override
  void onSubmitting() async {
  

  }   
}




