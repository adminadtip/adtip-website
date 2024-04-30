class CompanyResponse {
  int? status;
  String? message;
  List<CompanyDetail>? companyDetails;

  CompanyResponse(
      {required this.status,
      required this.message,
      required this.companyDetails});

  factory CompanyResponse.fromJson({required Map<String, dynamic> json}) {
    return CompanyResponse(
        status: json['status'],
        message: json['message'],
        companyDetails: json['data'].isEmpty
            ? []
            : List<CompanyDetail>.from(
                json["data"].map((x) => CompanyDetail.fromJson(x))));
  }
}

class CompanyDetail {
  int? id;
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
  String? createddate;
  String? updatedate;
  String? qrCodeImage;
  int? isFollow;
  String? coverImage;
  String? profileImage;

  CompanyDetail(
      {this.id,
      this.name,
      this.email,
      this.website,
      this.location,
      this.phone,
      this.industry,
      this.about,
      this.button,
      this.coverimage,
      this.profileimage,
      this.profileFilename,
      this.coverFilename,
      this.followers,
      this.rating,
      this.isActive,
      this.createdby,
      this.createddate,
      this.updatedate,
      this.qrCodeImage,
      this.isFollow,
      this.coverImage,
      this.profileImage});

  factory CompanyDetail.fromJson(Map<String, dynamic> json) {
    return CompanyDetail(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      website: json['website'],
      location: json['location'],
      phone: json['phone'],
      industry: json['industry'],
      about: json['about'],
      button: json['button'],
      coverImage: json['coverimage'],
      profileImage: json['profileimage'],
      profileFilename: json['profileFilename'],
      coverFilename: json['coverFilename'],
      followers: json['followers'],
      rating: json['rating'],
      isActive: json['is_active'],
      createdby: json['createdby'],
      createddate: json['createddate'],
      updatedate: json['updatedate'],
      qrCodeImage: json['qr_code_image'],
      isFollow: json['is_Follow'],
      coverimage: json['coverimage'],
      profileimage: json['profileimage'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["website"] = website;
    data["location"] = location;
    data["phone"] = phone;
    data["industry"] = industry;
    data["about"] = about;
    data["button"] = button;
    data["coverimage"] = coverimage;
    data["profileimage"] = profileimage;
    data["profileFilename"] = profileFilename;
    data["coverFilename"] = coverFilename;
    data["followers"] = followers;
    data["rating"] = rating;
    data["is_active"] = isActive;
    data["createdby"] = createdby;
    data["createddate"] = createddate;
    data["updatedate"] = updatedate;
    data["qr_code_image"] = qrCodeImage;
    data["is_Follow"] = isFollow;
    data["coverImage"] = coverImage;
    data["profileImage"] = profileImage;
    return data;
  }
}
