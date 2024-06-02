class GraphModel {
  int? status;
  String? message;
  GraphData? data;

  GraphModel({this.status, this.message, this.data});

  GraphModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? GraphData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class GraphData {
  List<IsLike>? isLike;
  List<IsLike>? isView;
  List<IsLike>? isFollow;
  List<IsLikeUserList>? isLikeUserList;
  List<IsLikeUserList>? isViewUserList;
  List<IsLikeUserList>? isFollowUserList;
  String? dateformat;

  GraphData(
      {this.isLike,
      this.isView,
      this.isFollow,
      this.isLikeUserList,
      this.isViewUserList,
      this.isFollowUserList,
      this.dateformat});

  GraphData.fromJson(Map<String, dynamic> json) {
    if (json['isLike'] != null) {
      isLike = <IsLike>[];
      json['isLike'].forEach((v) {
        isLike!.add(IsLike.fromJson(v));
      });
    }
    if (json['isView'] != null) {
      isView = <IsLike>[];
      json['isView'].forEach((v) {
        isView!.add(IsLike.fromJson(v));
      });
    }
    if (json['isFollow'] != null) {
      isFollow = <IsLike>[];
      json['isFollow'].forEach((v) {
        isFollow!.add(IsLike.fromJson(v));
      });
    }
    if (json['isLikeUserList'] != null) {
      isLikeUserList = <IsLikeUserList>[];
      json['isLikeUserList'].forEach((v) {
        isLikeUserList!.add(IsLikeUserList.fromJson(v));
      });
    }
    if (json['isViewUserList'] != null) {
      isViewUserList = <IsLikeUserList>[];
      json['isViewUserList'].forEach((v) {
        isViewUserList!.add(IsLikeUserList.fromJson(v));
      });
    }
    if (json['isFollowUserList'] != null) {
      isFollowUserList = <IsLikeUserList>[];
      json['isFollowUserList'].forEach((v) {
        isFollowUserList!.add(IsLikeUserList.fromJson(v));
      });
    }
    dateformat = json['dateformat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (isLike != null) {
      data['isLike'] = isLike!.map((v) => v.toJson()).toList();
    }
    if (isView != null) {
      data['isView'] = isView!.map((v) => v.toJson()).toList();
    }
    if (isFollow != null) {
      data['isFollow'] = isFollow!.map((v) => v.toJson()).toList();
    }
    if (isLikeUserList != null) {
      data['isLikeUserList'] = isLikeUserList!.map((v) => v.toJson()).toList();
    }
    if (isViewUserList != null) {
      data['isViewUserList'] = isViewUserList!.map((v) => v.toJson()).toList();
    }
    if (isFollowUserList != null) {
      data['isFollowUserList'] =
          isFollowUserList!.map((v) => v.toJson()).toList();
    }
    data['dateformat'] = dateformat;
    return data;
  }
}

class IsLike {
  int? count;
  int? xAxis;

  IsLike({this.count, this.xAxis});

  IsLike.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    xAxis = json['xAxis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = count;
    data['xAxis'] = xAxis;
    return data;
  }
}

class IsLikeUserList {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? emailId;
  String? gender;
  String? dob;
  String? profileImage;
  String? messageId;
  String? mobileNumber;
  String? otp;
  int? userType;
  String? profession;
  String? maternalStatus;
  String? address;
  String? longitude;
  String? latitude;
  String? pincode;
  String? currentOtpVerified;
  String? createdDate;
  String? updatedDate;
  int? isOtpVerified;
  int? isSaveUserDetails;
  int? isActive;
  String? createdby;
  int? accessType;
  int? onlineStatus;
  String? deviceToken;
  String? isBlock;
  String? isMute;

  IsLikeUserList(
      {this.id,
      this.name,
      this.firstName,
      this.lastName,
      this.emailId,
      this.gender,
      this.dob,
      this.profileImage,
      this.messageId,
      this.mobileNumber,
      this.otp,
      this.userType,
      this.profession,
      this.maternalStatus,
      this.address,
      this.longitude,
      this.latitude,
      this.pincode,
      this.currentOtpVerified,
      this.createdDate,
      this.updatedDate,
      this.isOtpVerified,
      this.isSaveUserDetails,
      this.isActive,
      this.createdby,
      this.accessType,
      this.onlineStatus,
      this.deviceToken,
      this.isBlock,
      this.isMute});

  IsLikeUserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    gender = json['gender'];
    dob = json['dob'];
    profileImage = json['profile_image'];
    messageId = json['message_id'];
    mobileNumber = json['mobile_number'];
    otp = json['otp'];
    userType = json['user_type'];
    profession = json['profession'];
    maternalStatus = json['maternal_status'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    pincode = json['pincode'];
    currentOtpVerified = json['current_otp_verified'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    isOtpVerified = json['isOtpVerified'];
    isSaveUserDetails = json['isSaveUserDetails'];
    isActive = json['is_active'];
    createdby = json['createdby'];
    accessType = json['access_type'];
    onlineStatus = json['online_status'];
    deviceToken = json['device_token'];
    isBlock = json['is_block'];
    isMute = json['is_mute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['emailId'] = emailId;
    data['gender'] = gender;
    data['dob'] = dob;
    data['profile_image'] = profileImage;
    data['message_id'] = messageId;
    data['mobile_number'] = mobileNumber;
    data['otp'] = otp;
    data['user_type'] = userType;
    data['profession'] = profession;
    data['maternal_status'] = maternalStatus;
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['pincode'] = pincode;
    data['current_otp_verified'] = currentOtpVerified;
    data['created_date'] = createdDate;
    data['updated_date'] = updatedDate;
    data['isOtpVerified'] = isOtpVerified;
    data['isSaveUserDetails'] = isSaveUserDetails;
    data['is_active'] = isActive;
    data['createdby'] = createdby;
    data['access_type'] = accessType;
    data['online_status'] = onlineStatus;
    data['device_token'] = deviceToken;
    data['is_block'] = isBlock;
    data['is_mute'] = isMute;
    return data;
  }
}
