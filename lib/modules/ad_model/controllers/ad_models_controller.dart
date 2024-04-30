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
  final _apiServices = NetworkApiServices();
  Future getAdModelsList() async {
    adModelData.clear();
    if (adModelData.isEmpty) {
      try {
        adModelData.clear();
        loading.value = true;
        final response =
            await _apiServices.getApi(UrlConstants.getAdModelsListURL);

        AdModel adModel = AdModel.fromJson(response);
        adModelData.addAll(adModel.data ?? []);
        loading.value = false;
      } on Exception catch (e) {
        loading.value = false;

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
}
