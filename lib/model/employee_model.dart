class EmployeeModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? profilePic;
  String? email;
  String? password;
  String? role;
  String? verifiedAt;
  EmployeeProfile? employeeProfile;

  EmployeeModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.profilePic,
      this.email,
      this.password,
      this.role,
      this.verifiedAt,
      this.employeeProfile});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePic = json['profile_pic'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    verifiedAt = json['verified_at'];
    employeeProfile = json['employee_profile'] != null
        ? new EmployeeProfile.fromJson(json['employee_profile'])
        : null;
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
    if (this.employeeProfile != null) {
      data['employee_profile'] = this.employeeProfile!.toJson();
    }
    return data;
  }
}

class EmployeeProfile {
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

  EmployeeProfile(
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

  EmployeeProfile.fromJson(Map<String, dynamic> json) {
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
