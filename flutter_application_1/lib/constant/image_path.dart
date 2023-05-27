class ImageConstants {
  static ImageConstants? _instance;
  static ImageConstants get instance {
    _instance ??= _instance = ImageConstants._init();
    return _instance!;
  }

  ImageConstants._init();
  String get ceviz => toPng('ceviz');
  String get domat => toPng('domat');

  //!
  //? Üste belittiğim arkaplan içerisine png dosya adımı yazım 'rakaplan_resmi'
  //? Alt tarafdayazdığım değeri yoluma $ işareti ile belirtip sonuna .png yazdım
  String toPng(value) => 'asset/image/$value.png';
}

class ConstantLottie {
  static ConstantLottie? _instance;
  static ConstantLottie get instance {
    _instance ??= _instance = ConstantLottie._init();
    return _instance!;
  }

  ConstantLottie._init();

  String get buton => toSvg("start");
  String get aslan => toSvg("aslan");
  String get havayifisek => toSvg("havayifisek");
  String get log1 => toSvg("log1");
  String get log2 => toSvg("log2");
  String get reset => toSvg("reset");
  String get score => toSvg("score");
  String get bir => toSvg("11");
  String get iki => toSvg("2");
  String get uc => toSvg("3");
  String get dort => toSvg("4");
  String get bes => toSvg("5");
  String get alti => toSvg("6");

  String toSvg(String value) => 'asset/lotti/$value.json';
}
