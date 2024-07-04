class QrAdDetails {
  int? status;
  String? message;
  List<QrAdDetailsModel> list = [];

  QrAdDetails(
      {required this.status, required this.message, required this.list});
  factory QrAdDetails.fromJson(Map<String, dynamic> json) => QrAdDetails(
      status: json['status'],
      message: json['message'],
      list: List<QrAdDetailsModel>.from(
          json['data'].map((x) => QrAdDetailsModel.fromJson(x))));
}

class QrAdDetailsModel {
  dynamic adId;
  dynamic adUrl;
  dynamic companyName;
  dynamic companyProfile;
  dynamic adWebsite;
  dynamic companyWebsite;
  dynamic companyId;

  QrAdDetailsModel(
      {required this.adId,
      required this.adUrl,
      required this.companyName,
      required this.companyWebsite,
      required this.companyId,
      required this.companyProfile,
      required this.adWebsite});
  factory QrAdDetailsModel.fromJson(Map<String, dynamic> json) =>
      QrAdDetailsModel(
          adId: json['ad_id'],
          adUrl: json['ad_upload_filename'],
          companyName: json['name'],
          adWebsite: json['ad_website_link'],
          companyWebsite: json['website'],
          companyId: json['company_id'],
          companyProfile: json['profileimage']);
}
