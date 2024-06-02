import 'package:adtip_web_3/modules/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../helpers/utils/utils.dart';
import '../../../netwrok/network_api_services.dart';
import '../model/post_model.dart';

class PostController extends GetxController {
  final loading = false.obs;
  final loadingPost = false.obs;
  int get userId =>
      LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId) ?? 0;

  final _apiServices = NetworkApiServices();
  // List<PostData> postData = [];
  RxList<PostData> postData = <PostData>[].obs;
  final dashboardController = Get.put(DashboardController());

  Future addPost(
      {String? postDescription,
      required String postName,
      required String buttonId,
      String? website,
      required String companyId,
      required List imagePath,
      int? id}) async {
    Map data = {
      'PostName': postName,
      'PostDiscription': postDescription,
      'buttonid': buttonId,
      'website': website,
      'image_path': imagePath,
      'createdby': userId,
      'id': id,
      'company_id': companyId
    };
    try {
      loading.value = true;
      final response = await _apiServices.postApi(data, UrlConstants.postUrl);
      if (response != null) {
        Get.snackbar("Post added Successfully", "",
            colorText: Colors.white, backgroundColor: Colors.green);
        await getPostList(companyId: int.tryParse(companyId)!);
        postData.refresh();
        dashboardController.changeWidget(value: 2);
      }
      loading.value = false;
    } on Exception catch (e) {
      loading.value = false;

      print(e);
    }
  }

  Future getPostList({required int companyId}) async {
    try {
      postData.clear();
      loadingPost.value = true;
      final response =
          await _apiServices.getApi("${UrlConstants.getPostUrl}$companyId");
      PostModel adModel = PostModel.fromJson(response);
      postData.addAll(adModel.data ?? []);
      loadingPost.value = false;
    } on Exception catch (e) {
      loadingPost.value = false;

      print(e);
    }
    loadingPost.value = false;
  }

  Future<void> deletePost({required int postId}) async {
    try {
      var body = {"id": postId};
      final response =
          await _apiServices.postApi(body, "${UrlConstants.deletePost}");
      Utils.showSuccessMessage('Deleted successfully.');
    } catch (e) {}
  }
}
