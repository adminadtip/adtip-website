import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../netwrok/network_api_services.dart';
import '../models/ad_models.dart';

class AdModelsController extends GetxController {
  final loading = false.obs;
  final loadingDemo = false.obs;

  List<AdModelData> adModelData = [];

  ///for skip video screen
  Rx<int> viewPrice = 0.obs;
  Rx<String> title = ''.obs;
  Rx<String> modelId = ''.obs;
  Rx<String> mediaType = ''.obs;
  Rx<String> link = ''.obs;
  Rx<int> adValue = 0.obs;
  Rx<String> compaignName = ''.obs;
  Rx<String> description = ''.obs;
  Rx<String> location = ''.obs;
  Rx<String> website = ''.obs;
  Rx<String> tax = ''.obs;
  Rx<String> promoteLink = ''.obs;

  ///for referral
  RxInt referralCreator = 0.obs;
  RxString referralCodeToUse = ''.obs;
  RxBool referralValid = false.obs;
  final referralTextEditingController = TextEditingController();
  RxBool checkingReferral = false.obs;

  final _apiServices = NetworkApiServices();
  Future getAdModelsList() async {
    adModelData.clear();
    update();
    if (adModelData.isEmpty) {
      try {
        adModelData.clear();
        loading.value = true;
        update();
        final response =
            await _apiServices.getApi(UrlConstants.getAdModelsListURL);

        AdModel adModel = AdModel.fromJson(response);
        adModelData.addAll(adModel.data ?? []);
        loading.value = false;
        update();
        print('ad models length ${adModelData.length}');
      } catch (e) {
        loading.value = false;
        update();

        print(e);
      }
    }
  }

  Future requestDemo(
      {required String name,
      required String startDate,
      required String startTime,
      required String emailId,
      required String phone}) async {
    int userId =
        LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId) ?? 0;

    Map data = {
      'name_description': name,
      'createdby': userId,
      'start_date': startDate,
      'start_time': startTime,
      'emailId': emailId,
      'phone_no': phone
    };
    try {
      loadingDemo.value = true;
      final response =
          await _apiServices.postApi(data, UrlConstants.demoRequestUrl);
      if (response != null) {
        Get.back();
        Get.snackbar("Demo Booking  Successfully", "",
            colorText: Colors.white, backgroundColor: Colors.green);
      }
      loadingDemo.value = false;
    } on Exception catch (e) {
      loadingDemo.value = false;

      print(e);
    }
  }

  setForSkipVideo(
      {required String title1,
      required int viewPrice1,
      required String modelId1,
      required String mediaType1,
      required String link1}) {
    viewPrice.value = viewPrice1;
    title.value = title1;
    modelId.value = modelId1;
    mediaType.value = mediaType1;
    link.value = link1;
  }

  Future<void> getReferralCode() async {
    try {
      String? couponCode =
          LocalPrefs().getStringPref(key: SharedPreferenceKey.referralCode);
      int? couponCreatorId =
          LocalPrefs().getIntegerPref(key: SharedPreferenceKey.referralCreator);
      if (kDebugMode) {
        print('coupon $couponCode $couponCreatorId}');
      }
      if (couponCode != null && couponCreatorId != null) {
        referralTextEditingController.text = couponCode;
        await checkReferralCodeValid(code: couponCode);
      }
    } catch (e) {
      print('error runnug code $e');
      referralValid.value = false;
    }
  }

  Future<void> checkReferralCodeValid({required String code}) async {
    try {
      checkingReferral.value = true;
      int? userId =
          LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId);

      var body = {"userId": userId, "referalCode": code};
      var response =
          await _apiServices.postApi(body, UrlConstants.checkReferalCodeValid);
      int? isValid = response['data'][0]['isValid'];
      int? referralCreatorId = response['data'][0]['referalCreator'];
      String? referralCode = response['data'][0]['referalCode'];
      checkingReferral.value = false;
      if (isValid != null &&
          isValid == 1 &&
          referralCreatorId != null &&
          referralCode != null &&
          referralCode.isNotEmpty) {
        referralCreator.value = referralCreatorId;
        referralValid.value = true;
        referralCodeToUse.value = referralCode;

        if (kDebugMode) {
          print('coupon valid and can be used $isValid');
        }
      } else {
        referralValid.value = false;
      }
    } catch (e) {
      checkingReferral.value = false;
      referralValid.value = false;
    }
  }
}
