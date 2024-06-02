import 'package:adtip_web_3/modules/calling/controllers/calling_controller.dart';
import 'package:get/get.dart';

class CallingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CallingController>(() => CallingController());
  }
}
