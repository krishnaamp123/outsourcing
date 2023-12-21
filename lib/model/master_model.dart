class MasterModel {
  int? id;
  String? categoryName;
  String? icon;
  String? description;

  MasterModel({this.id, this.categoryName, this.icon, this.description});

  MasterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    icon = json['icon'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['icon'] = this.icon;
    data['description'] = this.description;
    return data;
  }
}
