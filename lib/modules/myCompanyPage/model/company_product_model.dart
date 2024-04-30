class CompanyProductModel {
  int? id;
  String? name;
  String? description;
  dynamic productType;
  String? images;
  String? regularPrice;
  String? marketPrice;
  int? isActive;
  int? createdBy;

  CompanyProductModel(
      {this.id,
      this.name,
      this.description,
      this.productType,
      this.images,
      this.regularPrice,
      this.marketPrice,
      this.createdBy,
      this.isActive});

  CompanyProductModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    productType = json["productType"];
    if (json["images"] is String) {
      images = json["images"];
    }
    if (json["regular_price"] is String) {
      regularPrice = json["regular_price"];
    }
    if (json["market_price"] is String) {
      marketPrice = json["market_price"];
    }
    if (json["isActive"] is int) {
      isActive = json["isActive"];
    }
    if (json["created_by"] is int) {
      isActive = json["created_by"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["productType"] = productType;
    data["images"] = images;
    data["regular_price"] = regularPrice;
    data["market_price"] = marketPrice;
    data["isActive"] = isActive;
    data['created_by'] = createdBy;
    return data;
  }
}
