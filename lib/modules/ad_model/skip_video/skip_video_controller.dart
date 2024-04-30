import 'dart:io';
import 'package:adtip_web_3/helpers/utils/utils.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../netwrok/network_api_services.dart';
import '../../myCompanyPage/model/profession_list.dart';
import '../models/ad_model_first_page.dart';
import '../models/company_list.dart';
import '../models/last_data_fill.dart';

class SkipVideoController extends GetxController {
  final List<dynamic> companyListData = [];
  final List<ProfessionListData> areaListData = [];
  final List<LastFillData> lastFillData = [];

  final adModelFirstPage = AdModelFirstPage().obs;
  final loading = false.obs;
  final loadingData = false.obs;

  final loadingVideo = false.obs;
  final videoUrl = ''.obs;
  final imageUrl = ''.obs;
  final videoPath = ''.obs;
  final imagePath = ''.obs;

  final loadingButton = false.obs;
  final _apiServices = NetworkApiServices();
  final loadingFirst = false.obs;
  final loadingSecond = false.obs;
  final loadingThird = false.obs;
  final id = "".obs;
  Future getCompanyList() async {
    int userId =
        LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId) ?? 0;

    if (companyListData.isEmpty) {
      try {
        companyListData.clear();
        loading.value = true;
        final response = await _apiServices.getApi(
            "${UrlConstants.getCompanyListURL}" + userId.toString()
            //{LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId) ?? 0}"
            );
        CompanyListModel productListModel = CompanyListModel.fromJson(response);
        companyListData.addAll(productListModel.data ?? []);
        loading.value = false;
      } on Exception catch (e) {
        loading.value = false;

        print(e);
      }
    }
  }

  Future getAreaList() async {
    if (areaListData.isEmpty) {
      try {
        areaListData.clear();
        loading.value = true;
        final response = await _apiServices.getApi(UrlConstants.getAreaListURL);
        ProfessionListModel productListModel =
            ProfessionListModel.fromJson(response);
        areaListData.addAll(productListModel.data ?? []);
        loading.value = false;
      } on Exception catch (e) {
        loading.value = false;

        print(e);
      }
    }
  }

  void updateVideoUrlFromSelfChannel(String videoUrlFromSelfChannel) {
    videoUrl.value = videoUrlFromSelfChannel;
    print('video url in controller ${videoUrl.value}');
  }

  Future videoUpload() async {
    try {
      final imagePicker = ImagePicker();
      final image = await imagePicker.pickVideo(source: ImageSource.gallery);

      if (image?.path != null) {
        loadingVideo.value = true;

        String? fileString = image?.path.split('/').last;
        print(fileString);
        videoPath.value = fileString ?? "";
        videoUrl.value = await Utils.uploadVideoToAwsAmplify(
            path: image!.path, folderName: 'Ads Video');
        // videoUrl.value = (await AwsS3.uploadFile(
        //       acl: ACL.bucket_owner_full_control,
        //       accessKey: "AKIAWOVUZ5ONNYTS5G7O",
        //       secretKey: "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",
        //       file: File(image?.path ?? ""),
        //       bucket: "adtipbucket",
        //       region: "ap-south-1",
        //       destDir: 'video',
        //     )) ??
        //     "";
        // print("## " + videoUrl.value);
      }
      loadingVideo.value = false;
    } catch (e) {
      loadingVideo.value = false;
      print(e);
    }
  }

  Future imageUpload() async {
    try {
      final imagePicker = ImagePicker();
      final image = await imagePicker.pickImage(source: ImageSource.gallery);
      print(image?.path);
      if (image?.path != null) {
        loadingVideo.value = true;

        String? fileString = image?.path.split('/').last;
        print(fileString);
        imagePath.value = fileString ?? "";
        // imageUrl.value = (await AwsS3.uploadFile(
        //       acl: ACL.bucket_owner_full_control,
        //       accessKey: "AKIAWOVUZ5ONNYTS5G7O",
        //       secretKey: "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",
        //       file: File(image?.path ?? ""),
        //       bucket: "adtipbucket",
        //       region: "ap-south-1",
        //       destDir: 'image',
        //     )) ??
        //     "";
        // print("## " + imageUrl.value);
      }
      loadingVideo.value = false;
    } catch (e) {
      loadingVideo.value = false;
      print(e);
    }
  }

  Future saveFirstPageAdModel({
    String? companyName,
    String? campaignName,
    String? targetGender,
    String? maritalStatus,
    String? targetLowerAge,
    String? targetUpperAge,
    String? targetProfessions,
    String? targetArea,
    String? adwatchPerDay,
    String? adPerdayPay,
    String? adSpendPerDay,
    String? companyId,
    String? adModelId,
    String? createdby,
    String? adStartDate,
    String? adEndDate,
    String? adTime,
    String? adEndTime,
    String? adCustomerTargetPerDay,
    required Function() onSuccess,
  }) async {
    Map data = {
      'companyName': companyName,
      'campaignName': campaignName,
      'targetGender': targetGender,
      'maritalStatus': maritalStatus,
      'targetLowerAge': targetLowerAge,
      'targetUpperAge': targetUpperAge,
      'targetProfessions': targetProfessions,
      'targetArea': targetArea,
      'adwatchPerDay': adwatchPerDay,
      'adPerdayPay': adPerdayPay,
      'adSpendPerDay': adSpendPerDay,
      'companyId': companyId,
      'adModelId': adModelId,
      'createdby': createdby,
      'adStartDate': adStartDate,
      'adEndDate': adEndDate,
      'adTime': adTime,
      'adEndTime': adEndTime,
      'adCustomerTargetPerDay': adCustomerTargetPerDay,
    };

    try {
      print(data);
      print('company id ${data['companyId']}');
      loadingFirst.value = true;
      final response = await _apiServices.postApi(
          data, UrlConstants.savefirstpageadmodelURL);
      print("${response['data'][0]['id']}uuuuuu");
      id.value = response['data'][0]['id'].toString();
      await onSuccess();
      loadingFirst.value = false;
      print(id.value);
      loadingFirst.value = false;
    } on Exception catch (e) {
      loadingFirst.value = false;

      print(e);
    }
  }

  Future saveSecondPageAdModel({
    String? adPerViewPercentage,
    String? adPerPreviewPercentage,
    String? adCommentsOn,
    String? adFile,
    String? mediaType,
    String? adAnimationId,
    int? adButtonTextId,
    required Function() onSuccess,
  }) async {
    Map data = {
      'id': id.value,
      'adPerViewPercentage': adPerViewPercentage,
      'adPerPreviewPercentage': adPerPreviewPercentage,
      'adCommentsOn': adCommentsOn,
      'adFile': adFile,
      'mediaType': mediaType != "" ? mediaType : "1",
      'adAnimationId': adAnimationId,
      'adButtonTextId': adButtonTextId,
    };

    try {
      print(data);
      loadingSecond.value = true;
      await _apiServices.postApi(data, UrlConstants.savesecondpageadmodelURL);
      await onSuccess();
      loadingSecond.value = false;
    } on Exception catch (e) {
      loadingSecond.value = false;

      print(e);
    }
  }

  Future saveThirdPageAdModel({
    String? adDescription,
    String? adWebsiteLink,
    String? adWebsite,
    String? adCompanyLocation,
    String? adTaxNumber,
    String? adPlaceApp,
    String? adRefferal,
    String? adPaymendMode,
    String? adOrderValue,
    String? adChargesValue,
    String? adTax,
    String? adTotal,
    String? adCoupan,
    required Function() onSuccess,
  }) async {
    Map data = {
      'id': id.value,
      'adDescription': adDescription,
      'adWebsiteLink': adWebsiteLink,
      'adWebsite': adWebsite,
      'adCompanyLocation': adCompanyLocation,
      'adTaxNumber': adTaxNumber,
      'adPlaceApp': adPlaceApp,
      'adRefferal': adRefferal,
      'adPaymendMode': adPaymendMode,
      'adOrderValue': adOrderValue,
      'adChargesValue': adChargesValue,
      'adTax': adTax,
      'adTotal': adTotal,
      'adCoupan': adCoupan
    };

    try {
      print(data);
      loadingThird.value = true;
      await _apiServices.postApi(data, UrlConstants.saveThirdpageadmodelURL);
      await onSuccess();
      loadingThird.value = false;
    } on Exception catch (e) {
      loadingFirst.value = false;

      print(e);
    }
  }

  Future getLastDataFill(int companyId) async {
    int userId =
        LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId) ?? 0;
    try {
      lastFillData.clear();
      loadingData.value = true;
      final response = await _apiServices
          .getApi("${UrlConstants.lastDataComapnyUrl}$companyId/$userId");
      LastFillDataModel productListModel = LastFillDataModel.fromJson(response);
      print("${productListModel.data?.isNotEmpty}99999");
      if (productListModel.data?.isNotEmpty ?? false) {
        lastFillData.addAll(productListModel.data ?? []);
      }
      loadingData.value = false;
    } on Exception catch (e) {
      loadingData.value = false;

      print(e);
    }
  }
}
