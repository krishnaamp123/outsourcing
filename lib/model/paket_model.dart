class PaketModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? updateEmailUser;
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
      this.updateEmailUser,
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
    updateEmailUser = json['update_email_user'];
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
    data['update_email_user'] = this.updateEmailUser;
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
  Service? service;
  int? totalEmployee;
  int? employeePrice;
  int? servicePrice;
  int? etcPrice;
  int? subTotalPrice;
  List<AdditionalPackageServiceItems>? additionalPackageServiceItems;

  Services(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.packageId,
      this.serviceId,
      this.service,
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
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    totalEmployee = json['total_employee'];
    employeePrice = json['employee_price'];
    servicePrice = json['service_price'];
    etcPrice = json['etc_price'];
    subTotalPrice = json['sub_total_price'];
    if (json['additional_package_service_items'] != null) {
      additionalPackageServiceItems = <AdditionalPackageServiceItems>[];
      json['additional_package_service_items'].forEach((v) {
        additionalPackageServiceItems!
            .add(new AdditionalPackageServiceItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['package_id'] = this.packageId;
    data['service_id'] = this.serviceId;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['total_employee'] = this.totalEmployee;
    data['employee_price'] = this.employeePrice;
    data['service_price'] = this.servicePrice;
    data['etc_price'] = this.etcPrice;
    data['sub_total_price'] = this.subTotalPrice;
    if (this.additionalPackageServiceItems != null) {
      data['additional_package_service_items'] =
          this.additionalPackageServiceItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Service {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  String? serviceName;
  String? mainImage;
  String? description;
  String? includes;
  int? employeePrice;
  int? servicePrice;
  int? etcPrice;
  int? discount;
  int? totalPrice;
  int? hourWork;

  Service(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.categoryId,
      this.serviceName,
      this.mainImage,
      this.description,
      this.includes,
      this.employeePrice,
      this.servicePrice,
      this.etcPrice,
      this.discount,
      this.totalPrice,
      this.hourWork});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    serviceName = json['service_name'];
    mainImage = json['main_image'];
    description = json['description'];
    includes = json['includes'];
    employeePrice = json['employee_price'];
    servicePrice = json['service_price'];
    etcPrice = json['etc_price'];
    discount = json['discount'];
    totalPrice = json['total_price'];
    hourWork = json['hour_work'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    data['service_name'] = this.serviceName;
    data['main_image'] = this.mainImage;
    data['description'] = this.description;
    data['includes'] = this.includes;
    data['employee_price'] = this.employeePrice;
    data['service_price'] = this.servicePrice;
    data['etc_price'] = this.etcPrice;
    data['discount'] = this.discount;
    data['total_price'] = this.totalPrice;
    data['hour_work'] = this.hourWork;
    return data;
  }
}

class AdditionalPackageServiceItems {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? packageServiceId;
  String? packageService;
  int? additionalItemServiceId;
  AdditionalItemService? additionalItemService;
  int? quantity;
  int? price;
  int? subTotalPrice;

  AdditionalPackageServiceItems(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.packageServiceId,
      this.packageService,
      this.additionalItemServiceId,
      this.additionalItemService,
      this.quantity,
      this.price,
      this.subTotalPrice});

  AdditionalPackageServiceItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    packageServiceId = json['package_service_id'];
    packageService = json['package_service'];
    additionalItemServiceId = json['additional_item_service_id'];
    additionalItemService = json['additional_item_service'] != null
        ? new AdditionalItemService.fromJson(json['additional_item_service'])
        : null;
    quantity = json['quantity'];
    price = json['price'];
    subTotalPrice = json['sub_total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['package_service_id'] = this.packageServiceId;
    data['package_service'] = this.packageService;
    data['additional_item_service_id'] = this.additionalItemServiceId;
    if (this.additionalItemService != null) {
      data['additional_item_service'] = this.additionalItemService!.toJson();
    }
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['sub_total_price'] = this.subTotalPrice;
    return data;
  }
}

class AdditionalItemService {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? serviceId;
  String? itemName;
  int? minQuantity;
  int? maxQuantity;
  int? pricePerItem;
  String? description;

  AdditionalItemService(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.serviceId,
      this.itemName,
      this.minQuantity,
      this.maxQuantity,
      this.pricePerItem,
      this.description});

  AdditionalItemService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    serviceId = json['service_id'];
    itemName = json['item_name'];
    minQuantity = json['min_quantity'];
    maxQuantity = json['max_quantity'];
    pricePerItem = json['price_per_item'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['service_id'] = this.serviceId;
    data['item_name'] = this.itemName;
    data['min_quantity'] = this.minQuantity;
    data['max_quantity'] = this.maxQuantity;
    data['price_per_item'] = this.pricePerItem;
    data['description'] = this.description;
    return data;
  }
}
