import 'package:get/get.dart';

import '../controller/create_company_controller.dart';

class CreateCompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateCompanyController>(
      () => CreateCompanyController(),
    );
  }
}
