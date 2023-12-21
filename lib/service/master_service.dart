import 'package:outsourcing/global.dart';
import 'package:outsourcing/service/token.dart';
import 'package:http/http.dart' as http;

class MasterService {
  Future<http.Response> showMyMasters() async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var token = localStorage.getString('token')?.replaceAll('"', "");
    var token = await getToken();
    var url = Uri.parse(baseURL + 'master/categories');
    http.Response response = await http.get(url, headers: setHeaders(token));
    print(response.body);
    return response;
  }
}
