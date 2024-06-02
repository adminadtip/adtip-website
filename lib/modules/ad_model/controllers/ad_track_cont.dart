import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:path_provider/path_provider.dart';

import '../../../helpers/constants/url_constants.dart';
import '../../../netwrok/network_api_services.dart';
import '../models/tracking_order.dart';

class AdTrackingOrder extends GetxController {
  final loading = false.obs;
  final loadingDemo = false.obs;
  List<TrackingData> trackingOrderData = [];
  final _apiServices = NetworkApiServices();
  Future getTrackingDetails({required int orderId}) async {
    try {
      trackingOrderData.clear();
      loading.value = true;
      final response = await _apiServices
          .getApi("${UrlConstants.getTrackingOrderUrl}$orderId");
      TrackingModel adModel = TrackingModel.fromJson(response);
      trackingOrderData.addAll(adModel.data ?? []);
      loading.value = false;
    } on Exception catch (e) {
      loading.value = false;

      print(e);
    }
  }

  Future pauseStartOrder(
      {required String id,
      required String adPauseContinue,
      required Function onSuccess}) async {
    Map data = {
      'adPauseContinue': adPauseContinue,
      'adId': id,
    };
    try {
      loadingDemo.value = true;

      await _apiServices.postApi(data, UrlConstants.pauseStartOrderUrl);
      onSuccess();
      loadingDemo.value = false;
    } on Exception catch (e) {
      loadingDemo.value = false;

      print(e);
    }
  }
}
