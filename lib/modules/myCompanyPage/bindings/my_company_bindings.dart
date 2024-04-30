import 'package:get/get.dart';

import '../controller/my_company_controller.dart';

class MyCompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyCompanyController>(
      () => MyCompanyController(),
    );
  }
}
