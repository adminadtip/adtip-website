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
  CreateCompanyModelRequestData get userCompanyProfile =>
      _userCompanyProfile.value;

  final Rx<File> _imageBanner = File('').obs;
  Rx<File>? get imageBanner => _imageBanner;

  final Rx<File> _imageCompanyProfile = File('').obs;
  Rx<File>? get imageCompanyProfile => _imageCompanyProfile;
  List<CompanyDetail> fetchedCompanyList = [];
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
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return false;
      coverImage.value = image.path;
    } catch (e) {
      print('error $e');
    }
    return false;
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

  // Future<void> createCompanyPage() async {
  //   try {
  //     _isLoading.value = true;
  //     const url = "${UrlConstants.BASE_URL}createcompany";
  //     final uri = Uri.parse(url);
  //     var request = http.MultipartRequest('POST', uri);
  //     print(
  //         "beartoken ${LocalPrefs().getStringPref(key: SharedPreferenceKey.UserLoggedIn)}");
  //     request.headers.addAll({
  //       'Content-Type': 'application/json',
  //       "authorization":
  //           "Bearer ${LocalPrefs().getStringPref(key: SharedPreferenceKey.UserLoggedIn)}"
  //     });
  //     // request.files.add(await http.MultipartFile.fromPath(
  //     //     'coverImage', imageBanner!.value.path));
  //     //
  //     // request.files.add(await http.MultipartFile.fromPath(
  //     //     "profileImage", imageCompanyProfile!.value.path));
  //     request.fields["coverimage"] =
  //         'https://www.wallpaperbetter.com/wallpaper/975/878/515/cat-painting-kitten-paper-paint-splatter-1080P-wallpaper-middle-size.jpg';
  //     request.fields["profileimage"] =
  //         'https://www.wallpaperbetter.com/wallpaper/975/878/515/cat-painting-kitten-paper-paint-splatter-1080P-wallpaper-middle-size.jpg';
  //
  //     request.fields["name"] = _userCompanyProfile.value.companyName ?? "";
  //     request.fields['email'] = _userCompanyProfile.value.companyEmail ?? '';
  //     request.fields["website"] = _userCompanyProfile.value.websiteUrl ?? "";
  //     request.fields["location"] = _userCompanyProfile.value.location ?? "";
  //     request.fields["phone"] = _userCompanyProfile.value.phoneNumber ?? "";
  //     request.fields["industry"] = _userCompanyProfile.value.companyType ?? "";
  //     request.fields["about"] = _userCompanyProfile.value.description ?? "";
  //     request.fields["button"] = _userCompanyProfile.value.buttonType ?? '';
  //     request.fields["createdby"] = _userId.toString();
  //
  //     var streamedResponse = await request.send();
  //
  //     var response = await http.Response.fromStream(streamedResponse);
  //     print("## response:" + response.body);
  //     if (response.statusCode == 200) {
  //       Map resp = json.decode(response.body);
  //       Get.offAll(DashBoardPage());
  //       Get.off(MyCompanyPage(
  //         companyID: resp["data"][0]["id"].toString(),
  //       ));
  //     } else if (response.statusCode == 413) {
  //       showfailedMessage("Request Entity too large");
  //       _isLoading.value = false;
  //     } else {
  //       showfailedMessage(jsonDecode(response.body)["message"]);
  //       _isLoading.value = false;
  //     }
  //     _isLoading.value = false;
  //   } catch (e) {}
  // }

  Future<List<CompanyDetail>> fetchCompanyList(userId) async {
    try {
      fetchedCompanyList.clear();
      _isLoading.value = true;
      final jsonResponse = await _apiServices
          .getApi('${UrlConstants.getCompanyListURL}$_userId');
      List<dynamic> companyDataList = jsonResponse['data'];
      fetchedCompanyList = companyDataList
          .map((item) => CompanyDetail.fromJson(item as Map<String, dynamic>))
          .toList();
      // http.Response res = await http.get(
      //   Uri.parse('${UrlConstants.BASE_URL}getcompanylist/$userId'),
      //   headers: {
      //     'Content-Type': 'application/json; charset=UTF-8',
      //     "authorization":
      //         "Bearer ${LocalPrefs().getStringPref(key: SharedPreferenceKey.UserLoggedIn)}"
      //   },
      // );
      // if (res.statusCode == 200) {
      //   Map<String, dynamic> jsonResponse = json.decode(res.body);
      //   // Check if "data" is a list
      //   if (jsonResponse['status'] == 200) {
      //     if (jsonResponse['data'] is List) {
      //       // Extract the "name" and "industry" fields and store them in a list
      //       List<dynamic> companyDataList = jsonResponse['data'];
      //       fetchedCompanyList = companyDataList
      //           .map((item) =>
      //               CompanyDetail.fromJson(item as Map<String, dynamic>))
      //           .toList();
      //     }
      //   } else if (jsonResponse['status'] == 500) {
      //     PhoneLoginController contrl = Get.put(PhoneLoginController());
      //     contrl.logOutUser();
      //     Get.to(() => const CreateAccountPage());
      //   } else {
      //     // Handle the case where "data" is not a list
      //   }
      // }
      _isLoading.value = false;
    } catch (e) {
      _isLoading.value = false;
    }
    return fetchedCompanyList;
  }

  void generateCompanyQR(int companyID) async {
    try {
      _isLoading.value = true;
      http.Response res = await http.get(
        Uri.parse('${UrlConstants.BASE_URL}QRCode/$companyID'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "authorization":
              "Bearer ${LocalPrefs().getStringPref(key: SharedPreferenceKey.UserLoggedIn)}"
        },
      );
      if (res.statusCode == 200) {
        final bytes = res.bodyBytes;
        final temp = await getTemporaryDirectory();
        final path = '${temp.path}/image.png';
        File(path).writeAsBytesSync(bytes);

        await Share.shareXFiles([
          XFile(path),
        ], text: "Hello ! Checkout my Company Profile");
      } else {
        Utils.showErrorMessage('Error Getting Company QR');
        _isLoading.value = false;
      }
      _isLoading.value = false;
    } catch (e) {}
  }
}
