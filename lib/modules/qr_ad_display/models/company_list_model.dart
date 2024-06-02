// To parse this JSON data, do
//
//     final getCompanyModel = getCompanyModelFromJson(jsonString);

import 'dart:convert';

GetCompanyModel getCompanyModelFromJson(String str) =>
    GetCompanyModel.fromJson(json.decode(str));

String getCompanyModelToJson(GetCompanyModel data) =>
    json.encode(data.toJson());

class GetCompanyModel {
  int status;
  String message;
  List<Datum> data;

  GetCompanyModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetCompanyModel.fromJson(Map<String, dynamic> json) =>
      GetCompanyModel(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String? name;
  String? email;
  String? website;
  String? location;
  String? phone;
  String? industry;
  String? about;
  String? button;
  String? coverimage;
  String? profileimage;
  String? profileFilename;
  String? coverFilename;
  int? followers;
  int? rating;
  int? isActive;
  int? createdby;
  DateTime? createddate;
  dynamic updatedate;
  String? qrCodeImage;
  dynamic isFollow;
  String? coverImage;
  String? profileImage;

  Datum({
    required this.id,
    required this.name,
    required this.email,
    required this.website,
    required this.location,
    required this.phone,
    required this.industry,
    required this.about,
    required this.button,
    required this.coverimage,
    required this.profileimage,
    required this.profileFilename,
    required this.coverFilename,
    required this.followers,
    required this.rating,
    required this.isActive,
    required this.createdby,
    required this.createddate,
    required this.updatedate,
    required this.qrCodeImage,
    required this.isFollow,
    required this.coverImage,
    required this.profileImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        website: json["website"],
        location: json["location"],
        phone: json["phone"],
        industry: json["industry"],
        about: json["about"],
        button: json["button"],
        coverimage: json["coverimage"],
        profileimage: json["profileimage"],
        profileFilename: json["profileFilename"],
        coverFilename: json["coverFilename"],
        followers: json["followers"],
        rating: json["rating"],
        isActive: json["is_active"],
        createdby: json["createdby"],
        createddate: DateTime.parse(json["createddate"]),
        updatedate: json["updatedate"],
        qrCodeImage: json["qr_code_image"],
        isFollow: json["is_Follow"],
        coverImage: json["coverImage"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "website": website,
        "location": location,
        "phone": phone,
        "industry": industry,
        "about": about,
        "button": button,
        "coverimage": coverimage,
        "profileimage": profileimage,
        "profileFilename": profileFilename,
        "coverFilename": coverFilename,
        "followers": followers,
        "rating": rating,
        "is_active": isActive,
        "createdby": createdby,
        "createddate": createddate?.toIso8601String(),
        "updatedate": updatedate,
        "qr_code_image": qrCodeImage,
        "is_Follow": isFollow,
        "coverImage": coverImage,
        "profileImage": profileImage,
      };
}
