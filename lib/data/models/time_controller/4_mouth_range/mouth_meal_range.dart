import 'package:diabetichero_app/data/models/time_controller/0_check_time_in_range.dart';
import 'package:diabetichero_app/data/models/time_controller/1_medical_range.dart';

class MouthMealRange extends MedicalRange {
  MouthMealRange()
      : super(ranges: [
          //3 khung gio
          //bữa sáng
          Range(HourMinute(5, 00), HourMinute(8, 00)),
          //bữa trưa
          Range(HourMinute(10, 00), HourMinute(13, 00)),
          //bữa tối
          Range(HourMinute(17, 00), HourMinute(20, 00)),
        ]);
  //waiting message
  @override
  String waitingMessage(DateTime t) {
    int indexNextRange = nextRange(t);
    String date = indexNextRange == ranges.length ? 'ngày mai' : '';
    String meal;
    switch (indexNextRange % ranges.length) {
      case 0:
        meal = 'bữa sáng';
        break;
      case 1:
        meal = 'bữa trưa';
        break;
      case 2:
        meal = 'bữa tối';
        break;
      default:
        meal = 'bữa ăn';
    }

    return 'Bạn phải đợi đến trước $meal $date cho lần điều trị insulin tác dụng nhanh tiếp theo.';
  }
}
