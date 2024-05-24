class ServiceModel {
  int? id;
  String? serviceName;
  String? description;
  String? image;
  String? icon;
  int? basePrice;
  int? categoryId;
  Category? category;
  List<ServiceItems>? serviceItems;

  ServiceModel(
      {this.id,
      this.serviceName,
      this.description,
      this.image,
      this.icon,
      this.basePrice,
      this.categoryId,
      this.category,
      this.serviceItems});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    description = json['description'];
    image = json['image'];
    icon = json['icon'];
    basePrice = json['base_price'];
    categoryId = json['category_id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    if (json['service_items'] != null) {
      serviceItems = <ServiceItems>[];
      json['service_items'].forEach((v) {
        serviceItems!.add(new ServiceItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_name'] = this.serviceName;
    data['description'] = this.description;
    data['image'] = this.image;
    data['icon'] = this.icon;
    data['base_price'] = this.basePrice;
    data['category_id'] = this.categoryId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.serviceItems != null) {
      data['service_items'] =
          this.serviceItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? categoryName;
  String? icon;
  String? description;

  Category({this.id, this.categoryName, this.icon, this.description});

  Category.fromJson(Map<String, dynamic> json) {
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

class ServiceItems {
  int? id;
  String? itemName;
  String? description;
  int? minValue;
  int? maxValue;
  int? partialServiceId;
  int? pricePerItem;
  bool? isOptionalChoice;
  String? unit;

  ServiceItems(
      {this.id,
      this.itemName,
      this.description,
      this.minValue,
      this.maxValue,
      this.partialServiceId,
      this.pricePerItem,
      this.isOptionalChoice,
      this.unit});

  ServiceItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    description = json['description'];
    minValue = json['min_value'];
    maxValue = json['max_value'];
    partialServiceId = json['partial_service_id'];
    pricePerItem = json['price_per_item'];
    isOptionalChoice = json['is_optional_choice'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    data['description'] = this.description;
    data['min_value'] = this.minValue;
    data['max_value'] = this.maxValue;
    data['partial_service_id'] = this.partialServiceId;
    data['price_per_item'] = this.pricePerItem;
    data['is_optional_choice'] = this.isOptionalChoice;
    data['unit'] = this.unit;
    return data;
  }
}
