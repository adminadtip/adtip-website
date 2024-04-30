import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../helpers/constants/url_constants.dart';
import '../../../helpers/local_database/local_prefs.dart';
import '../../../helpers/local_database/sharedpref_key.dart';
import '../../../netwrok/network_api_services.dart';
import '../../createCompany/model/companyDetail.dart';
import '../model/company_product_model.dart';

class MyCompanyController extends GetxController {
  final _isLoading = false.obs;
  final _apiServices = NetworkApiServices();
  RxBool get isLoading => _isLoading;
  Rx<bool> companyDetailsFetching = false.obs;

  RxList<CompanyProductModel> companyProductList = <CompanyProductModel>[].obs;
  final int? _userId =
      LocalPrefs().getIntegerPref(key: SharedPreferenceKey.UserId);
  Rx<CompanyDetail?> company = Rx<CompanyDetail?>(null);

  Future fetchSingleCompany({required String companyId}) async {
    companyDetailsFetching.value = true;
    try {
      final response = await _apiServices.getApi(
          '${UrlConstants.getSingleCompany}/${int.tryParse(companyId)}/$_userId');
      CompanyResponse companyResponse =
          CompanyResponse.fromJson(json: response);
      if (companyResponse.companyDetails!.isNotEmpty) {
        company.value = companyResponse.companyDetails![0];
        print('company data ${company.value?.coverImage!}');
      }
      companyDetailsFetching.value = false;
    } catch (e) {
      companyDetailsFetching.value = false;
      print('error occurred fetching company $e');
    }
  }

  Future<List<CompanyProductModel>> fetchCompanyProductList(
      String companyId) async {
    try {
      _isLoading.value = true;
      print(_userId);
      http.Response res = await http.get(
        Uri.parse('${UrlConstants.BASE_URL}getProductlist/$companyId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "authorization":
              "Bearer ${LocalPrefs().getStringPref(key: SharedPreferenceKey.UserLoggedIn)}"
        },
      );
      if (res.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(res.body);
        // Check if "data" is a list
        if (jsonResponse['status'] == 200) {
          if (jsonResponse['data'] is List) {
            List<dynamic> resp = jsonResponse['data'];
            companyProductList.value = resp
                .map((item) =>
                    CompanyProductModel.fromJson(item as Map<String, dynamic>))
                .toList();
            print('product list ${companyProductList.length}');
          }
        } else {
          // Handle the case where "data" is not a list
        }
      }
      _isLoading.value = false;
    } catch (e) {}
    return companyProductList;
  }
}
