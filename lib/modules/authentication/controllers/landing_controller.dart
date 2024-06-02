import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/utils/utils.dart';
import '../../../netwrok/network_api_services.dart';

class LandingController extends GetxController {
  Rx<bool> isLoading = false.obs;
  final _apiServices = NetworkApiServices();
  launchURL() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.adtip.app.adtip_app&hl=en_IN&gl=US';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> submitWebsiteMessage(
      {required String name,
      required String message,
      required String mobile,
      required String type}) async {
    try {
      isLoading.value = true;
      final body = {
        "name": name,
        "mobile": mobile,
        "message": message,
        "type": type
      };
      await _apiServices.postApi(body, UrlConstants.saveWebsiteMessage);

      Utils.showSuccessMessage(
          'Thanks for submitting, we will connect you soon.');
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Utils.showErrorMessage('Something went wrong. $e');
    }
    isLoading.value = false;
  }
}
