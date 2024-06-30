class ServiceUserModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? profilePic;
  String? email;
  String? password;
  String? role;
  String? verifiedAt;
  ServiceUserProfile? serviceUserProfile;

  ServiceUserModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.profilePic,
      this.email,
      this.password,
      this.role,
      this.verifiedAt,
      this.serviceUserProfile});

  ServiceUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePic = json['profile_pic'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    verifiedAt = json['verified_at'];
    serviceUserProfile = json['service_user_profile'] != null
        ? new ServiceUserProfile.fromJson(json['service_user_profile'])
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
    if (this.serviceUserProfile != null) {
      data['service_user_profile'] = this.serviceUserProfile!.toJson();
    }
    return data;
  }
}

class ServiceUserProfile {
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

  ServiceUserProfile(
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

  ServiceUserProfile.fromJson(Map<String, dynamic> json) {
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
