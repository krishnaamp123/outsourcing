class User {
  String image;
  String name;
  String email;
  String phone;
  String alamat;

  // Constructor
  User({
    required this.image,
    required this.name,
    required this.email,
    required this.phone,
    required this.alamat,
  });

  User copy({
    String? imagePath,
    String? name,
    String? phone,
    String? email,
    String? alamat,
  }) =>
      User(
        image: imagePath ?? image,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        alamat: alamat ?? this.alamat,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        image: json['imagePath'],
        name: json['name'],
        email: json['email'],
        alamat: json['alamat'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': image,
        'name': name,
        'email': email,
        'alamat': alamat,
        'phone': phone,
      };
}
