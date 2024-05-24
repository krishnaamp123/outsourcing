class MasterModel {
  int? id;
  String? categoryName;
  String? icon;
  String? description;

  MasterModel({this.id, this.categoryName, this.icon, this.description});

  MasterModel.fromJson(Map<String, dynamic> json) {
    id = json['payload']['data']['id'];
    categoryName = json['payload']['data']['category_name'];
    icon = json['payload']['data']['icon'];
    description = json['payload']['data']['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payload']['data']['id'] = this.id;
    data['payload']['data']['category_name'] = this.categoryName;
    data['payload']['data']['icon'] = this.icon;
    data['payload']['data']['description'] = this.description;
    return data;
  }
}
