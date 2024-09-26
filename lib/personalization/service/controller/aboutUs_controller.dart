import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  var token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadToken();
  }

  Future<void> saveToken(String newToken) async {
    token.value = newToken;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', newToken);
  }

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('authToken') ?? '';
  }

  Future<void> clearToken() async {
    token.value = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }
}
