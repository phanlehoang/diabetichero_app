import 'package:diabetichero_app/data/models/time_controller/4_mouth_range/mouth_meal_range.dart';

class HyperGlycemiaYesInsulinRange extends MouthMealRange {
  //viết lại waitingMessage
  @override
  String waitingMessage(DateTime t) {
    String oldMessage = super.waitingMessage(t);
    //xóa 'insulin tác dụng nhanh'
    return oldMessage.replaceAll('insulin tác dụng nhanh', '');
  }
}

class HyperGlycemiaNoInsulinRange extends MouthMealRange {
  //viết lại waitingMessage
  @override
  String waitingMessage(DateTime t) {
    String oldMessage = super.waitingMessage(t);
    //xóa 'insulin tác dụng nhanh'
    return oldMessage.replaceAll('điều trị insulin tác dụng nhanh', 'thử ĐMMM');
  }
}
