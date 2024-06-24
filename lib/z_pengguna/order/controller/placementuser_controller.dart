import 'dart:convert';
import 'package:get/get.dart';
import 'package:outsourcing/model/placementuser_model.dart';
import 'package:outsourcing/service/placementuser_service.dart';

class PlacementUserController extends GetxController implements GetxService {
  var listPlacementUser = <PlacementUserModel>[].obs;
  final placementuser = PlacementUserService();
  var isLoading = false.obs;
  late String userId;

  // Method untuk mengatur ID pengguna
  void setUserId(String id) {
    userId = id;
    getPlacementUser();
  }

  Future<void> getPlacementUser() async {
    isLoading.value = true;
    try {
      var response = await placementuser.getPlacementUser(userId);
      var responsedecode = jsonDecode(response.body);

      // Check if the 'data' field exists and is not null
      if (responsedecode.containsKey('data') &&
          responsedecode['data'] != null) {
        listPlacementUser.clear();

        // Convert 'data' object to PlacementUserModel
        PlacementUserModel data =
            PlacementUserModel.fromJson(responsedecode['data']);
        listPlacementUser.add(data);
      } else {
        throw Exception("'data' field is missing or null");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
