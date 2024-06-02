import 'package:adtip_web_3/modules/ad_model/controllers/ad_models_controller.dart';
import 'package:get/get.dart';

class AdModelsBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AdModelsController>(() => AdModelsController());
  }
}
