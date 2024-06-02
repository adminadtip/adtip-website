import 'dart:html';

import 'package:adtip_web_3/modules/qr_ad_display/models/qr_ad_web_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/utils/utils.dart';
import '../../../netwrok/network_api_services.dart';
import '../models/company_list_model.dart';
import 'package:http/http.dart' as http;

import '../widgets/qr_code_video_image_ad_view.dart';

class QrCodeAdDisplayController extends GetxController {
  GetCompanyModel? getCompanyModel;
  QrAdWebModel? qrAdWebModel;
  Rx<bool> loadingQrAdWebData = false.obs;
  Rx<bool> isLoading = false.obs;
  final _apiServices = NetworkApiServices();
  Rx<bool> checkingAdValid = false.obs;
  Rx<int> isValid = 0.obs;
  Rx<bool> sendOtp = false.obs;

  Rx<bool> checkOtp = false.obs;
  Rx<int> otpId = 0.obs;
  Rx<bool> submittingData = false.obs;

  Future<void> getQRCodeDetails(
      {required String str, required BuildContext context}) async {
    http: //localhost:58783/
    https: //adtip.in/
    //flutter run -d chrome --web-port=58783
    if (str.startsWith('https://adtip.in/') && str.isNotEmpty) {
      Uri uri = Uri.parse(str);
      String path = uri.path;
      if (kDebugMode) {
        print('path $path');
      }

      if (path.isNotEmpty) {
        if (path == '/video/') {
          Map<String, String> value = uri.queryParameters;
          if (value['id'] != null) {}
        } else if (path.startsWith('/mob/QRImageAd/')) {
          Map<String, dynamic> value = uri.queryParameters;
          if (value['url'] != null &&
              value['companyId'] != null &&
              value['adId'] != null) {
            if (kDebugMode) {
              print('company  id ${value['companyId']}');
              print(' ad id ${value['adId']}');
            }

            await fetchCompanyData(value['companyId'], context);
            if (kDebugMode) {
              print('company data ${getCompanyModel?.data}');
            }
            Get.to(
              QrCodeImageVideoView(
                adId: int.parse(value['adId']),
                qrCodeValue: value['url'],
                getCompanyModel: getCompanyModel!,
              ),
            );
          }
        }
      }
    } else {
      Utils.showErrorMessage('Invalid QR Code');
    }
  }

  Future<void> fetchCompanyData(String companyID, BuildContext context) async {
    try {
      http.Response res = await http.get(
        Uri.parse(
          '${UrlConstants.BASE_URL}getcompany/$companyID/177/',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "authorization":
              "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MDkzMTQ5MjMsImV4cCI6MTc0MDg1MDkyM30.V3pOd8DzaWNXE4qUEago3D8w2R65_CPPpxQrbeNznWY"
        },
      );

      if (res.statusCode == 200) {
        getCompanyModel = getCompanyModelFromJson(res.body);
        update();
      } else {
        getCompanyModel = getCompanyModelFromJson(res.body);
        update();
      }
      // _isLoading.value = false;
    } catch (e) {
      update();
      print('error getting company $e');
    }
  }

  Future<void> checkAdValid(int adId) async {
    try {
      checkingAdValid.value = true;
      final response = await _apiServices
          .getApi('${UrlConstants.checkadpendingbalance}$adId');
      isValid.value = response['data'][0]['ad_show'];
      checkingAdValid.value = false;
    } catch (e) {
      checkingAdValid.value = false;
      Utils.showErrorMessage('Something went wrong. $e');
    }
  }

  void redirectToPlayStore() {
    // Replace <your_app_package_name> with your app's package name in the Play Store
    const playStoreUrl =
        'https://play.google.com/store/apps/details?id=com.adtip.app.adtip_app';
    window.location.assign(playStoreUrl);
  }

  Future<void> sendOTP({required String mobileNumber}) async {
    try {
      sendOtp.value = true;
      final body = {
        // ${countryCode.value}
        "mobileNumber": mobileNumber,
        "userType": "2",
      };
      final response = await _apiServices.postApi(body, UrlConstants.sentOtp);
      print('response phone ${response['data'][0]['id']}');
      otpId.value = response['data'][0]['id'];
      Utils.showSuccessMessage('OTP sent successfully.');
      sendOtp.value = false;
    } catch (e) {
      Utils.showErrorMessage('Something went wrong. $e');
    }
    sendOtp.value = false;
  }

  Future<void> verifyOTP(String otp, int id) async {
    try {
      checkOtp.value = true;
      final body = {"id": id, "otp": "$otp"};
      final response = await _apiServices.postApi(body, UrlConstants.verifyOtp);
      checkOtp.value = false;
    } catch (e) {
      checkOtp.value = false;
      Utils.showErrorMessage('Something went wrong. $e');
      rethrow;
    }
  }

  Future<void> submitQrData(
      {required String companyName,
      required int companyId,
      required int adId,
      required String name,
      required int mobile,
      required String profession,
      required String upiId}) async {
    try {
      submittingData.value = true;
      final body = {
        "company_name": companyName,
        "company_id": companyId,
        "ad_name": 'wedwed',
        "ad_id": adId,
        "user_name": name,
        "user_id": otpId.value,
        "mobile_no": mobile,
        "upi_id": upiId,
        "profession": profession
      };
      final response =
          await _apiServices.postApi(body, UrlConstants.insertQRScanWebData);
      Utils.showSuccessMessage(
          'Thanks for submitting, you will get your money within 3 business days');
      submittingData.value = false;
    } catch (e) {
      submittingData.value = false;
      Utils.showErrorMessage('Error $e');
    }
  }

  Future<void> getQrWebData({required int adId}) async {
    try {
      loadingQrAdWebData.value = true;
      var response =
          await _apiServices.getApi('${UrlConstants.getQrWebData}/$adId');

      qrAdWebModel = QrAdWebModel.fromJson(response);
      print('qrad model web data ${qrAdWebModel!.data.length}');
      update();
      loadingQrAdWebData.value = false;
    } catch (e) {
      loadingQrAdWebData.value = false;
      Utils.showErrorMessage('Something went wrong. $e');
    }
  }
}
