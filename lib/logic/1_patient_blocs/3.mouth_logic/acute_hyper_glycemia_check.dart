class AcuteHyperGlycemiaCheck {
  num fastingGlucose; //dđuong mau luc doi mmol/L
  num casualGlucose; //dđuong mau luc bat ki mmol/L
  num hba1c; //tinh theo phan tram
  bool thirsty; //khát
  bool polyuria; //nhiều nước tiểu
  bool polydipsia; //nhiều nước uống
  bool weightLoss; //sut can
  AcuteHyperGlycemiaCheck({
    required this.fastingGlucose,
    required this.casualGlucose,
    required this.hba1c,
    this.thirsty = false,
    this.polyuria = false,
    this.polydipsia = false,
    this.weightLoss = false,
  });
  bool get isAcuteHyperGlycemia {
    if (fastingGlucose > 13.9 ||
        casualGlucose > 16.7 ||
        hba1c >= 10 ||
        (thirsty && polyuria && polydipsia && weightLoss)) {
      return true;
    } else {
      return false;
    }
  }

  //from Map
  fromMap(Map<String, dynamic>? map) {
    if (map != null) {
      fastingGlucose = map['fastingGlucose'];
      casualGlucose = map['casualGlucose'];
      hba1c = map['hba1c'];
      thirsty = map['thirsty'];
      polyuria = map['polyuria'];
      polydipsia = map['polydipsia'];
      weightLoss = map['weightLoss'];
    }
    return AcuteHyperGlycemiaCheck(
      fastingGlucose: 0,
      casualGlucose: 0,
      hba1c: 0,
      thirsty: false,
      polyuria: false,
      polydipsia: false,
      weightLoss: false,
    );
  }

  //to Map
  Map<String, dynamic> toMap() {
    return {
      'fastingGlucose': fastingGlucose,
      'casualGlucose': casualGlucose,
      'hba1c': hba1c,
      'thirsty': thirsty,
      'polyuria': polyuria,
      'polydipsia': polydipsia,
      'weightLoss': weightLoss,
    };
  }
}
