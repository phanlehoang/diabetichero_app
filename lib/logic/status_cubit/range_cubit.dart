import 'package:flutter_bloc/flutter_bloc.dart';

class RangeCubit extends Cubit<int?> {
  RangeCubit(int? val) : super(val);

  void rangeChanged(int? range) {
    emit(range);
  }
}
