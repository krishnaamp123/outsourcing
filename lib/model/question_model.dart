class QuestionModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? updateEmailUser;
  String? question;
  String? hint;

  QuestionModel(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.updateEmailUser,
      this.question,
      this.hint});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    updateEmailUser = json['update_email_user'];
    question = json['question'];
    hint = json['hint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['update_email_user'] = this.updateEmailUser;
    data['question'] = this.question;
    data['hint'] = this.hint;
    return data;
  }
}
