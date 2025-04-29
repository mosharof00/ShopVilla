import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathprovider;
import 'package:shop_villa/helper/helper_utils.dart';


class HiveService {
  static var box;
  static var searchHistory;

  static initHive() async {
    var dir = await pathprovider.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('appData');
    searchHistory = await Hive.openBox('searchHistory');
  }

  /// User ID
  static setUserID(int id) {
    box.put('id', id);
  }

  static deleteUserID() {
    box.delete('id');
  }

  static Future<int?> getUserID() async {
    return await box.get('id');
  }

  /// User Token
  static setToken(String token) {
    box.put('token', token);
  }

  static deleteToken() {
    box.delete('token');
  }

  static Future<String?> getToken() async {
    return await box.get('token');
  }

  /// User Firebase token
  static setFirebaseToken(String firebaseToken) {
    box.put('firebaseToken', firebaseToken);
  }

  static deleteFirebaseToken() {
    box.delete('firebaseToken');
  }

  static Future<String?> getFirebaseToken() async {
    return await box.get('firebaseToken');
  }

  /// Is Alert Showed
  static bool getAlertShowed() {
    final lastShownDate = box?.get('alertLastShownDate');

    if (lastShownDate == null) {
      return false;
    }
    final now = DateTime.now();
    final difference = now.difference(lastShownDate).inDays;
    return difference < 1;
  }

  static void setAlertShowed(bool value) {
    if (value) {
      box?.put('alertLastShownDate', DateTime.now());
    } else {
      box?.delete('alertLastShownDate');
    }
  }
 /// Onboard Screen
  static Future<bool> getOnBoardShowed() async {
    return box?.get('onboard') ?? false;
  }

  static void setOnBoardShowed(bool value){
    if(value){
      box?.put('onboard', value);
    } else {
      box?.delete('onboard');
    }
  }

  static checkLoginStatus() async {
    int? id = await box.get('id');
    String? token = await box.get('token');
    if (id != null && token != null && token.isNotEmpty) {
      // Set the User is LoggedIn (Authentic User)
      HelperUtils.isLogin = true;
    } else {
      // Set the User is Guest (Unauthentic User)
      HelperUtils.isLogin = false;
    }
  }

  static setLanguage(String language) {
    box.put('language', language);
  }

  static getLanguage() {
    return box.get('language', defaultValue: 'en_en');
  }
}
