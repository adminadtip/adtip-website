import 'package:get/get.dart';

class DropDurationController extends GetxController {
  final List<String> genderList = [
    'Today',
    'Yesterday',
    'Last 7 days',
    'Last 30 days',
    'Current Year',
    'Lifetime'
  ];
  final selectData = "Current Year".obs;

  void setSelect(companyList) {
    selectData.value = companyList;
  }

  bool checkIsSelected(professionListData) {
    if (selectData.value == "") {
      return false;
    }
    if (selectData.value == professionListData) {
      return true;
    }
    return false;
  }
}
