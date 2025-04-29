import 'package:get/get.dart';
import '../../../services/json_read_service.dart';
class LanguageController extends GetxController {
  final count = 0.obs;
  final languageList = [].obs;
  final languageKeys = [].obs;
  final selectIndex = 0.obs;
  final selectedLanguageKey = ''.obs;
  final language = ''.obs;
  final country = ''.obs;


  @override
  void onInit() {
    ReadJsonFile.readJsonData(path: "assets/json/language.json").then((value) {
      languageList.value = value["data"];
    });
    super.onInit();
  }
}
