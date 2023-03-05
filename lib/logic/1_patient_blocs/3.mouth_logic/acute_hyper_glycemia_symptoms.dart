class AcuteHyperGlycemiaCheck {
  num fastingGlucose; //dđuong mau luc doi mmol/L
  num casualGlucose; //dđuong mau luc bat ki mmol/L
  num hba1c; //tinh theo phan tram
  bool thirsty; //khát
  bool polyuria; //nhiều nước tiểu
  bool polydipsia; //nhiều nước uống
  bool weightLoss; //sut can
  bool clinicalSymptoms; //triệu chứng laâm sàng của tiểu đường
  AcuteHyperGlycemiaCheck({
    required this.fastingGlucose,
    required this.casualGlucose,
    required this.hba1c,
    this.thirsty = false,
    this.polyuria = false,
    this.polydipsia = false,
    this.weightLoss = false,
    required this.clinicalSymptoms,
  });
  bool get isAcuteHyperGlycemia {
    //triệu chứng laâm sàng của tiểu đường
    //neêếu >=2 trong 4 bieên bool = true
    //thì coi như có triệu chứng laâm sàng của tiểu đường

    if (fastingGlucose > 13.9 ||
        casualGlucose > 16.7 ||
        hba1c > 10 ||
        clinicalSymptoms == true) {
      return true;
    } else {
      return false;
    }
  }
}
