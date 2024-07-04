import 'dart:html';

import 'package:adtip_web_3/modules/qr_ad_display/models/qr_ad_web_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/string_constants.dart';
import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../helpers/utils/utils.dart';
import '../../../netwrok/network_api_services.dart';
import '../models/company_list_model.dart';
import 'package:http/http.dart' as http;

import '../models/qr_ad_details_model.dart';
import '../widgets/qr_code_video_image_ad_view.dart';

class QrCodeAdDisplayController extends GetxController {
  GetCompanyModel? getCompanyModel;
  QrAdWebModel? qrAdWebModel;
  RxList<QrAdDetailsModel> qrAdDetailsData = <QrAdDetailsModel>[].obs;
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
        if (path.startsWith('/video/')) {
          Utils.launchWeb(uri: Uri.parse(StringConstants.googlePlayLink));
        } else if (path.startsWith('/mob/Post/')) {
          Utils.launchWeb(uri: Uri.parse(StringConstants.googlePlayLink));
        } else if (path.startsWith('/mob/refer/')) {
          Map<String, dynamic> value = uri.queryParameters;
          if (value['code'] != null) {
            await checkReferalCodeValid(code: value['code']);
          }
        } else if (path.startsWith('/mob/Product/')) {
          Utils.launchWeb(uri: Uri.parse(StringConstants.googlePlayLink));
        } else if (path.startsWith('/mob/QRImageAd/')) {
          Map<String, dynamic> value = uri.queryParameters;
          if (value['url'] != null &&
              value['companyId'] != null &&
              value['adId'] != null) {
            await getQRAdDetails(adId: int.tryParse(value['adId'])!);
            if (kDebugMode) {
              print('ad data ${qrAdDetailsData.first.adUrl}');
            }
            if (kDebugMode) {
              print('company data ${getCompanyModel?.data}');
            }
            if (qrAdDetailsData.isNotEmpty) {
              Get.to(
                QrCodeImageVideoView(
                  qrAdDetailsModel: qrAdDetailsData[0],
                ),
              );
            }
          }
        }
      }
    } else {
      Utils.showErrorMessage('Invalid QR Code');
    }
  }

  Future<void> getQRAdDetails({required int adId}) async {
    try {
      var response =
          await _apiServices.getApi('${UrlConstants.getAdDetailsForQr}/$adId');
      QrAdDetails qrAdDetails = QrAdDetails.fromJson(response);
      qrAdDetailsData.addAll(qrAdDetails.list);
    } catch (e) {
      if (kDebugMode) {
        print('error $e');
      }
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
      Future.delayed(const Duration(seconds: 1), () {
        Utils.launchWeb(
            uri: Uri.parse(
                'https://play.google.com/store/apps/details?id=com.adtip.app.adtip_app&hl=en_IN&gl=US'));
      });
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

  Future<void> checkReferalCodeValid({required String code}) async {
    try {
      int userId =
          LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId)!;
      var body = {"userId": userId, "referalCode": code};
      var response =
          await _apiServices.postApi(body, UrlConstants.checkReferalCodeValid);
      int? isValid = response['data'][0]['isValid'];
      int? referralCreatorId = response['data'][0]['referalCreator'];

      String? referralCode = response['data'][0]['referalCode'];
      if (isValid != null &&
          isValid == 1 &&
          referralCreatorId != null &&
          referralCode != null &&
          referralCode.isNotEmpty) {
        await LocalPrefs().setIntegerPref(
            key: SharedPreferenceKey.referralCreator, value: referralCreatorId);
        await LocalPrefs().setStringPref(
            key: SharedPreferenceKey.referralCode, value: referralCode);

        if (kDebugMode) {
          String? couponCode =
              LocalPrefs().getStringPref(key: SharedPreferenceKey.referralCode);
          int? couponCreatorId = LocalPrefs()
              .getIntegerPref(key: SharedPreferenceKey.referralCreator);
          print('coupon valid and saved $couponCode $couponCreatorId');
        }
      }
    } catch (e) {
      print('error saving referal data $e');
    }
  }
}
