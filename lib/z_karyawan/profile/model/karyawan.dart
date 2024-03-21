class Karyawan {
  final String imagePath;
  final String name;
  final String email;
  final String alamat;
  final String telpon;
  final String nik;

  const Karyawan({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.alamat,
    required this.telpon,
    required this.nik,
  });

  Karyawan copy({
    String? imagePath,
    String? name,
    String? email,
    String? alamat,
    String? telpon,
    String? nik,
  }) =>
      Karyawan(
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        email: email ?? this.email,
        alamat: alamat ?? this.alamat,
        telpon: telpon ?? this.telpon,
        nik: nik ?? this.nik,
      );

  static Karyawan fromJson(Map<String, dynamic> json) => Karyawan(
        imagePath: json['imagePath'],
        name: json['name'],
        email: json['email'],
        alamat: json['alamat'],
        telpon: json['telpon'],
        nik: json['nik'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'name': name,
        'email': email,
        'alamat': alamat,
        'telpon': telpon,
        'nik': nik,
      };
}
