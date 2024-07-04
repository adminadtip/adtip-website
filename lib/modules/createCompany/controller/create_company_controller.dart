import 'dart:convert';
import 'dart:io';
import 'package:adtip_web_3/modules/dashboard/pages/dashboard_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../helpers/utils/utils.dart';
import '../../../netwrok/network_api_services.dart';
import '../model/companyDetail.dart';
import '../model/create_company_model.dart';

class CreateCompanyController extends GetxController {
  final _userCompanyProfile = CreateCompanyModelRequestData().obs;
  Rx<int> selectedCompany = 0.obs;
  Rx<int> selectedCompanyId = 0.obs;

  ///for create company first page
  RxList<CompanyDetail> checkCompanyList = <CompanyDetail>[].obs;
  RxString errorMessageForCompanyExist = ''.obs;
  RxBool isCompanyNameAlreadyUsed = true.obs;
  RxBool isCheckingCompanyName = false.obs;

  ///for create company first page
  CreateCompanyModelRequestData get userCompanyProfile =>
      _userCompanyProfile.value;

  final Rx<File> _imageBanner = File('').obs;
  Rx<File>? get imageBanner => _imageBanner;

  final Rx<File> _imageCompanyProfile = File('').obs;
  Rx<File>? get imageCompanyProfile => _imageCompanyProfile;
  //List<CompanyDetail> fetchedCompanyLis = [];
  RxList<CompanyDetail> fetchedCompanyList = <CompanyDetail>[].obs;
  RxString coverImage = ''.obs;
  RxString profileImage = ''.obs;

  final RxString _buttonSelected = "".obs;
  RxString get buttonSelected => _buttonSelected;

  final _isLoading = false.obs;
  Rx<bool> fetchingCompany = false.obs;
  RxBool get isLoading => _isLoading;
  final int? _userId =
      LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId);
  final _apiServices = NetworkApiServices();

  Future<bool> pickBannerImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return false;
      coverImage.value = image.path;
    } catch (e) {
      print('error $e');
    }
    return false;
  }

  void changeCompanyIndex({required int index, required int companyId}) {
    selectedCompany.value = index;
    selectedCompanyId.value = companyId;
  }

  Future<bool> pickCompanyProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return false;
      profileImage.value = image.path;
    } catch (e) {}
    return false;
  }

  Future<void> createNewCompany() async {
    try {
      _isLoading.value = true;
      List<String?> images = await Future.wait([
        Utils.uploadImageToAwsAmplify(
            path: coverImage.value, folderName: 'companyProfileImage'),
        Utils.uploadImageToAwsAmplify(
            path: profileImage.value, folderName: 'companyProfileImage')
      ]);
      if (images[0] != null && images[1] != null) {
        print('image 1 ${images[0]} image 2 ${images[1]}');
        final body = {
          "name": _userCompanyProfile.value.companyName ?? "",
          "email": _userCompanyProfile.value.companyEmail ?? '',
          "website": _userCompanyProfile.value.websiteUrl ?? "",
          "location": _userCompanyProfile.value.location ?? "",
          "phone": _userCompanyProfile.value.phoneNumber ?? "",
          "industry": _userCompanyProfile.value.companyType ?? "",
          "about": _userCompanyProfile.value.description ?? "",
          "button": _userCompanyProfile.value.buttonType ?? '',
          "coverimage": images[0],
          "profileimage": images[1],
          "createdby": _userId
        };
        final response = await _apiServices.postApi(
          body,
          UrlConstants.createNewCompany,
        );
        _isLoading.value = false;
        Utils.showSuccessMessage("company created successfully");
        Get.offAll(const DashboardPage());
      } else {
        _isLoading.value = false;
        Utils.showErrorMessage('Error uploading profile image');
      }
    } catch (e) {
      print('error $e');
      _isLoading.value = false;
    }
  }

  Future<List<CompanyDetail>> fetchCompanyList() async {
    final int? userId =
        LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId);
    try {
      fetchingCompany.value = true;
      _isLoading.value = true;
      final jsonResponse =
          await _apiServices.getApi('${UrlConstants.getCompanyListURL}$userId');
      List<dynamic> companyDataList = jsonResponse['data'];
      fetchedCompanyList.value = companyDataList
          .map((item) => CompanyDetail.fromJson(item as Map<String, dynamic>))
          .toList();
      _isLoading.value = false;

      if (fetchedCompanyList.isNotEmpty) {
        selectedCompanyId.value = fetchedCompanyList[0].id!;
      }
      fetchingCompany.value = false;
    } catch (e) {
      fetchingCompany.value = false;
      print('error occurred $e');
      _isLoading.value = false;
    } finally {
      fetchingCompany.value = false;
    }
    return fetchedCompanyList;
  }

  void fetchCompaniesList(String value) async {
    try {
      final int? userId =
          LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId);
      isCheckingCompanyName.value = true;
      final jsonResponse =
          await _apiServices.getApi('${UrlConstants.getCompanyListURL}$userId');
      List<dynamic> companyDataList = jsonResponse['data'];
      checkCompanyList.value = companyDataList
          .map((item) => CompanyDetail.fromJson(item as Map<String, dynamic>))
          .toList();

      if (checkCompanyList.isNotEmpty) {
        var result = checkCompanyList.firstWhere(
            (element) =>
                element.name!.toLowerCase().removeAllWhitespace ==
                value.toLowerCase().removeAllWhitespace,
            orElse: () => CompanyDetail());
        print('name ${result.name}');
        if (result.name != null) {
          isCompanyNameAlreadyUsed.value = true;
          print('company name exist');
          errorMessageForCompanyExist.value = 'Company name Already Taken!';
        } else {
          print('company name does not exist');
          isCompanyNameAlreadyUsed.value = false;
          errorMessageForCompanyExist.value = '';
        }
      }
      isCheckingCompanyName.value = false;
    } catch (e) {
      print('error $e');
      isCheckingCompanyName.value = false;
    }
  }

  Future<void> deleteCompany({required int companyId}) async {
    try {
      final body = {
        'id': companyId,
      };
      final response = await _apiServices.postApi(
        body,
        UrlConstants.deleteCompany,
      );
      print('response delteing company ${response}');
    } catch (e) {
      print('error occurred deleting company $e');
    }
  }
}
