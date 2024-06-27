class ComplaintModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? updateEmailUser;
  int? serviceUserId;
  ServiceUser? serviceUser;
  int? placementEmployeeId;
  PlacementEmployee? placementEmployee;
  int? employeeId;
  Employee? employee;
  String? comment;
  List<Replies>? replies;

  ComplaintModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.updateEmailUser,
      this.serviceUserId,
      this.serviceUser,
      this.placementEmployeeId,
      this.placementEmployee,
      this.employeeId,
      this.employee,
      this.comment,
      this.replies});

  ComplaintModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updateEmailUser = json['update_email_user'];
    serviceUserId = json['service_user_id'];
    serviceUser = json['service_user'] != null
        ? new ServiceUser.fromJson(json['service_user'])
        : null;
    placementEmployeeId = json['placement_employee_id'];
    placementEmployee = json['placement_employee'] != null
        ? new PlacementEmployee.fromJson(json['placement_employee'])
        : null;
    employeeId = json['employee_id'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    comment = json['comment'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies!.add(new Replies.fromJson(v));
      });
    }
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
    data['placement_employee_id'] = this.placementEmployeeId;
    if (this.placementEmployee != null) {
      data['placement_employee'] = this.placementEmployee!.toJson();
    }
    data['employee_id'] = this.employeeId;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    data['comment'] = this.comment;
    if (this.replies != null) {
      data['replies'] = this.replies!.map((v) => v.toJson()).toList();
    }
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

class PlacementEmployee {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? updateEmailUser;
  int? placementDetailId;
  int? employeeId;
  String? status;
  String? placementDate;
  String? startDate;
  String? endDate;
  int? duration;
  int? expectedSalary;
  int? expectedSalaryTotal;
  Null? complaints;

  PlacementEmployee(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.updateEmailUser,
      this.placementDetailId,
      this.employeeId,
      this.status,
      this.placementDate,
      this.startDate,
      this.endDate,
      this.duration,
      this.expectedSalary,
      this.expectedSalaryTotal,
      this.complaints});

  PlacementEmployee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updateEmailUser = json['update_email_user'];
    placementDetailId = json['placement_detail_id'];
    employeeId = json['employee_id'];
    status = json['status'];
    placementDate = json['placement_date'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    duration = json['duration'];
    expectedSalary = json['expected_salary'];
    expectedSalaryTotal = json['expected_salary_total'];
    complaints = json['complaints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['update_email_user'] = this.updateEmailUser;
    data['placement_detail_id'] = this.placementDetailId;
    data['employee_id'] = this.employeeId;
    data['status'] = this.status;
    data['placement_date'] = this.placementDate;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['duration'] = this.duration;
    data['expected_salary'] = this.expectedSalary;
    data['expected_salary_total'] = this.expectedSalaryTotal;
    data['complaints'] = this.complaints;
    return data;
  }
}

class Employee {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? fullname;
  int? categoryId;
  Null? category;
  int? regencyId;
  Null? regency;
  String? fullAddress;
  String? birthPlace;
  String? birthDate;
  String? nik;
  String? npwp;
  String? gender;
  bool? marriageStatus;
  String? phone;
  String? lastEducation;
  String? ijazah;
  String? fieldCertification;
  Null? status;

  Employee(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.fullname,
      this.categoryId,
      this.category,
      this.regencyId,
      this.regency,
      this.fullAddress,
      this.birthPlace,
      this.birthDate,
      this.nik,
      this.npwp,
      this.gender,
      this.marriageStatus,
      this.phone,
      this.lastEducation,
      this.ijazah,
      this.fieldCertification,
      this.status});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    fullname = json['fullname'];
    categoryId = json['category_id'];
    category = json['category'];
    regencyId = json['regency_id'];
    regency = json['regency'];
    fullAddress = json['full_address'];
    birthPlace = json['birth_place'];
    birthDate = json['birth_date'];
    nik = json['nik'];
    npwp = json['npwp'];
    gender = json['gender'];
    marriageStatus = json['marriage_status'];
    phone = json['phone'];
    lastEducation = json['last_education'];
    ijazah = json['ijazah'];
    fieldCertification = json['field_certification'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['fullname'] = this.fullname;
    data['category_id'] = this.categoryId;
    data['category'] = this.category;
    data['regency_id'] = this.regencyId;
    data['regency'] = this.regency;
    data['full_address'] = this.fullAddress;
    data['birth_place'] = this.birthPlace;
    data['birth_date'] = this.birthDate;
    data['nik'] = this.nik;
    data['npwp'] = this.npwp;
    data['gender'] = this.gender;
    data['marriage_status'] = this.marriageStatus;
    data['phone'] = this.phone;
    data['last_education'] = this.lastEducation;
    data['ijazah'] = this.ijazah;
    data['field_certification'] = this.fieldCertification;
    data['status'] = this.status;
    return data;
  }
}

class Replies {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? updateEmailUser;
  int? supervisorId;
  int? complaintId;
  String? reply;

  Replies(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.updateEmailUser,
      this.supervisorId,
      this.complaintId,
      this.reply});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updateEmailUser = json['update_email_user'];
    supervisorId = json['supervisor_id'];
    complaintId = json['complaint_id'];
    reply = json['reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['update_email_user'] = this.updateEmailUser;
    data['supervisor_id'] = this.supervisorId;
    data['complaint_id'] = this.complaintId;
    data['reply'] = this.reply;
    return data;
  }
}
