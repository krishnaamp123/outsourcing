class RegencyModel {
  int? provinceId;
  String? regency;

  RegencyModel({this.provinceId, this.regency});

  RegencyModel.fromJson(Map<String, dynamic> json) {
    provinceId = json['province_id'];
    regency = json['regency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province_id'] = this.provinceId;
    data['regency'] = this.regency;
    return data;
  }
}
