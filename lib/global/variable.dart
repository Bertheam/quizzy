import 'package:shared_preferences/shared_preferences.dart';

class Variable{
  String apiUrl  = "https://7065-41-73-105-228.ngrok-free.app/api";
  String mainUrl = "https://7065-41-73-105-228.ngrok-free.app/";


  Future<void> saveApiKey(String apiKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('apiKey');
    await prefs.setString('apiKey', apiKey);
  }
  Future<void> saveAuthUserId(int authUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('authUserId');
    await prefs.setInt('authUserId', authUserId);
  }

  Future<String?> getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('apiKey');
  }
  Future<int?> getAuthUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('authUserId');
  }
}
