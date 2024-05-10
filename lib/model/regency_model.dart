class RegencyModel {
  int? provinceId;
  String? regency;

  RegencyModel({this.provinceId, this.regency});

  RegencyModel.fromJson(Map<String, dynamic> json) {
    provinceId = json['province_id'];
    regency = json['regency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province_id'] = this.provinceId;
    data['regency'] = this.regency;
    return data;
  }
}

// class RegencyModel {
//   String? message;
//   List<Datas>? datas;
//   Pagination? pagination;

//   RegencyModel({this.message, this.datas, this.pagination});

//   RegencyModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     if (json['datas'] != null) {
//       datas = <Datas>[];
//       json['datas'].forEach((v) {
//         datas!.add(new Datas.fromJson(v));
//       });
//     }
//     pagination = json['pagination'] != null
//         ? new Pagination.fromJson(json['pagination'])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.datas != null) {
//       data['datas'] = this.datas!.map((v) => v.toJson()).toList();
//     }
//     if (this.pagination != null) {
//       data['pagination'] = this.pagination!.toJson();
//     }
//     return data;
//   }
// }

// class Datas {
//   int? provinceId;
//   String? regency;

//   Datas({this.provinceId, this.regency});

//   Datas.fromJson(Map<String, dynamic> json) {
//     provinceId = json['province_id'];
//     regency = json['regency'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['province_id'] = this.provinceId;
//     data['regency'] = this.regency;
//     return data;
//   }
// }

// class Pagination {
//   int? previousPage;
//   int? currentPage;
//   int? nextPage;
//   int? maxPage;
//   String? query;

//   Pagination(
//       {this.previousPage,
//       this.currentPage,
//       this.nextPage,
//       this.maxPage,
//       this.query});

//   Pagination.fromJson(Map<String, dynamic> json) {
//     previousPage = json['previous_page'];
//     currentPage = json['current_page'];
//     nextPage = json['next_page'];
//     maxPage = json['max_page'];
//     query = json['query'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['previous_page'] = this.previousPage;
//     data['current_page'] = this.currentPage;
//     data['next_page'] = this.nextPage;
//     data['max_page'] = this.maxPage;
//     data['query'] = this.query;
//     return data;
//   }
// }
