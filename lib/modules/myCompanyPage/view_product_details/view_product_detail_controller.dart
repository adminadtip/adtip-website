import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/url_constants.dart';
import '../../../netwrok/network_api_services.dart';
import '../model/product_details_model.dart';

class ProductDetailsController extends GetxController {
  final List<ProductDetailsData> productListData = [];
  final loading = false.obs;
  final _apiServices = NetworkApiServices();
  Rx<int> selectedProductId = 0.obs;
  Rx<bool> isEdit = false.obs;
  Rx<String> title = 'Add Product'.obs;
  RxMap productData = {}.obs;

  Future getProductDetails({required productId, required userId}) async {
    try {
      productListData.clear();
      loading.value = true;
      final response = await _apiServices
          .getApi("${UrlConstants.getProductDetails}$productId/$userId");
      ProductDetailsModel productListModel =
          ProductDetailsModel.fromJson(response);
      productListData.addAll(productListModel.data ?? []);
      update();
      loading.value = false;
    } catch (e) {
      loading.value = false;
    } finally {
      loading.value = false;
    }
  }

  Future deleteProduct({
    required int productId,
  }) async {
    Map data = {'id': productId};
    try {
      loading.value = true;
      final response = await _apiServices.postApi(
          data, "${UrlConstants.BASE_URL}deleteProduct");
      loading.value = false;
    } catch (e) {
      loading.value = false;

      if (kDebugMode) {
        print(e);
      }
    } finally {
      loading.value = false;
    }
  }

  setEditOrAddProductValue({
    required String heading,
    required bool edit,
  }) {
    title.value = heading;
    isEdit.value = edit;
  }
}
