import 'package:get/get.dart';

import '../../../../../../helpers/constants/url_constants.dart';
import '../../../../../../netwrok/network_api_services.dart';
import '../../../../../myCompanyPage/model/profession_list.dart';

class DropProfessController extends GetxController {
  final List<ProfessionListData> professionListData = [];
  final loading = false.obs;
  final isSelectedAll = false.obs;
  final selectedList = <dynamic>[].obs;
  final _apiServices = NetworkApiServices();

  Future getProfessionList() async {
    if (professionListData.isEmpty) {
      try {
        professionListData.clear();
        selectedList.clear();
        loading.value = true;
        final response =
            await _apiServices.getApi(UrlConstants.getProfessionListURL);
        ProfessionListModel productListModel =
            ProfessionListModel.fromJson(response);
        professionListData.addAll(productListModel.data ?? []);
        loading.value = false;
      } on Exception catch (e) {
        loading.value = false;

        print(e);
      }
    }
  }

  void clickAll() {
    if (isSelectedAll.isTrue) {
      isSelectedAll.value = false;
      selectedList.clear();
      selectedList.refresh();
    } else {
      isSelectedAll.value = true;
      selectedList.clear();
      for (var element in professionListData) {
        selectedList.add(element.id ?? 0);
      }
      selectedList.refresh();
    }
  }

  Future<void> addOrRemove(ProfessionListData professionListData) async {
    if (selectedList.contains(professionListData.id)) {
      selectedList.remove(professionListData.id);
    } else {
      selectedList.add(professionListData.id ?? 0);
    }
    selectedList.refresh();
  }

  bool checkIsSelected(ProfessionListData professionListData) {
    if (selectedList.contains(professionListData.id)) {
      return true;
    }
    return false;
  }
}
