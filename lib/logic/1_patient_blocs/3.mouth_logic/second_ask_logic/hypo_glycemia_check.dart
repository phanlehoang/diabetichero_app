class HypoGlycemiaCheck {
  bool cognitiveImpairment; //suy nghĩ
  //cac bệnh nội khoa nặng giai đoạn cuối
  //bệnh thận mạn có chỉ định lọc máu
  bool dialysis;
  bool cirrhosis; //xo gan
  bool metastaticCancer; //ung thư di can
  bool heartFailureHyperTension; //suy tim xung huyết
  bool stroke;
  bool alcoholicDementia; //sang rượu
  bool otherSeriousDisease;

  //roi loan họat động cơ bản hằng ngày
  // dailyBasicActivityDisfunction;
  bool bathDisfunction;
  bool dressingDisfunction;
  bool personalHygieneDisfunction;
  bool eatingDisfunction;
  bool mobileDisfunction;

  //constructure
  HypoGlycemiaCheck({
    this.cognitiveImpairment = false,
    this.dialysis = false,
    this.cirrhosis = false,
    this.metastaticCancer = false,
    this.heartFailureHyperTension = false,
    this.stroke = false,
    this.alcoholicDementia = false,
    this.otherSeriousDisease = false,
    this.bathDisfunction = false,
    this.dressingDisfunction = false,
    this.personalHygieneDisfunction = false,
    this.eatingDisfunction = false,
    this.mobileDisfunction = false,
  });
  //from Map
  fromMap(Map<String, dynamic>? map) {
    if (map != null) {
      cognitiveImpairment = map['cognitiveImpairment'];
      dialysis = map['dialysis'];
      cirrhosis = map['cirrhosis'];
      metastaticCancer = map['metastaticCancer'];
      heartFailureHyperTension = map['heartFailureHyperTension'];
      stroke = map['stroke'];
      alcoholicDementia = map['alcoholicDementia'];
      otherSeriousDisease = map['otherSeriousDisease'];
      //5 cái
      bathDisfunction = map['bathDisfunction'];
      dressingDisfunction = map['dressingDisfunction'];
      personalHygieneDisfunction = map['personalHygieneDisfunction'];
      eatingDisfunction = map['eatingDisfunction'];
      mobileDisfunction = map['mobileDisfunction'];

      return HypoGlycemiaCheck(
        cognitiveImpairment: cognitiveImpairment,
        dialysis: dialysis,
        cirrhosis: cirrhosis,
        metastaticCancer: metastaticCancer,
        heartFailureHyperTension: heartFailureHyperTension,
        stroke: stroke,
        alcoholicDementia: alcoholicDementia,
        otherSeriousDisease: otherSeriousDisease,
        bathDisfunction: bathDisfunction,
        dressingDisfunction: dressingDisfunction,
        personalHygieneDisfunction: personalHygieneDisfunction,
        eatingDisfunction: eatingDisfunction,
        mobileDisfunction: mobileDisfunction,
      );
    }
    return HypoGlycemiaCheck(
      cognitiveImpairment: false,
      dialysis: false,
      cirrhosis: false,
      metastaticCancer: false,
      heartFailureHyperTension: false,
      stroke: false,
      alcoholicDementia: false,
      otherSeriousDisease: false,
    );
  }

  //to Map
  Map<String, dynamic> toMap() {
    return {
      'cognitiveImpairment': cognitiveImpairment,
      'dialysis': dialysis,
      'cirrhosis': cirrhosis,
      'metastaticCancer': metastaticCancer,
      'heartFailureHyperTension': heartFailureHyperTension,
      'stroke': stroke,
      'alcoholicDementia': alcoholicDementia,
      'otherSeriousDisease': otherSeriousDisease,
      'bathDisfunction': bathDisfunction,
      'dressingDisfunction': dressingDisfunction,
      'personalHygieneDisfunction': personalHygieneDisfunction,
      'eatingDisfunction': eatingDisfunction,
      'mobileDisfunction': mobileDisfunction,
    };
  }

  //kiểm tra nguy cơ hạ đường
  bool get isHypoGlycemiaRisk {
    if (cognitiveImpairment ||
        dialysis ||
        cirrhosis ||
        metastaticCancer ||
        heartFailureHyperTension ||
        stroke ||
        alcoholicDementia ||
        otherSeriousDisease) {
      return true;
    } else {
      //5 cái basic mà >=2 cái thì nguy cơ hạ đường
      int count = 0;
      if (bathDisfunction) {
        count++;
      }
      if (dressingDisfunction) {
        count++;
      }
      if (personalHygieneDisfunction) {
        count++;
      }
      if (eatingDisfunction) {
        count++;
      }
      if (mobileDisfunction) {
        count++;
      }
      if (count >= 2) {
        return true;
      } else {
        return false;
      }
    }
  }
}
