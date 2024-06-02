class QrAdWebModel {
  int status;
  String message;
  List<Datum> data;

  QrAdWebModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory QrAdWebModel.fromJson(Map<String, dynamic> json) => QrAdWebModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  int id;
  String? companyName;
  int? companyId;
  String? adName;
  int? adId;
  dynamic createdDate;
  String? userName;
  int? userId;
  int? mobileNumber;
  String? upiId;
  int? paid;
  String profession;

  Datum({
    required this.id,
    required this.companyName,
    required this.companyId,
    required this.adName,
    required this.adId,
    required this.createdDate,
    required this.userName,
    required this.userId,
    required this.mobileNumber,
    required this.upiId,
    required this.paid,
    required this.profession,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        companyName: json["company_name"],
        companyId: json["company_id"],
        adName: json["ad_name"],
        adId: json["ad_id"],
        createdDate: json["created_date"],
        userName: json["user_name"],
        userId: json["user_id"],
        mobileNumber: json["mobile_no"],
        upiId: json["upi_id"],
        paid: json["paid"],
        profession: json['profession'],
      );
}
