import 'package:get/get.dart';

class DropGenderController extends GetxController {
  final List<String> genderList = ['Male', 'Female', 'Other'];
  final isSelectedAll = false.obs;
  final selectedList = <dynamic>[].obs;

  void clickAll() {
    if (isSelectedAll.isTrue) {
      isSelectedAll.value = false;
      selectedList.clear();
      selectedList.refresh();
    } else {
      isSelectedAll.value = true;
      selectedList.clear();
      for (var element in genderList) {
        selectedList.add(element);
      }
      selectedList.refresh();
    }
  }

  Future<void> addOrRemove(String professionListData) async {
    if (selectedList.contains(professionListData)) {
      selectedList.remove(professionListData);
    } else {
      selectedList.add(professionListData);
    }
    selectedList.refresh();
  }

  bool checkIsSelected(String professionListData) {
    if (selectedList.contains(professionListData)) {
      return true;
    }
    return false;
  }
}
