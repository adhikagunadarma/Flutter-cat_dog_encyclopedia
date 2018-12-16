
import 'package:firebase_admob/firebase_admob.dart';


const APP_ID="ca-app-pub-4827604324491386~7417114039";
const BANNER_APP_ID="ca-app-pub-4827604324491386/6620542651";
const INTERSTITIAL_APP_ID="ca-app-pub-4827604324491386/5331511710";

class GoogleAds{

  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: APP_ID != null ? [APP_ID] : null,
    keywords: ['Cat', 'Dog', 'Animal', 'Pets'],
    gender: MobileAdGender.unknown,

  );

  static BannerAd buildBanner() {
    return BannerAd(
        adUnitId: BANNER_APP_ID,
//      adUnitId: BannerAd.testAdUnitId,
        targetingInfo: targetingInfo,
        size: AdSize.banner,
        listener: (MobileAdEvent event) {
          print("eventnynya");
          print(event);
          if (event == MobileAdEvent.loaded){
            print("eventnynya");
            print(event);
          }
        });
  }

  static InterstitialAd buildInterstitial() {
    return InterstitialAd(
        adUnitId: INTERSTITIAL_APP_ID,
//      adUnitId: InterstitialAd.testAdUnitId,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.failedToLoad) {
//          interstitialAd..load();
        } else if (event == MobileAdEvent.closed) {
//          interstitialAd = buildInterstitial()..load();
        }
          print(event);
        });
  }
}

