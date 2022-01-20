import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleBannerAd {
  static String bannerAdUnitId = "ca-app-pub-4957579540018092/5718979976";
  static String testBannerAdUnitId = "ca-app-pub-3940256099942544/6300978111";
  static String iOSBannerAdUnitId = "";

  BannerAd get(listener) {
    return BannerAd(
      adUnitId: Platform.isAndroid ? testBannerAdUnitId : iOSBannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: listener,
    );
  }
}
