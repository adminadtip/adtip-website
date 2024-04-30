import 'package:get/get.dart';

import '../../../helpers/constants/url_constants.dart';
import '../../../netwrok/network_api_services.dart';
import '../model/product_model.dart';

class ProductController extends GetxController {
  final List<ProductListData> productListData = [];
  final loading = false.obs;
  final _apiServices = NetworkApiServices();

  Future getProduct({required String companyId}) async {
    try {
      productListData.clear();
      loading.value = true;
      final response =
          await _apiServices.getApi("${UrlConstants.getProductList}$companyId");
      ProductListModel productListModel = ProductListModel.fromJson(response);
      productListData.addAll(productListModel.data ?? []);
      loading.value = false;
    } on Exception catch (e) {
      loading.value = false;

      print(e);
    }
  }
}
