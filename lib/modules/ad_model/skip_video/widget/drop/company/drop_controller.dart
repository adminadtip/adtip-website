import 'package:get/get.dart';

import '../../../../../../helpers/constants/url_constants.dart';
import '../../../../../../helpers/local_database/local_prefs.dart';
import '../../../../../../helpers/local_database/sharedpref_key.dart';
import '../../../../../../netwrok/network_api_services.dart';
import '../../../../models/company_list.dart';

class DropControllerCompany extends GetxController {
  final List<CompanyListData> companyListData = [];
  final loading = false.obs;
  final selectData = CompanyListData().obs;
  final _apiServices = NetworkApiServices();

  Future getCompanyList() async {
    final userId =
        LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId) ?? 0;

    try {
      companyListData.clear();
      loading.value = true;
      final response =
          await _apiServices.getApi("${UrlConstants.getCompanyListURL}$userId");
      CompanyListModel productListModel = CompanyListModel.fromJson(response);
      companyListData.addAll(productListModel.data ?? []);
      loading.value = false;
    } on Exception catch (e) {
      loading.value = false;

      print(e);
    }
  }

  void setSelect(CompanyListData companyList) {
    selectData.value = companyList;
  }

  bool checkIsSelected(CompanyListData professionListData) {
    if (selectData.value.id == null) {
      return false;
    }
    if (selectData.value.id == professionListData.id) {
      return true;
    }
    return false;
  }
}
