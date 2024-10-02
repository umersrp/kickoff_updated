import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  /// vars
  var username = ''.obs;

  /// oninit
  @override
  void onInit() {
    super.onInit();
    getUsernameFromPrefs();
  }

  /// Function to get username from SharedPreferences
  Future<void> getUsernameFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('name') ?? 'Guest';
  }
}
