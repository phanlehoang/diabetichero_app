import 'package:diabetichero_app/data/models/time_controller/0_check_time_in_range.dart';
import 'package:diabetichero_app/data/models/time_controller/1_medical_range.dart';

class DaySegmentRange extends MedicalRange {
  DaySegmentRange()
      : super(ranges: [
          //3 khung gio
          //bữa sáng
          Range(HourMinute(5, 00), HourMinute(8, 00)),
          //bữa trưa
          Range(HourMinute(10, 00), HourMinute(13, 00)),
          //bữa chiều
          Range(HourMinute(17, 00), HourMinute(21, 00)),
          //21h - 23h
          Range(HourMinute(21, 00), HourMinute(23, 00)),
        ]);
  //waiting message
  @override
  String waitingMessage(DateTime t) {
    int indexNextRange = nextRange(t);
    String date = indexNextRange == ranges.length ? 'ngày mai' : '';
    String meal;
    switch (indexNextRange % ranges.length) {
      case 0:
        meal = 'buổi sáng';
        break;
      case 1:
        meal = 'buổi trưa';
        break;
      case 2:
        meal = 'buổi chiều';
        break;
      case 3:
        meal = 'buổi tối';
        break;
      default:
        meal = 'buổi';
    }

    return 'Bạn phải đợi đến $meal $date cho lần điều trị tiếp theo.';
  }
}
