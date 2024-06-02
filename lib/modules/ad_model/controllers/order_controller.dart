import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../netwrok/network_api_services.dart';
import '../models/order_list.dart';

class OrdersController extends GetxController {
  List<OrderListData> orderListData = [];
  List<OrderListData> pendingOrderListData = [];

  ScreenshotController screenshotController = ScreenshotController();
  int? userId = LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId);
  final loading = false.obs;
  final _apiServices = NetworkApiServices();
  Rx<int> selectedOrder = 0.obs;
  Rx<int> selectedOrderId = 0.obs;
  Future getOrderList() async {
    if (orderListData.isEmpty) {
      try {
        orderListData.clear();
        pendingOrderListData.clear();
        loading.value = true;
        final response = await _apiServices
            .getApi("${UrlConstants.saveGetalladdsURL}/$userId");
        print('res ads $response');
        AdModelsOrderList productListModel =
            AdModelsOrderList.fromJson(response);
        orderListData.addAll(productListModel.data
                ?.where((e) => e.isThirdPageSave != null)
                .toList() ??
            []);
        pendingOrderListData.addAll(productListModel.data
                ?.where((e) => e.isThirdPageSave == null)
                .toList() ??
            []);
        loading.value = false;
      } catch (e) {
        loading.value = false;
      } finally {
        loading.value = false;
      }
    }
  }

  // Future<File> genThumbnailFile({required String path}) async {
  //   try {
  //     final fileName = await VideoThumbnail.thumbnailFile(
  //       video: path,
  //       thumbnailPath: (await getTemporaryDirectory()).path,
  //       imageFormat: ImageFormat.PNG,
  //       maxHeight:
  //           100, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
  //       quality: 75,
  //     );
  //     File file = File(fileName ?? "");
  //     return file;
  //   } catch (e) {
  //     print(e);
  //   }
  //   return File('');
  // }

  final selectData = OrderListData().obs;

  void setSelect(OrderListData companyList) {
    selectData.value = companyList;
  }

  void changeOrderIndex({required int index, required int orderId}) {
    selectedOrder.value = index;
    selectedOrderId.value = orderId;
  }

  bool checkIsSelected(OrderListData professionListData) {
    if (selectData.value.id == null) {
      return false;
    }
    if (selectData.value.id == professionListData.id) {
      return true;
    }
    return false;
  }
}
