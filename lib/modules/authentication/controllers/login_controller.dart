import 'package:adtip_web_3/modules/authentication/pages/check_user_company.dart';
import 'package:adtip_web_3/modules/authentication/pages/otp_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../helpers/utils/utils.dart';
import '../../../netwrok/network_api_services.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  Rx<bool> isLoading = false.obs;
  final _apiServices = NetworkApiServices();
  Rx<bool> checkOtp = false.obs;

  Future<void> sendOTP({required String mobileNumber}) async {
    try {
      isLoading.value = true;
      final body = {
        // ${countryCode.value}
        "mobileNumber": mobileNumber,
        "userType": "2",
      };
      final response = await _apiServices.postApi(body, UrlConstants.sentOtp);
      print('response phone ${response['data'][0]['id']}');
      Get.to(() => OtpScreen(
            mobileNumber: mobileNumber,
            id: response['data'][0]['id'],
          ));
      Utils.showSuccessMessage('OTP sent successfully.');
      isLoading.value = false;
    } catch (e) {
      Utils.showErrorMessage('Something went wrong. $e');
    }
    isLoading.value = false;
  }

  Future<void> verifyOTP(String otp, int id) async {
    try {
      checkOtp.value = true;
      final body = {"id": id, "otp": "$otp"};
      final response = await _apiServices.postApi(body, UrlConstants.verifyOtp);
      print('response otp $response');
      await LocalPrefs().setIntegerPref(
          key: SharedPreferenceKey.UserId, value: response['data'][0]['id']);
      await LocalPrefs().setStringPref(
          key: SharedPreferenceKey.UserLoggedIn,
          value: response['accessToken']);
      checkOtp.value = false;
      Get.offAll(const CheckUserCompanyExist());
    } catch (e) {
      checkOtp.value = false;
      Utils.showErrorMessage('Something went wrong. $e');
    }
  }

  Future<bool?> checkCompanyExists() async {
    print("API Called");
    try {
      final int? userId =
          LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId);

      final response = await _apiServices
          .getApi('${UrlConstants.getUserCompanyList}$userId');
      if (response['data'].isEmpty) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
