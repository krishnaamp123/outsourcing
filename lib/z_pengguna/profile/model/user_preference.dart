import 'dart:convert';

import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const myUser = User(
    imagePath:
        "https://upload.wikimedia.org/wikipedia/en/0/0b/Darth_Vader_in_The_Empire_Strikes_Back.jpg",
    name: 'Krishna Mahendra',
    email: 'krishnamahendra1234@gmail.com',
    alamat: 'Jl.Tukad Pancoran',
    telpon: '0895379245552',
    nik: '5178261827369173',
  );
}
// class UserData {
//   static late SharedPreferences _preferences;
//   static const _keyUser = 'user';

//   static User myUser = User(
//     image:
//         "https://upload.wikimedia.org/wikipedia/en/0/0b/Darth_Vader_in_The_Empire_Strikes_Back.jpg",
//     name: 'Krishna Mahendra',
//     email: 'krishnamahendra1234@gmail.com',
//     phone: '0895379245552',
//     alamat: 'Jl.Tukad Pancoran IID 14',
//   );

//   static Future init() async =>
//       _preferences = await SharedPreferences.getInstance();

//   static Future setUser(User user) async {
//     final json = jsonEncode(user.toJson());

//     await _preferences.setString(_keyUser, json);
//   }

//   static User getUser() {
//     final json = _preferences.getString(_keyUser);

//     return json == null ? myUser : User.fromJson(jsonDecode(json));
//   }
// }
