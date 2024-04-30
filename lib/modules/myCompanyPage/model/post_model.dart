class PostModel {
  int? status;
  String? message;
  List<PostData>? data;

  PostModel({this.status, this.message, this.data});

  PostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PostData>[];
      json['data'].forEach((v) {
        data!.add(PostData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PostData {
  int? id;
  String? postName;
  String? postDiscription;
  int? buttonid;
  String? website;
  String? imagePath;
  String? isPromoted;
  int? isActive;
  int? createdby;
  String? createddate;

  PostData(
      {this.id,
      this.postName,
      this.postDiscription,
      this.buttonid,
      this.website,
      this.imagePath,
      this.isPromoted,
      this.isActive,
      this.createdby,
      this.createddate});

  PostData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postName = json['PostName'];
    postDiscription = json['PostDiscription'];
    buttonid = json['buttonid'];
    website = json['website'];
    imagePath = json['image_path'];
    isPromoted = json['is_promoted'];
    isActive = json['is_active'];
    createdby = json['createdby'];
    createddate = json['createddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['PostName'] = postName;
    data['PostDiscription'] = postDiscription;
    data['buttonid'] = buttonid;
    data['website'] = website;
    data['image_path'] = imagePath;
    data['is_promoted'] = isPromoted;
    data['is_active'] = isActive;
    data['createdby'] = createdby;
    data['createddate'] = createddate;
    return data;
  }
}
