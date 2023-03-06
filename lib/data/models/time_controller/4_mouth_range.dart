import 'package:diabetichero_app/data/models/time_controller/1_medical_range.dart';

import '0_check_time_in_range.dart';

class MouthSlowInsulinRange extends MedicalRange {
  MouthSlowInsulinRange()
      : super(ranges: [
          //4 khung gio
          //21h30 - 22h30
          Range(HourMinute(21, 00), HourMinute(23, 00)),
        ]);
  //waiting message
  @override
  String waitingMessage(DateTime t) {
    int indexNextRange = nextRange(t);
    int h = ranges[indexNextRange % ranges.length].start.hour;
    int m = ranges[indexNextRange % ranges.length].start.minute;
    String date = indexNextRange == ranges.length ? 'ngày mai' : '';
    //lay nice date time

    String formattedTime =
        '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';

    return 'Bạn phải đợi đến $formattedTime $date cho lần tiêm insulin chậm tiếp theo.';
  }
}

class MouthFastInsulinRange extends MedicalRange {
  MouthFastInsulinRange()
      : super(ranges: [
          //3 khung gio
          //bữa sáng
          Range(HourMinute(5, 00), HourMinute(10, 00)),
          //bữa trưa
          Range(HourMinute(10, 00), HourMinute(15, 00)),
          //bữa tối
          Range(HourMinute(17, 00), HourMinute(23, 00)),
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
    return 'Bạn phải đợi đến $meal $date cho lần tiêm insulin chậm tiếp theo.';
  }
}
