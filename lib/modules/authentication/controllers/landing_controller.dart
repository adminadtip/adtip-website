import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingController extends GetxController {
  launchURL() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.adtip.app.adtip_app&hl=en_IN&gl=US';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
