import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const String testDevice = 'YOUR_DEVICE_ID';
const int maxFailedLoadAttempts = 3;

class GoogleRewardedAd {
  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  static AdRequest request = const AdRequest(
    keywords: <String>['wordle', 'dictionary', 'persian', 'pastho'],
    nonPersonalizedAds: true,
  );

  GoogleRewardedAd load() {
    // TODO: replace this with -- ca-app-pub-4957579540018092/9983342824
    RewardedAd.load(
      adUnitId: RewardedAd.testAdUnitId,
      request: request,
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          print('$ad loaded.');
          _rewardedAd = ad;
          _numRewardedLoadAttempts = 0;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('RewardedAd failed to load: $error');
          _rewardedAd = null;
          _numRewardedLoadAttempts += 1;
          if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
            load();
          }
        },
      ),
    );

    return this;
  }

  show() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        ad.dispose();
        load();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        ad.dispose();
        load();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!
        .show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {});

    _rewardedAd = null;
  }
}
