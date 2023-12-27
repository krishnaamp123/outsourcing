class OrderModel {
  int? id;
  int? serviceUserId;
  int? purchasePrice;
  int? totalDiscount;
  int? totalPrice;
  int? totalItem;
  String? date;
  int? contractDuration;
  String? startDate;
  String? address;
  String? buyerNote;
  String? paymentType;
  String? status;
  String? mou;
  int? servicePackageId;
  ServiceUser? serviceUser;
  List<OrderDetails>? orderDetails;

  OrderModel(
      {this.id,
      this.serviceUserId,
      this.purchasePrice,
      this.totalDiscount,
      this.totalPrice,
      this.totalItem,
      this.date,
      this.contractDuration,
      this.startDate,
      this.address,
      this.buyerNote,
      this.paymentType,
      this.status,
      this.mou,
      this.servicePackageId,
      this.serviceUser,
      this.orderDetails});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceUserId = json['service_user_id'];
    purchasePrice = json['purchase_price'];
    totalDiscount = json['total_discount'];
    totalPrice = json['total_price'];
    totalItem = json['total_item'];
    date = json['date'];
    contractDuration = json['contract_duration'];
    startDate = json['start_date'];
    address = json['address'];
    buyerNote = json['buyer_note'];
    paymentType = json['payment_type'];
    status = json['status'];
    mou = json['mou'];
    servicePackageId = json['service_package_id'];
    serviceUser = json['service_user'] != null
        ? new ServiceUser.fromJson(json['service_user'])
        : null;
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_user_id'] = this.serviceUserId;
    data['purchase_price'] = this.purchasePrice;
    data['total_discount'] = this.totalDiscount;
    data['total_price'] = this.totalPrice;
    data['total_item'] = this.totalItem;
    data['date'] = this.date;
    data['contract_duration'] = this.contractDuration;
    data['start_date'] = this.startDate;
    data['address'] = this.address;
    data['buyer_note'] = this.buyerNote;
    data['payment_type'] = this.paymentType;
    data['status'] = this.status;
    data['mou'] = this.mou;
    data['service_package_id'] = this.servicePackageId;
    if (this.serviceUser != null) {
      data['service_user'] = this.serviceUser!.toJson();
    }
    if (this.orderDetails != null) {
      data['order_details'] =
          this.orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceUser {
  int? id;
  String? address;
  String? fullname;
  String? identityCardNumber;
  String? phone;

  ServiceUser(
      {this.id,
      this.address,
      this.fullname,
      this.identityCardNumber,
      this.phone});

  ServiceUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    fullname = json['fullname'];
    identityCardNumber = json['identity_card_number'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['fullname'] = this.fullname;
    data['identity_card_number'] = this.identityCardNumber;
    data['phone'] = this.phone;
    return data;
  }
}

class OrderDetails {
  int? id;
  int? serviceOrderId;
  int? partialServiceId;
  int? servicePrice;
  int? additionalPrice;
  int? totalPrice;
  List<OrderDetailItems>? orderDetailItems;
  PartialService? partialService;

  OrderDetails(
      {this.id,
      this.serviceOrderId,
      this.partialServiceId,
      this.servicePrice,
      this.additionalPrice,
      this.totalPrice,
      this.orderDetailItems,
      this.partialService});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceOrderId = json['service_order_id'];
    partialServiceId = json['partial_service_id'];
    servicePrice = json['service_price'];
    additionalPrice = json['additional_price'];
    totalPrice = json['total_price'];
    if (json['order_detail_items'] != null) {
      orderDetailItems = <OrderDetailItems>[];
      json['order_detail_items'].forEach((v) {
        orderDetailItems!.add(new OrderDetailItems.fromJson(v));
      });
    }
    partialService = json['partial_service'] != null
        ? new PartialService.fromJson(json['partial_service'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_order_id'] = this.serviceOrderId;
    data['partial_service_id'] = this.partialServiceId;
    data['service_price'] = this.servicePrice;
    data['additional_price'] = this.additionalPrice;
    data['total_price'] = this.totalPrice;
    if (this.orderDetailItems != null) {
      data['order_detail_items'] =
          this.orderDetailItems!.map((v) => v.toJson()).toList();
    }
    if (this.partialService != null) {
      data['partial_service'] = this.partialService!.toJson();
    }
    return data;
  }
}

class OrderDetailItems {
  int? id;
  int? serviceOrderDetailId;
  int? partialServiceItemId;
  int? value;
  int? itemPrice;
  int? totalPrice;
  PartialServiceItem? partialServiceItem;

  OrderDetailItems(
      {this.id,
      this.serviceOrderDetailId,
      this.partialServiceItemId,
      this.value,
      this.itemPrice,
      this.totalPrice,
      this.partialServiceItem});

  OrderDetailItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceOrderDetailId = json['service_order_detail_id'];
    partialServiceItemId = json['partial_service_item_id'];
    value = json['value'];
    itemPrice = json['item_price'];
    totalPrice = json['total_price'];
    partialServiceItem = json['partial_service_item'] != null
        ? new PartialServiceItem.fromJson(json['partial_service_item'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_order_detail_id'] = this.serviceOrderDetailId;
    data['partial_service_item_id'] = this.partialServiceItemId;
    data['value'] = this.value;
    data['item_price'] = this.itemPrice;
    data['total_price'] = this.totalPrice;
    if (this.partialServiceItem != null) {
      data['partial_service_item'] = this.partialServiceItem!.toJson();
    }
    return data;
  }
}

class PartialServiceItem {
  int? id;
  String? itemName;
  String? description;
  int? minValue;
  int? maxValue;
  int? partialServiceId;
  int? pricePerItem;
  bool? isOptionalChoice;
  String? unit;

  PartialServiceItem(
      {this.id,
      this.itemName,
      this.description,
      this.minValue,
      this.maxValue,
      this.partialServiceId,
      this.pricePerItem,
      this.isOptionalChoice,
      this.unit});

  PartialServiceItem.fromJson(Map<String, dynamic> json) {
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

class PartialService {
  int? id;
  String? serviceName;
  String? description;
  String? image;
  String? icon;
  int? basePrice;
  int? categoryId;
  Null? serviceItems;

  PartialService(
      {this.id,
      this.serviceName,
      this.description,
      this.image,
      this.icon,
      this.basePrice,
      this.categoryId,
      this.serviceItems});

  PartialService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    description = json['description'];
    image = json['image'];
    icon = json['icon'];
    basePrice = json['base_price'];
    categoryId = json['category_id'];
    serviceItems = json['service_items'];
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
    data['service_items'] = this.serviceItems;
    return data;
  }
}
