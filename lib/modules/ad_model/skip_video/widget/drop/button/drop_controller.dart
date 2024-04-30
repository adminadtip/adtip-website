import 'package:get/get.dart';

import '../../../../../../helpers/constants/url_constants.dart';
import '../../../../../../netwrok/network_api_services.dart';
import '../../../../../myCompanyPage/model/profession_list.dart';

class DropControllerBotton extends GetxController {
  final List<ProfessionListData> buttonListData = [];
  final loading = false.obs;
  final selectData = ProfessionListData().obs;
  final _apiServices = NetworkApiServices();

  Future getButtonList() async {
    if (buttonListData.isEmpty) {
      try {
        buttonListData.clear();
        loading.value = true;
        final response =
            await _apiServices.getApi(UrlConstants.getButtonListURL);
        ProfessionListModel productListModel =
            ProfessionListModel.fromJson(response);
        buttonListData.addAll(productListModel.data ?? []);
        loading.value = false;
      } on Exception catch (e) {
        loading.value = false;

        print(e);
      }
    }
  }

  void setSelect(ProfessionListData companyList) {
    selectData.value = companyList;
  }

  bool checkIsSelected(ProfessionListData professionListData) {
    if (selectData.value.id == null) {
      return false;
    }
    if (selectData.value.id == professionListData.id) {
      return true;
    }
    return false;
  }
}
