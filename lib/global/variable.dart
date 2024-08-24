import 'package:shared_preferences/shared_preferences.dart';

class Variable{
  String apiUrl  = "https://7164-2001-42c0-8124-6800-30e6-8f2b-9df4-f1e0.ngrok-free.app/api";
  String mainUrl = "https://7164-2001-42c0-8124-6800-30e6-8f2b-9df4-f1e0.ngrok-free.app/";


  Future<void> saveApiKey(int apiKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('apiKey', apiKey);
  }
  Future<void> saveAuthUserId(int authUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('authUserId', authUserId);
  }

  Future<int?> getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('apiKey');
  }
  Future<int?> getAuthUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('authUserId');
  }
}
