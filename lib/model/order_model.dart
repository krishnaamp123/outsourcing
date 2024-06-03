class OrderModel {
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

  OrderModel(
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

  OrderModel.fromJson(Map<String, dynamic> json) {
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
  int? totalEmployee;
  int? servicePrice;
  int? employeePrice;
  int? etcPrice;
  int? subTotalPrice;
  List<Etcs>? etcs;

  Details(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.transactionId,
      this.serviceId,
      this.totalEmployee,
      this.servicePrice,
      this.employeePrice,
      this.etcPrice,
      this.subTotalPrice,
      this.etcs});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    transactionId = json['transaction_id'];
    serviceId = json['service_id'];
    totalEmployee = json['total_employee'];
    servicePrice = json['service_price'];
    employeePrice = json['employee_price'];
    etcPrice = json['etc_price'];
    subTotalPrice = json['sub_total_price'];
    if (json['etcs'] != null) {
      etcs = <Etcs>[];
      json['etcs'].forEach((v) {
        etcs!.add(new Etcs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['transaction_id'] = this.transactionId;
    data['service_id'] = this.serviceId;
    data['total_employee'] = this.totalEmployee;
    data['service_price'] = this.servicePrice;
    data['employee_price'] = this.employeePrice;
    data['etc_price'] = this.etcPrice;
    data['sub_total_price'] = this.subTotalPrice;
    if (this.etcs != null) {
      data['etcs'] = this.etcs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Etcs {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? transactionDetailId;
  int? additionalItemServiceId;
  int? qty;
  int? price;
  int? subTotalPrice;

  Etcs(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.transactionDetailId,
      this.additionalItemServiceId,
      this.qty,
      this.price,
      this.subTotalPrice});

  Etcs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    transactionDetailId = json['transaction_detail_id'];
    additionalItemServiceId = json['additional_item_service_id'];
    qty = json['qty'];
    price = json['price'];
    subTotalPrice = json['sub_total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['transaction_detail_id'] = this.transactionDetailId;
    data['additional_item_service_id'] = this.additionalItemServiceId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['sub_total_price'] = this.subTotalPrice;
    return data;
  }
}
