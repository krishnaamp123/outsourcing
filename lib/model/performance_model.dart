class PerformanceModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? updateEmailUser;
  int? placementId;
  Placement? placement;
  String? date;
  String? fiiledDate;
  List<Feedbacks>? feedbacks;

  PerformanceModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.updateEmailUser,
      this.placementId,
      this.placement,
      this.date,
      this.fiiledDate,
      this.feedbacks});

  PerformanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updateEmailUser = json['update_email_user'];
    placementId = json['placement_id'];
    placement = json['placement'] != null
        ? new Placement.fromJson(json['placement'])
        : null;
    date = json['date'];
    fiiledDate = json['fiiled_date'];
    if (json['feedbacks'] != null) {
      feedbacks = <Feedbacks>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(new Feedbacks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['update_email_user'] = this.updateEmailUser;
    data['placement_id'] = this.placementId;
    if (this.placement != null) {
      data['placement'] = this.placement!.toJson();
    }
    data['date'] = this.date;
    data['fiiled_date'] = this.fiiledDate;
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Placement {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? updateEmailUser;
  int? transactionId;
  int? supervisorId;
  int? regencyId;
  String? startDate;
  String? endDate;
  String? status;
  String? note;
  int? duration;
  int? totalEmployee;
  String? name;
  String? address;
  List<Details>? details;
  String? formGenerateSchedule;
  String? lastFormDate;
  Null? nextFormDate;
  Null? forms;

  Placement(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.updateEmailUser,
      this.transactionId,
      this.supervisorId,
      this.regencyId,
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

  Placement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updateEmailUser = json['update_email_user'];
    transactionId = json['transaction_id'];
    supervisorId = json['supervisor_id'];
    regencyId = json['regency_id'];
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
    forms = json['forms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['update_email_user'] = this.updateEmailUser;
    data['transaction_id'] = this.transactionId;
    data['supervisor_id'] = this.supervisorId;
    data['regency_id'] = this.regencyId;
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
    data['forms'] = this.forms;
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
  Category? category;
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
      this.category,
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
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
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
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
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

class Category {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? updateEmailUser;
  String? categoryName;
  String? icon;
  String? description;

  Category(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.updateEmailUser,
      this.categoryName,
      this.icon,
      this.description});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updateEmailUser = json['update_email_user'];
    categoryName = json['category_name'];
    icon = json['icon'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['update_email_user'] = this.updateEmailUser;
    data['category_name'] = this.categoryName;
    data['icon'] = this.icon;
    data['description'] = this.description;
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

class Feedbacks {
  int? id;
  String? createdAt;
  String? updatedAt;
  int? performanceFormId;
  Null? performanceForm;
  int? placementDetailEmployeeId;
  Employees? placementDetailEmployee;
  int? serviceUserId;
  Null? serviceUser;
  String? question;
  String? answer;
  int? rate;
  String? note;
  String? date;

  Feedbacks(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.performanceFormId,
      this.performanceForm,
      this.placementDetailEmployeeId,
      this.placementDetailEmployee,
      this.serviceUserId,
      this.serviceUser,
      this.question,
      this.answer,
      this.rate,
      this.note,
      this.date});

  Feedbacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    performanceFormId = json['performance_form_id'];
    performanceForm = json['performance_form_'];
    placementDetailEmployeeId = json['placement_detail_employee_id'];
    placementDetailEmployee = json['placement_detail_employee'] != null
        ? new Employees.fromJson(json['placement_detail_employee'])
        : null;
    serviceUserId = json['service_user_id'];
    serviceUser = json['service_user'];
    question = json['question'];
    answer = json['answer'];
    rate = json['rate'];
    note = json['note'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['performance_form_id'] = this.performanceFormId;
    data['performance_form_'] = this.performanceForm;
    data['placement_detail_employee_id'] = this.placementDetailEmployeeId;
    if (this.placementDetailEmployee != null) {
      data['placement_detail_employee'] =
          this.placementDetailEmployee!.toJson();
    }
    data['service_user_id'] = this.serviceUserId;
    data['service_user'] = this.serviceUser;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['rate'] = this.rate;
    data['note'] = this.note;
    data['date'] = this.date;
    return data;
  }
}
