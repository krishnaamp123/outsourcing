class PaketModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  bool? isCustom;
  String? packageName;
  String? mainImage;
  String? description;
  String? includes;
  int? minContract;
  int? employeePrice;
  int? servicePrice;
  int? etcPrice;
  int? discount;
  int? totalPrice;
  List<Services>? services;

  PaketModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.isCustom,
      this.packageName,
      this.mainImage,
      this.description,
      this.includes,
      this.minContract,
      this.employeePrice,
      this.servicePrice,
      this.etcPrice,
      this.discount,
      this.totalPrice,
      this.services});

  PaketModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isCustom = json['is_custom'];
    packageName = json['package_name'];
    mainImage = json['main_image'];
    description = json['description'];
    includes = json['includes'];
    minContract = json['min_contract'];
    employeePrice = json['employee_price'];
    servicePrice = json['service_price'];
    etcPrice = json['etc_price'];
    discount = json['discount'];
    totalPrice = json['total_price'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_custom'] = this.isCustom;
    data['package_name'] = this.packageName;
    data['main_image'] = this.mainImage;
    data['description'] = this.description;
    data['includes'] = this.includes;
    data['min_contract'] = this.minContract;
    data['employee_price'] = this.employeePrice;
    data['service_price'] = this.servicePrice;
    data['etc_price'] = this.etcPrice;
    data['discount'] = this.discount;
    data['total_price'] = this.totalPrice;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? packageId;
  int? serviceId;
  int? totalEmployee;
  int? employeePrice;
  int? servicePrice;
  int? etcPrice;
  int? subTotalPrice;
  Null? additionalPackageServiceItems;

  Services(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.packageId,
      this.serviceId,
      this.totalEmployee,
      this.employeePrice,
      this.servicePrice,
      this.etcPrice,
      this.subTotalPrice,
      this.additionalPackageServiceItems});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    packageId = json['package_id'];
    serviceId = json['service_id'];
    totalEmployee = json['total_employee'];
    employeePrice = json['employee_price'];
    servicePrice = json['service_price'];
    etcPrice = json['etc_price'];
    subTotalPrice = json['sub_total_price'];
    additionalPackageServiceItems = json['additional_package_service_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['package_id'] = this.packageId;
    data['service_id'] = this.serviceId;
    data['total_employee'] = this.totalEmployee;
    data['employee_price'] = this.employeePrice;
    data['service_price'] = this.servicePrice;
    data['etc_price'] = this.etcPrice;
    data['sub_total_price'] = this.subTotalPrice;
    data['additional_package_service_items'] =
        this.additionalPackageServiceItems;
    return data;
  }
}
