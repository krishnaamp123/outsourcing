class FeedbackModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? updateEmailUser;
  int? serviceUserId;
  ServiceUser? serviceUser;
  int? transactionId;
  Transaction? transaction;
  int? review;
  String? comment;

  FeedbackModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.updateEmailUser,
      this.serviceUserId,
      this.serviceUser,
      this.transactionId,
      this.transaction,
      this.review,
      this.comment});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updateEmailUser = json['update_email_user'];
    serviceUserId = json['service_user_id'];
    serviceUser = json['service_user'] != null
        ? new ServiceUser.fromJson(json['service_user'])
        : null;
    transactionId = json['transaction_id'];
    transaction = json['transaction'] != null
        ? new Transaction.fromJson(json['transaction'])
        : null;
    review = json['review'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['update_email_user'] = this.updateEmailUser;
    data['service_user_id'] = this.serviceUserId;
    if (this.serviceUser != null) {
      data['service_user'] = this.serviceUser!.toJson();
    }
    data['transaction_id'] = this.transactionId;
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.toJson();
    }
    data['review'] = this.review;
    data['comment'] = this.comment;
    return data;
  }
}

class ServiceUser {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? fullname;
  int? regencyId;
  Null? regency;
  String? fullAddress;
  String? birthPlace;
  String? birthDate;
  String? nik;
  String? gender;
  String? phone;

  ServiceUser(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.fullname,
      this.regencyId,
      this.regency,
      this.fullAddress,
      this.birthPlace,
      this.birthDate,
      this.nik,
      this.gender,
      this.phone});

  ServiceUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    fullname = json['fullname'];
    regencyId = json['regency_id'];
    regency = json['regency'];
    fullAddress = json['full_address'];
    birthPlace = json['birth_place'];
    birthDate = json['birth_date'];
    nik = json['nik'];
    gender = json['gender'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['fullname'] = this.fullname;
    data['regency_id'] = this.regencyId;
    data['regency'] = this.regency;
    data['full_address'] = this.fullAddress;
    data['birth_place'] = this.birthPlace;
    data['birth_date'] = this.birthDate;
    data['nik'] = this.nik;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    return data;
  }
}

class Transaction {
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
  Null? dpStatus;
  Null? terminStatus;
  String? nextPaymentDeadline;

  Transaction(
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
      this.dpStatus,
      this.terminStatus,
      this.nextPaymentDeadline});

  Transaction.fromJson(Map<String, dynamic> json) {
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
    dpStatus = json['dp_status'];
    terminStatus = json['termin_status'];
    nextPaymentDeadline = json['next_payment_deadline'];
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
    data['dp_status'] = this.dpStatus;
    data['termin_status'] = this.terminStatus;
    data['next_payment_deadline'] = this.nextPaymentDeadline;
    return data;
  }
}
