import 'package:get/get.dart';

import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../helpers/utils/utils.dart';
import '../../../netwrok/network_api_services.dart';

class ReferController extends GetxController {
  final loading = false.obs;
  final _apiServices = NetworkApiServices();
  RxDouble totalReferalEarnings = 0.0.obs;
  RxString referalCode = ''.obs;

  Future<void> generateReferalCode() async {
    try {
      loading.value = true;
      int? userId =
          LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId)!;
      var response =
          await _apiServices.getApi("${UrlConstants.generateReferal}/$userId");
      totalReferalEarnings.value =
          double.tryParse(response['data'][0]['referal_earnings'].toString()) ??
              0.0;
      referalCode.value = response['data'][0]['referal_code'];
      loading.value = false;
    } catch (e) {
      loading.value = false;
      Utils.showErrorMessage(e.toString());
    } finally {
      loading.value = false;
    }
  }
}
