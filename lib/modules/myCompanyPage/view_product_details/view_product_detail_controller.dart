import 'package:get/get.dart';

import '../../../helpers/constants/url_constants.dart';
import '../../../netwrok/network_api_services.dart';
import '../model/product_details_model.dart';

class ProductDetailsController extends GetxController {
  final List<ProductDetailsData> productListData = [];
  final loading = false.obs;
  final _apiServices = NetworkApiServices();

  Future getProductDetails({required companyId, required userId}) async {
    try {
      productListData.clear();
      loading.value = true;
      final response = await _apiServices
          .getApi("${UrlConstants.getProductDetails}$companyId/$userId");
      ProductDetailsModel productListModel =
          ProductDetailsModel.fromJson(response);
      productListData.addAll(productListModel.data ?? []);
      loading.value = false;
    } on Exception catch (e) {
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
      print(response);
      loading.value = false;
    } on Exception catch (e) {
      loading.value = false;

      print(e);
    }
  }
}
