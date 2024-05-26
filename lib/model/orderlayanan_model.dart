class OrderLayananModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? updateEmailUser;
  int? serviceUserId;
  int? packageId;
  String? orderDate;
  int? contractDuration;
  String? startDate;
  int? regencyId;
  String? address;
  String? companyName;
  String? billingName;
  String? billingAddress;
  String? paymentMethod;
  int? totalPrice;
  int? totalPaid;
  String? status;
  String? nextPaymentDeadline;
  List<Details>? details;
  String? mou;

  OrderLayananModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.updateEmailUser,
      this.serviceUserId,
      this.packageId,
      this.orderDate,
      this.contractDuration,
      this.startDate,
      this.regencyId,
      this.address,
      this.companyName,
      this.billingName,
      this.billingAddress,
      this.paymentMethod,
      this.totalPrice,
      this.totalPaid,
      this.status,
      this.nextPaymentDeadline,
      this.details,
      this.mou});

  OrderLayananModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updateEmailUser = json['update_email_user'];
    serviceUserId = json['service_user_id'];
    packageId = json['package_id'];
    orderDate = json['order_date'];
    contractDuration = json['contract_duration'];
    startDate = json['start_date'];
    regencyId = json['regency_id'];
    address = json['address'];
    companyName = json['company_name'];
    billingName = json['billing_name'];
    billingAddress = json['billing_address'];
    paymentMethod = json['payment_method'];
    totalPrice = json['total_price'];
    totalPaid = json['total_paid'];
    status = json['status'];
    nextPaymentDeadline = json['next_payment_deadline'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
    mou = json['mou'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['update_email_user'] = this.updateEmailUser;
    data['service_user_id'] = this.serviceUserId;
    data['package_id'] = this.packageId;
    data['order_date'] = this.orderDate;
    data['contract_duration'] = this.contractDuration;
    data['start_date'] = this.startDate;
    data['regency_id'] = this.regencyId;
    data['address'] = this.address;
    data['company_name'] = this.companyName;
    data['billing_name'] = this.billingName;
    data['billing_address'] = this.billingAddress;
    data['payment_method'] = this.paymentMethod;
    data['total_price'] = this.totalPrice;
    data['total_paid'] = this.totalPaid;
    data['status'] = this.status;
    data['next_payment_deadline'] = this.nextPaymentDeadline;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    data['mou'] = this.mou;
    return data;
  }
}

class Details {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? transactionId;
  int? serviceId;
  Service? service;
  int? totalEmployee;
  int? servicePrice;
  int? employeePrice;
  int? etcPrice;
  int? subTotalPrice;

  Details(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.transactionId,
      this.serviceId,
      this.service,
      this.totalEmployee,
      this.servicePrice,
      this.employeePrice,
      this.etcPrice,
      this.subTotalPrice});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    transactionId = json['transaction_id'];
    serviceId = json['service_id'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    totalEmployee = json['total_employee'];
    servicePrice = json['service_price'];
    employeePrice = json['employee_price'];
    etcPrice = json['etc_price'];
    subTotalPrice = json['sub_total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['transaction_id'] = this.transactionId;
    data['service_id'] = this.serviceId;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['total_employee'] = this.totalEmployee;
    data['service_price'] = this.servicePrice;
    data['employee_price'] = this.employeePrice;
    data['etc_price'] = this.etcPrice;
    data['sub_total_price'] = this.subTotalPrice;
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
