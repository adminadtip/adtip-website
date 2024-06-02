import 'package:get/get.dart';
import '../../../../helpers/constants/url_constants.dart';
import '../../../../helpers/local_database/local_prefs.dart';
import '../../../../helpers/local_database/sharedpref_key.dart';
import '../../../../netwrok/network_api_services.dart';
import '../../controllers/order_controller.dart';
import 'duration/controller.dart';
import 'model/graph_model.dart';

class LeadController extends GetxController {
  DropDurationController dropGenderController =
      Get.put(DropDurationController());
  final OrdersController orderController =
      Get.put(OrdersController(), permanent: true);
  List<IsLike> isLikeData = [];
  List<IsLike> isFollowData = [];
  List<IsLike> isViewData = [];
  List<IsLikeUserList> isLikeUserData = [];
  List<IsLikeUserList> isFollowUserData = [];
  List<IsLikeUserList> isViewUserData = [];
  final loading = false.obs;
  final selectedIndex = 0.obs;

  final _apiServices = NetworkApiServices();
  final interval = 1.0.obs;
  final maxCount = 0.obs;

  Future init({int? adId}) async {
    await getLeadList(adId: adId!);
    await getMaxCount(isLikeData);
    await getMaxCount(isFollowData);
    await getMaxCount(isViewData);

    interval.value = (maxCount.value / 10);
  }

  Future getMaxCount(dynamic list) async {
    for (var entry in list) {
      int? count = entry.count;

      if (count! > maxCount.value) {
        maxCount.value = count;
      }
    }
  }

  Future getLeadList({required int adId}) async {
    int userId =
        LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId) ?? 0;

    Map data = {
      "userId": userId.toString(),
      "campaignId": adId == null
          ? orderController.selectData.value.companyId
          : adId.toString(),
      // orderController.selectData.value.companyId,
      "isOverview": "1",
      "dateformat": dropGenderController.selectData.value
    };

    try {
      isLikeData.clear();
      isFollowData.clear();
      isViewData.clear();
      isFollowUserData.clear();
      isLikeUserData.clear();
      isViewUserData.clear();
      loading.value = true;
      final response = await _apiServices.postApi(data, UrlConstants.leadUrl);
      GraphModel leadListModel = GraphModel.fromJson(response);
      isLikeData.addAll(leadListModel.data?.isLike ?? []);
      isFollowData.addAll(leadListModel.data?.isFollow ?? []);
      isViewData.addAll(leadListModel.data?.isView ?? []);
      isLikeUserData.addAll(leadListModel.data?.isLikeUserList ?? []);
      isViewUserData.addAll(leadListModel.data?.isViewUserList ?? []);
      isFollowUserData.addAll(leadListModel.data?.isFollowUserList ?? []);

      loading.value = false;
    } on Exception catch (e) {
      loading.value = false;
      print(e);
    }
    loading.value = false;
  }
}
