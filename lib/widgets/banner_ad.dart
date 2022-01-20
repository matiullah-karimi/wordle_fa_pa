import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wordle_fa_pa/ads/banner_ad.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({Key? key}) : super(key: key);

  @override
  _BannerAdWidgetState createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late BannerAd bannerAd;
  bool isAddLoaded = false;

  @override
  void initState() {
    _loadBannerAd();

    super.initState();
  }

  @override
  void dispose() {
    bannerAd.dispose();

    super.dispose();
  }

  _loadBannerAd() {
    var listener = BannerAdListener(
      onAdLoaded: (_) {
        setState(() {
          isAddLoaded = true;
        });
      },
      onAdFailedToLoad: (ad, error) {
        print('error =====================>');
        print(error.message);
        ad.dispose();
      },
    );

    bannerAd = GoogleBannerAd().get(listener);
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AdWidget(ad: bannerAd),
      width: double.infinity,
      height: 72.0,
    );
  }
}
