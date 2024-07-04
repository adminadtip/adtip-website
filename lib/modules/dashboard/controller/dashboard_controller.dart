import 'package:adtip_web_3/modules/ad_model/page/ad_tracking.dart';
import 'package:adtip_web_3/modules/authentication/pages/landing_page.dart';
import 'package:adtip_web_3/modules/createCompany/page/company_page.dart';
import 'package:adtip_web_3/modules/dashboard/pages/dashboard_home.dart';
import 'package:adtip_web_3/modules/refer_earn/page/refer_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../netwrok/network_api_services.dart';
import '../../ad_model/ad_model.dart';
import '../../ad_model/page/checkout_screen.dart';
import '../../ad_model/page/order_list.dart';
import '../../ad_model/page/success_screen.dart';
import '../../ad_model/skip_video/skip_video.dart';
import '../../ad_model/skip_video/skip_video_second.dart';
import '../../ad_model/skip_video/upload_video.dart';
import '../../createCompany/controller/create_company_controller.dart';
import '../../createCompany/page/your_companies_page.dart';
import '../../myCompanyPage/model/post_model.dart';
import '../../myCompanyPage/page/add_post_page.dart';
import '../../myCompanyPage/page/add_product_page.dart';
import '../../myCompanyPage/page/edit_button_page.dart';
import '../../myCompanyPage/page/edit_company.dart';
import '../../myCompanyPage/page/edit_company_page.dart';
import '../../myCompanyPage/page/edit_company_picture.dart';
import '../../myCompanyPage/page/edit_direct_button_page.dart';
import '../../myCompanyPage/page/my_company_page.dart';
import '../../myCompanyPage/view_product/view_product.dart';
import '../../myCompanyPage/view_product_details/view_product_details.dart';

class DashboardController extends GetxController {
  static CreateCompanyController createCompanyController =
      Get.put(CreateCompanyController());
  Rx<int> selected = 0.obs;
  final _apiServices = NetworkApiServices();
  RxList<PostData> postData = <PostData>[].obs;
  Rx<bool> loadingPost = false.obs;

  List<Widget> widgets = [
    ///product
    //ViewProductScreen(),
    const DashboardHome(),

    /// company
    const YourCompaniesPage(), //1
    const MyCompanyPage(), //2
    const EditCompanyPage(), //3
    const EditCompany(), //4
    const CompanyEditImage(), //5
    const EditDirectButtonPage(), //6

    ///products
    AddProductScreen(), //7
    const AddPostPage(), //8

    ///ad orders
    const OrderListScreen(), //9
    const AdTrackingPage(), //10

    /// ad models
    AdModelScreen(), //11
    const SkipVideoScreen(), //12
    const SkipVideoSecondScreen(), //13
    const UploadVideoSecondScreen(), //14
    const CheckOutScreen(), //15
    SuccessScreen(), //16

    const EditButtonPage(), //17
    const ProductDetailScreen(), //18

    ///refer and earn
    const ReferPage(), //19
  ];

  changeWidget({required int value}) {
    selected.value = value;
  }

  List<String> homeMenusLocation = [
    'assets/icons/home.png',
    'assets/icons/ad_order.png',
    'assets/icons/notification.png',
    'assets/icons/Profile.png',
  ];
  Rx<int> selectedMenu = 0.obs;

  selectMenu({required int index}) {
    selectedMenu.value = index;
  }

  Future<void> logOutUser() async {
    try {
      await LocalPrefs().removeKey(key: SharedPreferenceKey.UserLoggedIn);
      await LocalPrefs().removeKey(key: SharedPreferenceKey.UserId);
      await Get.offAll(const LandingPage());
      Get.reset();
    } catch (e) {
      print("error in logout ${e}");
    }
  }

  Future<void> getAllPostsByUserId() async {
    postData.clear();
    loadingPost.value = true;
    final int? userId =
        LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId);
    try {
      final response = await _apiServices
          .getApi('${UrlConstants.getAllCompanyPostsById}$userId');
      PostModel adModel = PostModel.fromJson(response);
      postData.addAll(adModel.data ?? []);
      loadingPost.value = false;
    } catch (e) {
      loadingPost.value = false;
    } finally {
      loadingPost.value = false;
    }
  }
}
