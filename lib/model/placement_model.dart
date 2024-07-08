class PlacementModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? updateEmailUser;
  int? transactionId;
  int? supervisorId;
  Supervisor? supervisor;
  int? regencyId;
  Regency? regency;
  String? startDate;
  String? endDate;
  String? status;
  String? note;
  int? duration;
  int? totalEmployee;
  String? name;
  String? address;
  List<Details>? details;
  Null? formGenerateSchedule;
  Null? lastFormDate;
  Null? nextFormDate;
  List<Forms>? forms;

  PlacementModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.updateEmailUser,
      this.transactionId,
      this.supervisorId,
      this.supervisor,
      this.regencyId,
      this.regency,
      this.startDate,
      this.endDate,
      this.status,
      this.note,
      this.duration,
      this.totalEmployee,
      this.name,
      this.address,
      this.details,
      this.formGenerateSchedule,
      this.lastFormDate,
      this.nextFormDate,
      this.forms});

  PlacementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updateEmailUser = json['update_email_user'];
    transactionId = json['transaction_id'];
    supervisorId = json['supervisor_id'];
    supervisor = json['supervisor'] != null
        ? new Supervisor.fromJson(json['supervisor'])
        : null;
    regencyId = json['regency_id'];
    regency =
        json['regency'] != null ? new Regency.fromJson(json['regency']) : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    note = json['note'];
    duration = json['duration'];
    totalEmployee = json['total_employee'];
    name = json['name'];
    address = json['address'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
    formGenerateSchedule = json['form_generate_schedule'];
    lastFormDate = json['last_form_date'];
    nextFormDate = json['next_form_date'];
    if (json['forms'] != null) {
      forms = <Forms>[];
      json['forms'].forEach((v) {
        forms!.add(new Forms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['update_email_user'] = this.updateEmailUser;
    data['transaction_id'] = this.transactionId;
    data['supervisor_id'] = this.supervisorId;
    if (this.supervisor != null) {
      data['supervisor'] = this.supervisor!.toJson();
    }
    data['regency_id'] = this.regencyId;
    if (this.regency != null) {
      data['regency'] = this.regency!.toJson();
    }
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    data['note'] = this.note;
    data['duration'] = this.duration;
    data['total_employee'] = this.totalEmployee;
    data['name'] = this.name;
    data['address'] = this.address;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    data['form_generate_schedule'] = this.formGenerateSchedule;
    data['last_form_date'] = this.lastFormDate;
    data['next_form_date'] = this.nextFormDate;
    if (this.forms != null) {
      data['forms'] = this.forms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Supervisor {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? userId;
  User? user;
  String? fullname;
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
  Null? status;

  Supervisor(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.user,
      this.fullname,
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
      this.status});

  Supervisor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    fullname = json['fullname'];
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
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['fullname'] = this.fullname;
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
    data['status'] = this.status;
    return data;
  }
}

class User {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? profilePic;
  String? email;
  String? password;
  String? role;
  String? verifiedAt;

  User(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.profilePic,
      this.email,
      this.password,
      this.role,
      this.verifiedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePic = json['profile_pic'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    verifiedAt = json['verified_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile_pic'] = this.profilePic;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    data['verified_at'] = this.verifiedAt;
    return data;
  }
}

class Regency {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? provinceId;
  String? regency;

  Regency(
      {this.id, this.createdAt, this.updatedAt, this.provinceId, this.regency});

  Regency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    provinceId = json['province_id'];
    regency = json['regency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['province_id'] = this.provinceId;
    data['regency'] = this.regency;
    return data;
  }
}

class Details {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? placementId;
  int? serviceId;
  Service? service;
  int? totalEmployee;
  int? filled;
  List<Employees>? employees;
  int? salary;

  Details(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.placementId,
      this.serviceId,
      this.service,
      this.totalEmployee,
      this.filled,
      this.employees,
      this.salary});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    placementId = json['placement_id'];
    serviceId = json['service_id'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    totalEmployee = json['total_employee'];
    filled = json['filled'];
    if (json['employees'] != null) {
      employees = <Employees>[];
      json['employees'].forEach((v) {
        employees!.add(new Employees.fromJson(v));
      });
    }
    salary = json['salary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['placement_id'] = this.placementId;
    data['service_id'] = this.serviceId;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['total_employee'] = this.totalEmployee;
    data['filled'] = this.filled;
    if (this.employees != null) {
      data['employees'] = this.employees!.map((v) => v.toJson()).toList();
    }
    data['salary'] = this.salary;
    return data;
  }
}

class Service {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  String? serviceName;
  String? description;
  String? includes;
  int? employeePrice;
  int? servicePrice;
  int? etcPrice;
  int? totalPrice;
  int? hourWork;

  Service(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.categoryId,
      this.serviceName,
      this.description,
      this.includes,
      this.employeePrice,
      this.servicePrice,
      this.etcPrice,
      this.totalPrice,
      this.hourWork});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    serviceName = json['service_name'];
    description = json['description'];
    includes = json['includes'];
    employeePrice = json['employee_price'];
    servicePrice = json['service_price'];
    etcPrice = json['etc_price'];
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
    data['description'] = this.description;
    data['includes'] = this.includes;
    data['employee_price'] = this.employeePrice;
    data['service_price'] = this.servicePrice;
    data['etc_price'] = this.etcPrice;
    data['total_price'] = this.totalPrice;
    data['hour_work'] = this.hourWork;
    return data;
  }
}

class Employees {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? updateEmailUser;
  int? placementDetailId;
  int? employeeId;
  Employee? employee;
  String? status;
  String? placementDate;
  String? startDate;
  String? endDate;
  int? duration;
  int? expectedSalary;
  int? expectedSalaryTotal;
  Null? complaints;
  Null? performanceFormFeedbacks;

  Employees(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.updateEmailUser,
      this.placementDetailId,
      this.employeeId,
      this.employee,
      this.status,
      this.placementDate,
      this.startDate,
      this.endDate,
      this.duration,
      this.expectedSalary,
      this.expectedSalaryTotal,
      this.complaints,
      this.performanceFormFeedbacks});

  Employees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updateEmailUser = json['update_email_user'];
    placementDetailId = json['placement_detail_id'];
    employeeId = json['employee_id'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    status = json['status'];
    placementDate = json['placement_date'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    duration = json['duration'];
    expectedSalary = json['expected_salary'];
    expectedSalaryTotal = json['expected_salary_total'];
    complaints = json['complaints'];
    performanceFormFeedbacks = json['performance_form_feedbacks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['update_email_user'] = this.updateEmailUser;
    data['placement_detail_id'] = this.placementDetailId;
    data['employee_id'] = this.employeeId;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    data['status'] = this.status;
    data['placement_date'] = this.placementDate;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['duration'] = this.duration;
    data['expected_salary'] = this.expectedSalary;
    data['expected_salary_total'] = this.expectedSalaryTotal;
    data['complaints'] = this.complaints;
    data['performance_form_feedbacks'] = this.performanceFormFeedbacks;
    return data;
  }
}

class Employee {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? userId;
  User? user;
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
      this.user,
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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
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

class Forms {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? updateEmailUser;
  int? placementId;
  Null? placement;
  String? date;
  String? fiiledDate;
  Null? feedbacks;

  Forms(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.updateEmailUser,
      this.placementId,
      this.placement,
      this.date,
      this.fiiledDate,
      this.feedbacks});

  Forms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updateEmailUser = json['update_email_user'];
    placementId = json['placement_id'];
    placement = json['placement'];
    date = json['date'];
    fiiledDate = json['fiiled_date'];
    feedbacks = json['feedbacks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['update_email_user'] = this.updateEmailUser;
    data['placement_id'] = this.placementId;
    data['placement'] = this.placement;
    data['date'] = this.date;
    data['fiiled_date'] = this.fiiledDate;
    data['feedbacks'] = this.feedbacks;
    return data;
  }
}
