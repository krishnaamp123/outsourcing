class RegencyModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? provinceId;
  String? regency;

  RegencyModel(
      {this.id, this.createdAt, this.updatedAt, this.provinceId, this.regency});

  RegencyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    provinceId = json['province_id'];
    regency = json['regency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['province_id'] = this.provinceId;
    data['regency'] = this.regency;
    return data;
  }
}
