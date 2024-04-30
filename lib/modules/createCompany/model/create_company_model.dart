class CreateCompanyModelRequestData {
  String? companyName;
  String? companyEmail;
  String? phoneNumber;
  String? location;
  String? description;
  String? websiteUrl;
  String? companyType;
  String? imageBanner;
  String? profileImage;
  String? buttonType;
  bool? showOnProfile;
  int? userid;

  CreateCompanyModelRequestData();

  Map<String, dynamic> toJson() => {
        'name': companyName,
        'website': companyEmail,
        'location': location,
        'Phone': phoneNumber,
        "industry": companyType,
        "about": description,
        "button": buttonType,
        "createdby": userid,
      };
}
