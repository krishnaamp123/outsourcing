class LayananModel {
  List<AdditionalItems>? additionalItems;
  Category? category;
  String? description;
  int? employeePrice;
  int? etcPrice;
  int? hourWork;
  int? id;
  String? includes;
  String? mainImage;
  List<RequiredItems>? requiredItems;
  String? serviceName;
  int? servicePrice;
  int? totalPrice;

  LayananModel(
      {this.additionalItems,
      this.category,
      this.description,
      this.employeePrice,
      this.etcPrice,
      this.hourWork,
      this.id,
      this.includes,
      this.mainImage,
      this.requiredItems,
      this.serviceName,
      this.servicePrice,
      this.totalPrice});

  LayananModel.fromJson(Map<String, dynamic> json) {
    if (json['additional_items'] != null) {
      additionalItems = <AdditionalItems>[];
      json['additional_items'].forEach((v) {
        additionalItems!.add(new AdditionalItems.fromJson(v));
      });
    }
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    description = json['description'];
    employeePrice = json['employee_price'];
    etcPrice = json['etc_price'];
    hourWork = json['hour_work'];
    id = json['id'];
    includes = json['includes'];
    mainImage = json['main_image'];
    if (json['required_items'] != null) {
      requiredItems = <RequiredItems>[];
      json['required_items'].forEach((v) {
        requiredItems!.add(new RequiredItems.fromJson(v));
      });
    }
    serviceName = json['service_name'];
    servicePrice = json['service_price'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.additionalItems != null) {
      data['additional_items'] =
          this.additionalItems!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['description'] = this.description;
    data['employee_price'] = this.employeePrice;
    data['etc_price'] = this.etcPrice;
    data['hour_work'] = this.hourWork;
    data['id'] = this.id;
    data['includes'] = this.includes;
    data['main_image'] = this.mainImage;
    if (this.requiredItems != null) {
      data['required_items'] =
          this.requiredItems!.map((v) => v.toJson()).toList();
    }
    data['service_name'] = this.serviceName;
    data['service_price'] = this.servicePrice;
    data['total_price'] = this.totalPrice;
    return data;
  }
}

class AdditionalItems {
  String? description;
  int? id;
  String? itemName;
  int? maxQuantity;
  int? minQuantity;
  int? pricePerItem;

  AdditionalItems(
      {this.description,
      this.id,
      this.itemName,
      this.maxQuantity,
      this.minQuantity,
      this.pricePerItem});

  AdditionalItems.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    itemName = json['item_name'];
    maxQuantity = json['max_quantity'];
    minQuantity = json['min_quantity'];
    pricePerItem = json['price_per_item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    data['max_quantity'] = this.maxQuantity;
    data['min_quantity'] = this.minQuantity;
    data['price_per_item'] = this.pricePerItem;
    return data;
  }
}

class Category {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? categoryName;
  String? icon;
  String? description;

  Category(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.categoryName,
      this.icon,
      this.description});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryName = json['category_name'];
    icon = json['icon'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_name'] = this.categoryName;
    data['icon'] = this.icon;
    data['description'] = this.description;
    return data;
  }
}

class RequiredItems {
  String? description;
  int? id;
  String? itemName;
  int? pricePerItem;
  int? quantity;
  int? subtotal;

  RequiredItems(
      {this.description,
      this.id,
      this.itemName,
      this.pricePerItem,
      this.quantity,
      this.subtotal});

  RequiredItems.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    itemName = json['item_name'];
    pricePerItem = json['price_per_item'];
    quantity = json['quantity'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    data['price_per_item'] = this.pricePerItem;
    data['quantity'] = this.quantity;
    data['subtotal'] = this.subtotal;
    return data;
  }
}
