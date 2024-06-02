import 'dart:convert';
import 'dart:io';
import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:adtip_web_3/modules/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../helpers/constants/colors.dart';
import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../netwrok/network_api_services.dart';
import '../../createCompany/model/companyDetail.dart';
import '../../createCompany/model/create_company_model.dart';
import '../../dashboard/pages/dashboard_page.dart';
import '../page/my_company_page.dart';

class EditCompanyController extends GetxController {
  final _userCompanyProfile = CreateCompanyModelRequestData().obs;
  final dashboardController = Get.put(DashboardController());
  CreateCompanyModelRequestData get userCompanyProfile =>
      _userCompanyProfile.value;

  final Rx<File> _imageBanner = File('').obs;
  Rx<File>? get imageBanner => _imageBanner;

  final Rx<File> _imageCompanyProfile = File('').obs;
  Rx<File>? get imageCompanyProfile => _imageCompanyProfile;
  RxString coverImage = ''.obs;
  RxString profileImage = ''.obs;

  final RxString _buttonSelected = "".obs;
  RxString get buttonSelected => _buttonSelected;

  final _isLoading = false.obs;
  RxBool get isLoading => _isLoading;
  final int? _userId =
      LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId);
  final _apiServices = NetworkApiServices();

  Future<bool> pickBannerImage() async {
    // try {
    //
    //   // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    //   // if (image == null) return false;
    //   // final File pathvlaue = File(image.path);
    //   // int sizeInBytes = pathvlaue.lengthSync();
    //   // double sizeInMb = sizeInBytes / (1024 * 1024);
    //   // sizeInMb = double.parse(sizeInMb.toStringAsFixed(4));
    //   //
    //   // if (sizeInMb <= 1) {
    //   //   _imageBanner.value = File(image.path);
    //   //   coverImage.value = image.path;
    //   //   update();
    //   //   return true;
    //   // } else {
    //   //   Utils.showErrorMessage('Please upload image less than 1mb');
    //   // }
    // } catch (e) {}
    // return false;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return false;
      coverImage.value = image.path;
      print('cover image ${coverImage.value}');
    } catch (e) {
      print('error $e');
    }
    return false;
  }

  Future<bool> pickCompanyProfileImage() async {
    // try {
    //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    //   if (image == null) return false;
    //   final File pathvlaue = File(image.path);
    //   int sizeInBytes = pathvlaue.lengthSync();
    //   double sizeInMb = sizeInBytes / (1024 * 1024);
    //   sizeInMb = double.parse(sizeInMb.toStringAsFixed(4));
    //
    //   if (sizeInMb <= 1) {
    //     _imageCompanyProfile.value = File(image.path);
    //     profileImage.value = image.path;
    //     update();
    //     return true;
    //   } else {
    //     Utils.showErrorMessage('Please upload image less than 1mb');
    //   }
    // } catch (e) {}
    // return false;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return false;
      profileImage.value = image.path;
    } catch (e) {}
    return false;
  }

  Future<void> updateCompany({required int companyId}) async {
    String? profileUrl;
    String? coverUrl;
    try {
      _isLoading.value = true;
      if (profileImage.isNotEmpty) {
        profileUrl = await Utils.uploadImageToAwsAmplify(
            path: profileImage.value, folderName: 'companyProfileImage');
      }
      if (coverImage.isNotEmpty) {
        coverUrl = await Utils.uploadImageToAwsAmplify(
            path: coverImage.value, folderName: 'companyCoverImage');
      }
      var body = {
        "name": _userCompanyProfile.value.companyName,
        "email": _userCompanyProfile.value.companyEmail,
        "website": _userCompanyProfile.value.websiteUrl,
        "location": _userCompanyProfile.value.location,
        "phone": _userCompanyProfile.value.phoneNumber,
        "industry": _userCompanyProfile.value.companyType,
        "about": _userCompanyProfile.value.description,
        "button": _userCompanyProfile.value.buttonType,
        "id": companyId,
        "coverImage": coverUrl,
        "profileImage": profileUrl
      };
      final response = await _apiServices.postApi(
        body,
        UrlConstants.updateCompany,
      );
      _isLoading.value = false;
      Utils.showSuccessMessage("company updated successfully");
      dashboardController.changeWidget(value: 0);
    } catch (e) {
      _isLoading.value = false;
      Utils.showErrorMessage('Error updating company');
    }
  }

  Future<List<CompanyDetail>> fetchCompanyList() async {
    List<CompanyDetail> fetchedCompanyList = [];
    try {
      _isLoading.value = true;
      print(_userId);
      http.Response res = await http.get(
        Uri.parse('${UrlConstants.BASE_URL}getcompanylist/$_userId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "authorization":
              "Bearer ${LocalPrefs().getStringPref(key: SharedPreferenceKey.UserLoggedIn)}"
        },
      );
      if (res.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(res.body);
        // Check if "data" is a list
        if (jsonResponse['data'] is List) {
          // Extract the "name" and "industry" fields and store them in a list
          List<dynamic> companyDataList = jsonResponse['data'];
          fetchedCompanyList = companyDataList
              .map((item) =>
                  CompanyDetail.fromJson(item as Map<String, dynamic>))
              .toList();
          print(fetchedCompanyList);
        } else {
          // Handle the case where "data" is not a list
        }
      }
      _isLoading.value = false;
    } catch (e) {}
    return fetchedCompanyList;
  }
}
